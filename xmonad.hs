import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig  -- add keybindings easily
import XMonad.Layout.NoBorders
import XMonad.Layout.Groups.Examples
import XMonad.Layout.Spiral


main = 
  xmonad $ desktopConfig {
  --                     
  layoutHook = smartBorders $ rowOfColumns ||| spiral (6/7)
  , terminal = "alacritty"
  , modMask  = mod4Mask
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#ff69b4"
  , borderWidth = 2
  } `additionalKeysP`
  [ ("M-M1-<Left>",    zoomWindowOut)
  , ("M-M1-C-<Right>", zoomWindowIn)
  , ("M-M1-C-<Up>",    zoomWindowReset)
  , ("M-M1-C-<Down>",  toggleWindowFull)
  , ("M-S-p", spawn "rofi -combi-modi window,run -show combi -modi combi")
  ]
    
                                                
      
