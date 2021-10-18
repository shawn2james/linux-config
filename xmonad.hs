-- IMPORTS ------------------------------------------------------------------------
-- default
import XMonad
import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- custom imports
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Util.Run
import XMonad.Layout.NoBorders
import XMonad.Actions.NoBorders
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows
import XMonad.Actions.Minimize

-- GENERAL ------------------------------------------------------------------------
myTerminal      = "kitty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 1
myNormalBorderColor  = "#7893ad"
myFocusedBorderColor = "#ff7f50"

myModMask       = mod4Mask
myWorkspaces = ["1", "2", "3", "4", "5"]

-- KEYBINDINGS --------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- dmenu
    , ((modm, xK_p     ), spawn "dmenu_run -l 15")

    -- close focused window
    , ((modm .|. shiftMask, xK_c), kill)

     -- Rotate through the available layout algorithms
    , ((modm, xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm, xK_n), refresh)

    -- Move focus to the next window
    , ((modm, xK_Tab), windows W.focusDown)

    -- Move focus to the next window
    , ((modm, xK_j), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm, xK_k), windows W.focusUp  )

    -- Move focus to the master window
    -- , ((modm, xK_m), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k), windows W.swapUp    )

    -- Shrink the master area
    , ((modm, xK_h), sendMessage Shrink)

    -- Expand the master area
    , ((modm, xK_l), sendMessage Expand)

    -- Push window back into tiling
    , ((modm, xK_t), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm, xK_comma), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]

    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

	++

	[ ((0, 0x1008FF11), spawn "amixer -q sset Master 2%-"),
      ((0, 0x1008FF13), spawn "amixer -q sset Master 2%+"),
	  ((modm, xK_F5), spawn "amixer -q sset Master 2%-"),
      ((modm, xK_F6), spawn "amixer -q sset Master 2%+"),
	  ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%"),
	  ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%"),
	  ((modm, xK_F8), spawn "lux -a 10%"),
	  ((modm, xK_F7), spawn "lux -s 10%")
	]
	
	++

	[ -- Open XMonad Config file in VIM
	  ((controlMask .|. mod1Mask, xK_semicolon), spawn "kitty vim /home/shawn/.config/xmonad/xmonad.hs"),
	  -- Open qutebrowser
	  ((modm, xK_f), spawn "qutebrowser"),
	  -- Open Firefox
	  ((modm .|. shiftMask, xK_f), spawn "firefox"),
	  -- Open File Explorer
	  ((modm, xK_e), spawn "kitty sh -c vifm"),
	  -- Take screenshot
	  ((modm, xK_Print), spawn "flameshot gui")
	]

	++

	[ -- Toggle border of currently focused window 
	  ((modm, xK_g), withFocused toggleBorder),
	-- Minimize window
	  ((modm, xK_m), withFocused minimizeWindow),
	-- Maximize the last minimized window
      ((modm .|. shiftMask, xK_m), withLastMinimized maximizeWindowAndFocus)
	]
	

	++

	[ -- Shut down
	  ((modm, xK_F1), spawn "shutdown now"),
	  -- Reboot
	  ((modm, xK_F2), spawn "reboot"),
	  -- Suspend
	  ((modm, xK_F3), spawn "systemctl suspend"),
	  -- Turn display off
	  ((modm .|.  mod1Mask, xK_Home), spawn "sleep 0.8; xset dpms force off")
	]



-- MOUSE BINDINGS ------------------------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

-- LAYOUTS -------------------------------------------------------------------------
myLayout = avoidStruts ( smartBorders( boringWindows (minimize(tiled)||| Mirror tiled ||| Full)))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


-- WINDOW RULES --------------------------------------------------------------------
myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
	, manageDocks
	, fullscreenManageHook
	]

-- EVENT HANDLING ------------------------------------------------------------------
myEventHook = composeAll
	[ fullscreenEventHook,
	  docksEventHook 
	]

-- STATUS BARS AND LOGGING ---------------------------------------------------------
myLogHook = return ()

-- STARTUP -------------------------------------------------------------------------
myStartupHook = do 
				spawn "feh --bg-scale /home/shawn/Downloads/wallpaper.webp"

-- RUNNING XMONAD WITH THE ABOVE CONFIGURATIONS ------------------------------------
main = do
		xmproc <- spawnPipe "xmobar /home/shawn/.config/xmobar/xmobarrc; xmonad --restart"
		xmproc <- spawnPipe "picom"
		xmonad $ docks $ fullscreenSupport defaults
defaults = def {
	  -- general
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook <+> manageDocks,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }



-----------------------------------------------------------------------------


-- a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
