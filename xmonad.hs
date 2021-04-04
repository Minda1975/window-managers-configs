import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig  -- add keybindings easily
import XMonad.Layout.NoBorders
import XMonad.Layout.FixedColumn
import XMonad.Layout.Dishes


main = 
  xmonad $ desktopConfig {
  --                     
  layoutHook = smartBorders $ Full ||| FixedColumn 1 20 80 10 ||| Dishes 2 (1/6) 
  , terminal = "alacritty"
  , modMask  = mod4Mask
  , normalBorderColor  = "#0d0c12"
  , focusedBorderColor = "#46A4BA"
  , borderWidth = 2
  } `additionalKeysP`
  [ ("M-S-f",    spawn "firefox-esr")
  , ("M-S-p", spawn "rofi -combi-modi window,run -show combi -modi combi")
  ]
    
                                                
      
