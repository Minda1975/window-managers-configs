import XMonad
import XMonad.Config.Desktop
import XMonad.Util.CustomKeys
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.GridSelect
import XMonad.Actions.DwmPromote
import XMonad.Actions.NoBorders

main = xmonad desktopConfig { keys = customKeys delkeys inskeys }
    where
      delkeys :: XConfig l -> [(KeyMask, KeySym)]
      delkeys XConfig {modMask = modm} =
          [ (modm .|. shiftMask, xK_Return) -- > terminal
          , (modm .|. shiftMask, xK_c)      -- > close the focused window
          ]
          ++
          [ (modm .|. m, k) | m <- [0, shiftMask], k <- [xK_w, xK_e, xK_r] ]

      inskeys :: XConfig l -> [((KeyMask, KeySym), X ())]
      inskeys conf@(XConfig {modMask = modm}) =
          [ ((mod1Mask,             xK_F2  ), spawn $ terminal conf) -- mod1-f2 %! Run a terminal emulator
          , ((modm,                 xK_Delete), kill) -- %! Close the focused window
          , ((mod1Mask,             xK_F1 ), spawn "/home/mindaugas/.scripts/osd-time")
          , ((mod1Mask,             xK_F3 ), spawn "/home/mindaugas/.scripts/osd-sensors")
          , ((mod1Mask,             xK_F11 ), spawn "i3lock") -- %! Lock the screen
          , ((modm,                 xK_Return), dwmpromote)
          , ((modm, xK_Tab),        cycleRecentWS [xK_Alt_L] xK_Tab xK_grave)
          , ((modm,                 xK_g ),   withFocused toggleBorder)
          , ((modm,                 xK_w), goToSelected def)
          , ((modm,                 xK_s), spawnSelected def ["xterm","firefox-esr","pcmanfm","emacs","transmission-gtk"])
          , ((mod1Mask,             xK_Down), spawn "rofi -show run -sidebar-mode -lines 1") -- %! launcher
          , ((mod1Mask,             xK_Up  ), spawn "firefox-esr")
          ]


