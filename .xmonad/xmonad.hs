-- base
import XMonad
import qualified XMonad.StackSet as W
import Data.Monoid
import System.Exit
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.ManageDocks
-- Actions
import XMonad.Actions.Minimize
import XMonad.Actions.NoBorders
-- Layouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows
import XMonad.Layout.Spacing
-- Utilities
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig

myTerminal :: String
myTerminal = "kitty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth :: Dimension
myBorderWidth   = 2

myNormalBorderColor :: String
myNormalBorderColor  = "#7893ad"

myFocusedBorderColor :: String
myFocusedBorderColor = "lightgrey"

myModMask :: KeyMask
myModMask = mod4Mask

myWorkspaces = ["1", "2", "3", "4", "5"]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- DEFAULT KEYBINDINGS

    `additionalKeysP`
    [ -- terminal
      ("M-Return", spawn $ XMonad.terminal conf)

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
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

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

    -- MY CUSTOM KEYBINDINGS
    `additionalKeysP`
    [ -- control volume with volume keys
      ("0x1008FF11", spawn "amixer -q sset Master 2%-")
    , ("0x1008FF13", spawn "amixer -q sset Master 2%+")

      -- control volume with fn keys
    , ("M-F5", spawn "amixer -q sset Master 2%-")
    , ("M-F6", spawn "amixer -q sset Master 2%+")

      -- control brightness with brightness keys
    , ("xF86XK_MonBrightnessUp", spawn "lux -a 10%"),
    , ("xF86XK_MonBrightnessDown", spawn "lux -s 10%")

      -- control brightness with fn keys
    , ("M-F8", spawn "lux -a 10%")
    , ("M-F7", spawn "lux -s 10%")

    -- Open XMonad Config file in VIM
    , ("C-M1-semicolon", spawn "kitty vim ~/.xmonad/xmonad.hs")

    -- Open qutebrowser
    , ("M-f", spawn "qutebrowser")

    -- Open Firefox
    , ("M-S-f", spawn "firefox")

    -- Open File Explorer
    , ("M-e", spawn "kitty sh -c vifm")

    -- Open Doom eMacs
    , ("M-S-e", spawn "emacs")

    -- Open pcmanfm
    , ("M-S-semicolon", spawn "pcmanfm")

    -- Take screenshot
    , ("M-Print", spawn "flameshot gui")

    -- Toggle border of currently focused window
    , ("M-g", withFocused toggleBorder)

    -- Increase spacing around windows
    , ("M-S-equal", incSpacing 2)

    -- Toggle border of currently focused window
    , ("M-minus", setSpacing 5)

    -- Minimize window
    , ("M-m", withFocused minimizeWindow)

    -- Maximize the last minimized window
    , ("M-S-m", withLastMinimized maximizeWindowAndFocus)

    -- Shut down
    , ("M-F1", spawn "shutdown now")

    -- Reboot
    , ("M-F2", spawn "reboot")

    -- Suspend
    , ("M-F3", spawn "systemctl suspend")

    -- Turn display off
    , ("M-M1-Home", spawn "sleep 0.8; xset dpms force off")
    ]

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

myLayout = avoidStruts(smartBorders(boringWindows(minimize(smartSpacingWithEdge 5 $ tiled)||| Mirror tiled ||| Full)))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
	, manageDocks
	, fullscreenManageHook
	]

myEventHook = composeAll
	[ fullscreenEventHook,
	  docksEventHook
	]

myLogHook = return ()

myStartupHook = do
	spawn "feh --bg-scale /home/shawn/Pictures/wallpaper.png"
	spawn "xsetroot -cursor_name Left_ptr"
	spawn "blueman-applet"

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
