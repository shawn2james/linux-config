-- base
import XMonad
import qualified XMonad.StackSet as W
import Data.Monoid
import System.Exit
import qualified Data.Map as M
import XMonad.Hooks.ManageHelpers(doRectFloat, Side (C))
--DATA
import Data.Maybe (fromJust)
-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
-- Actions
import XMonad.Actions.Minimize
import XMonad.Actions.NoBorders
-- Layouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
-- Utilities
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce

myTerminal :: String
myTerminal = "alacritty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth :: Dimension
myBorderWidth   = 1

myNormalBorderColor :: String
myNormalBorderColor  = "#7893ad"

myFocusedBorderColor :: String
myFocusedBorderColor = "lightgrey"

myModMask :: KeyMask
myModMask = mod4Mask

-- myWorkspaces = [" α ", " β ", " γ ", " δ ", " ε ", " ζ ", " η "]
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 "]

windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ -- terminal
      ((modm, xK_Return), spawn $ XMonad.terminal conf)


    -- close focused window
    , ((modm .|. shiftMask, xK_c), kill)

    --  Reset the layouts on the current workspace to default
    -- , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

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
    , ((modm .|. shiftMask, xK_q), io exitSuccess)

    -- Restart xmonad
    , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
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

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList 

    -- Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster)

    -- Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster)
    ]

myLayout = avoidStruts(smartBorders(boringWindows(minimize(gaps [(U,9), (R,9), (D,9), (L,9)] (tiled ||| Mirror tiled ||| Full)))))
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
        [ className =? "confirm" --> doFloat
        , className =? "file_progress" --> doFloat
        , className =? "mpv" --> doFloat
        , className =? "dialog" --> doFloat
        , className =? "download" --> doFloat
        , className =? "notification" --> doFloat
        , className =? "toolbar" --> doFloat
        , className =? "splash" --> doFloat
        , appName =? "Steam - News" --> doFloat
        , appName =? "Picture-in-Picture" --> doRectFloat (W.RationalRect 0.05 0.05 0.2 0.2)
        , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  
        , manageDocks
        , fullscreenManageHook
        ]

myEventHook = composeAll
	[ fullscreenEventHook,
		docksEventHook
	]

myLogHook xmproc = dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP
              -- the following variables beginning with 'pp' are settings for xmobar.
              { ppOutput = hPutStrLn xmproc                          -- xmobar on monitor 1
              , ppCurrent = xmobarColor "black" "" . wrap  "<fc=black,lightblue>" "</fc>"         -- Current workspace
              , ppVisible = xmobarColor "#c792ea" "" . clickable              -- Visible but not current workspace
              , ppHidden = xmobarColor "black" "" . wrap "<fc=black,#daa520>" "</fc>" . clickable -- Hidden workspaces
              -- , ppHiddenNoWindows = xmobarColor "#82AAFF" ""  . clickable     -- Hidden workspaces (no windows)
              , ppTitle = xmobarColor "#b3afc2" "" . shorten 60               -- Title of active window
              , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
              , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
              , ppExtras  = [windowCount]                                     -- # of windows current workspace
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
              }

myStartupHook = do
            spawnOnce "nitrogen --restore &"
            spawnOnce "alacritty -e neomutt"
            spawnOnce "blueman-applet &"
            spawnOnce "xsetroot -cursor_name Left_ptr &"

defaults xmproc = def {
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
        startupHook        = myStartupHook,
        logHook            = myLogHook xmproc
        }

main = do
		xmproc <- spawnPipe "xmobar /home/shawn/.config/xmobar/xmobarrc; xmonad --restart"
		picomproc<- spawnPipe "picom"
		xmonad $ docks $ fullscreenSupport (defaults xmproc)

                               -- MY CUSTOM KEYBINDINGS
                               `additionalKeysP`
                                [ -- control volume with volume keys
								 ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%-")
                               , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+")

                                -- control volume with fn keys
                               , ("M-<F5>", spawn "amixer -q sset Master 2%-")
                               , ("M-<F6>", spawn "amixer -q sset Master 2%+")

                                --- control brightness with brightness keys
                               , ("<XF86MonBrightnessUp>", spawn "lux -a 10%")
                               , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")

                               -- control brightness with fn keys
                               , ("M-<F8>", spawn "lux -a 10%")
                               , ("M-<F7>", spawn "lux -s 10%")

                               -- Open XMonad Config file in VS Code
                               , ("M-p e", spawn "confedit")

                               -- Open qutebrowser
                               , ("M-f", spawn "qutebrowser")

                               -- Open Firefox
                               , ("M-S-f", spawn "firefox")

                               -- Open File Explorer
                               , ("M-e", spawn "alacritty -e ranger")

                               -- Open pcmanfm
                               , ("M-S-e", spawn "pcmanfm")

                               -- Take screenshot
                               , ("M-<Print>", spawn "flameshot gui")

                               -- Toggle border of currently focused window
                               , ("M-g", withFocused toggleBorder)

                               -- Minimize window
                               , ("M-m", withFocused minimizeWindow)

                               -- Maximize the last minimized window
                               , ("M-S-m", withLastMinimized maximizeWindowAndFocus)

                               -- Shut down
                               , ("M-p q", spawn "sysexit")

                               -- Run 'connect' script
                               , ("M-p c", spawn "connect")

                               -- Open gotop
                               , ("C-M1-<Delete>", spawn "alacritty -e gotop")

                               -- Open emacs
                               , ("M-S-v", spawn "emacsclient -c")

                               -- Run dm-websearch
                               , ("M-S-s", spawn "dm-websearch")

                               -- download youtube playlist
                               , ("M-p y", spawn "ytwatch")

                               -- open neomutt
                               , ("M-S-n", spawn "alacritty -e neomutt")

                               -- Toggle the gap around windows
                               , ("M-S-g", sendMessage ToggleGaps)

                               -- Run dmenu
                               , ("M-<Space>", spawn "dmenu_run -i -h 28 -y 0 -p 'Run: '")

                               -- Cycle through the layouts
                               , ("M-S-<Space>", sendMessage NextLayout)

                               -- open fzf in terminal
                               , ("M-S-p", spawn "alacritty -e nvim $(fzf)")

                               -- disable touchpad
                               , ("M-<F10>", spawn "xinput disable 20")
                               , ("<XF86TouchpadToggle>", spawn "xinput disable 20")
                             ]
