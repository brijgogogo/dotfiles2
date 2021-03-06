import XMonad
import Data.Monoid
import System.IO
-- import System.Exit

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicBars
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook, ewmh)
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Prompt.ConfirmPrompt
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
-- import XMonad.Hooks.Minimize

import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders (smartBorders, noBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows  as BW
import XMonad.Actions.Minimize

-- keys
import Graphics.X11.ExtraTypes.XF86

-- Data
import qualified Data.Map as M
import qualified XMonad.StackSet as W

-- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
-- import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.Run -- for spawnPipe and hPutStrLn
import XMonad.Util.SpawnOnce

main = do
  xmonad $ docks $ ewmh defaults
  -- xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
  -- xmonad $ docks $ ewmh def


myFont :: String
myFont = "xft:Liberation Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myBrowser :: String
myBrowser = "firefox"  -- Sets qutebrowser as browser

myBorderWidth :: Dimension
myBorderWidth = 0           -- Sets border width for windows

myNormColor :: String
myNormColor   = "#282c34"   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#46d9ff"   -- Border color of focused windows

-- Color of current window title in xmobar.
xmobarTitleColor = "#168aad"
-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#2a9d8f" -- "#8ab6d6"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- virtual screens
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

-- myLayout = minimize (tiled) ||| Mirror tiled ||| Full
myLayout = minimize (BW.boringWindows (tiled ||| Mirror tiled ||| Full))
  where
    -- tiled = spacing 5 $ Tall nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 2/3
    delta = 5/100

-- Window rules
-- get property name associated with a program, run below then click window
-- xprop | grep WM_CLASS
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "mpv"            --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , stringProperty "_NET_WM_NAME" =? "Emulator" --> doFloat
    , isFullscreen                  --> doFullFloat
    ]
-- composeAll: automatically combine every item in the list with the <+> operator

myKeys :: [(String, X ())]
myKeys =
  [
  ("<XF86AudioRaiseVolume>",  spawn "master_vol_inc")
  , ("<XF86AudioLowerVolume>",  spawn "master_vol_dec")
  , ("<XF86AudioMute>",         spawn "master_vol_mute")
  , ("<XF86AudioPlay>", spawn "playerctl play-pause")
  , ("<XF86AudioPrev>", spawn "playerctl previous")
  , ("<XF86AudioNext>", spawn "playerctl next")
  , ("<XF86MonBrightnessUp>",   spawn "backlightinc")
  , ("<XF86MonBrightnessDown>", spawn "backlightdec")

  , ("M-S-p", spawn "screenshot")

  , ("M-,", spawn "firefox")
  -- , ("M-w", spawn "alacritty -e 'openwiki'")
  -- , ("M-v", spawn "alacritty -e 'nvim'")
  , ("M-s", spawn "launch_dmenu")
  , ("M-m", withFocused minimizeWindow)
  , ("M-S-m", withLastMinimized maximizeWindowAndFocus)
  , ("M-j", BW.focusUp) -- skips minimized  windows
  , ("M-k", BW.focusDown) -- skips minimized windows
  , ("M-S-<Space>", sendMessage ToggleStruts) -- toggles struts, thereby allows windows to draw over xmobar/panel
  -- , ("M-m", BW.focusMaster)

  -- Switch to single screen mode
  -- , ((modMask .|. mod1Mask, xK_1), spawn "xrandr --output DP1 --off")

  -- Switch to dual screen mode
  -- , ((modMask .|. mod1Mask, xK_2), spawn "xrandr --output DP1 --auto --above eDP1 && feh --bg-tile ~/.xmonad/wallpaper.jpg")

  -- ("M-<Return>", spawn (myTerminal))
  -- , ("M-S-q", confirmPrompt defaultXPConfig "exit" $ io exitSuccess)
  -- , ((0, xF86XK_PowerDown),         spawn "sudo pm-suspend")
  ]

xmobarCreate :: DynamicStatusBar
xmobarCreate (S sid) = spawnPipe $ "xmobar ~/.config/xmobar/xmobarrc --screen " ++ show sid

xmobarDestroy :: DynamicStatusBarCleanup
xmobarDestroy = return ()

-- https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Hooks-DynamicLog.html#v:dynamicLogWithPP
-- https://github.com/krzysz00/dotfiles/blob/master/xmonad/xmonad.hs
myPP = xmobarPP {
    -- ppCurrent = \x -> "<fc=green>" ++ x ++ "</fc>"
    ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "[" "]"
    , ppHidden = id
    -- , ppUrgent = \x -> "<fc=red>" ++ x ++ "</fc>"
    , ppUrgent  = xmobarColor "#ff69b4" ""
    -- , ppSep = " | "
    , ppSep = xmobarColor "#545454" "" " | " -- before title
    , ppWsSep = " "
    , ppTitle = shorten 40
    -- , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
    , ppOrder = \(w:_:t:_) -> [w,t] -- showing only workspace and title
    -- , ppLayout = const "" -- to disable the layout info on xmobar
}

myPPInactive = myPP {
    -- ppCurrent = \x -> "<fc=cyan>" ++ x ++ "</fc>"
    ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "[" "]"
}

defaults =
  def {
    terminal    = myTerminal
    , modMask     = myModMask
    , workspaces = myWorkspaces
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormColor
    , focusedBorderColor = myFocusColor
    -- , startupHook = setWMName "LG3D"
    , startupHook = docksStartupHook
                      >> dynStatusBarStartup xmobarCreate xmobarDestroy
                      >> startupHook def
    , handleEventHook =
        docksEventHook <+>
        dynStatusBarEventHook xmobarCreate xmobarDestroy <+>
        fullscreenEventHook <+>
        -- minimizeEventHook <+>
        handleEventHook def
    , layoutHook = smartBorders(avoidStruts $ myLayout)
    -- avoidStruts: no window is allowed in panel
    -- smartBorders: doesn't draw borders on windows that seem fullscreened
    -- , layoutHook = avoidStruts $ myLayout
    , manageHook = manageDocks <+> myManageHook  <+> manageHook def
    , logHook = do
        logHook def
        multiPP myPP myPPInactive
  } `additionalKeysP` myKeys

