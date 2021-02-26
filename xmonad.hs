import XMonad hiding ( (|||) )  -- don't use the normal ||| operator
import XMonad.Layout.LayoutCombinators   -- use the one from LayoutCombinators instead
import XMonad.Util.EZConfig  -- add keybindings easily
import XMonad.Layout.NoBorders
import XMonad.Layout.Groups.Examples
import XMonad.Layout.SimplestFloat


main = xmonad myConfig

myConfig = def {
  --                     
  layoutHook = smartBorders $ rowOfColumns ||| simplestFloat
  , terminal = "urxvtc"
  , modMask  = mod4Mask
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#ff69b4"
  , borderWidth = 2
  } `additionalKeysP`
  [ ("M-<F1>",         sendMessage $ JumpToLayout "SimplestFloat")
  , ("M-M1-<Left>",    zoomWindowOut)
  , ("M-M1-C-<Right>", zoomWindowIn)
  , ("M-M1-C-<Up>",    zoomWindowReset)
  , ("M-M1-C-<Down>",  toggleWindowFull)
  ]
    
                                                
      
