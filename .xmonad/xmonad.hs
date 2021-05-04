import XMonad
import qualified XMonad.StackSet as W
import System.IO

-- Hooks
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Prompt.ConfirmPrompt
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

-- keys
import Graphics.X11.ExtraTypes.XF86

-- Data
import qualified Data.Map as M

-- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser "  -- Sets qutebrowser as browser

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String
myNormColor   = "#282c34"   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#46d9ff"   -- Border color of focused windows

-- Color of current window title in xmobar.
xmobarTitleColor = "#3d84b8"
-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#8ab6d6"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

-- layout hook
-- myLayoutHook = avoidStruts $ layoutHook defaultConfig
myLayoutHook = avoidStruts $ layoutHook def

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

  -- ("M-<Return>", spawn (myTerminal))
  -- , ("M-S-q", confirmPrompt defaultXPConfig "exit" $ io exitSuccess)
  -- , ((0, xF86XK_PowerDown),         spawn "sudo pm-suspend")
  ]

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
  --xmonad $ ewmh def
  xmonad $ docks def
    { terminal    = myTerminal
    , modMask     = myModMask
    , workspaces = myWorkspaces
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormColor
    , focusedBorderColor = myFocusColor
    , layoutHook = myLayoutHook
    , manageHook = manageDocks <+> manageHook def
    , logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = "   "
      }
    } `additionalKeysP` myKeys




