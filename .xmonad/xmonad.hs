import XMonad
import Data.Monoid
import System.IO
-- import System.Exit

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Prompt.ConfirmPrompt
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName

import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

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
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

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

-- layout hook
-- myLayoutHook = avoidStruts $ layoutHook defaultConfig
myLayoutHook = avoidStruts $ layoutHook def

-- Window rules
-- get property name associated with a program, run below then click window
-- xprop | grep WM_CLASS
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "mpv"           --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , stringProperty "_NET_WM_NAME" =? "Emulator" --> doFloat
    ]
    -- , isFullscreen                  --> doFullFloat]

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

  -- ("M-<Return>", spawn (myTerminal))
  -- , ("M-S-q", confirmPrompt defaultXPConfig "exit" $ io exitSuccess)
  -- , ((0, xF86XK_PowerDown),         spawn "sudo pm-suspend")
  ]

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
  --xmonad $ ewmh def
  -- xmonad $ docks def
  xmonad $ docks $ ewmh def
    { terminal    = myTerminal
    , modMask     = myModMask
    , workspaces = myWorkspaces
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormColor
    , focusedBorderColor = myFocusColor

    , handleEventHook = handleEventHook def <+> fullscreenEventHook
    , layoutHook = myLayoutHook
    , manageHook = manageDocks <+> manageHook def
    , logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "" ""
          , ppUrgent  = xmobarColor "#ff69b4" ""
          -- , ppSep = "   "
          , ppSep = xmobarColor "#545454" "" " | " -- before title
          , ppLayout = const "" -- to disable the layout info on xmobar
      }
    } `additionalKeysP` myKeys




