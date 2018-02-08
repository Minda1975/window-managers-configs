{- xmonad.hs
 - Author: Jelle van der Waa ( jelly12gen )
 -}
 
-- Import stuff
import XMonad
import qualified XMonad.StackSet as W 
import qualified Data.Map as M
import XMonad.Util.EZConfig(additionalKeys)
import System.Exit
import Graphics.X11.Xlib
import System.IO
 
 
-- actions
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Actions.GridSelect

 
-- utils
import XMonad.Util.Scratchpad (scratchpadSpawnAction, scratchpadManageHook, scratchpadFilterOutWorkspace)
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.Prompt 		as P
import XMonad.Prompt.Shell
import XMonad.Prompt
 
 
-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
 
-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
import XMonad.Layout.FixedColumn
import XMonad.Layout.Dishes
 
-- Data.Ratio for IM layout
import Data.Ratio ((%))
 
 
-- Main --
main = do
        xmproc <- spawnPipe "xmobar"  -- start xmobar
    	xmonad 	$ withUrgencyHook NoUrgencyHook $ def
        	{ manageHook = myManageHook
        	, layoutHook = myLayoutHook  
		, borderWidth = myBorderWidth
		, normalBorderColor = myNormalBorderColor
		, focusedBorderColor = myFocusedBorderColor
		, keys = myKeys
		, logHook = myLogHook xmproc
        	, modMask = myModMask  
        	, terminal = myTerminal
		, workspaces = myWorkspaces
                , focusFollowsMouse = False
		}
 
 
 
-- hooks
-- automaticly switching app to workspace 
myManageHook :: ManageHook
myManageHook = scratchpadManageHook (W.RationalRect 0.25 0.375 0.5 0.35) <+> ( composeAll . concat $
                [[isFullscreen                  --> doFullFloat
		, className =? "libreoffice-startcenter" --> doShift "5:doc" 
		, className =?  "Xmessage" 	--> doCenterFloat 
		, className =?  "Zenity" 	--> doCenterFloat 
		, className =? "feh" 	--> doCenterFloat 
                , className =? "Viewnior"           --> doShift "9:pic"
                , className =? "Gimp"           --> doShift "9:pic"
                , className =? "Links"           --> doShift "2:web"
                , className =? "Geany"           --> doShift "3:code"
                , className =? "Chromium"           --> doShift "2:web"
                , className =? "smplayer"	--> doShift "8:vid"
		, className =? "Audacious"	--> doShift "6:music"
		, className =? "Leafpad" 		--> doShift "4:paper"]
		 
		]
                        )  <+> manageDocks
 
 
 
--logHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }
 
 
 
---- Looks --
---- bar
customPP :: PP
customPP = def     { 
     			    ppHidden = xmobarColor "#ADDFFF" ""
			  , ppCurrent = xmobarColor "#ADDFFF" "" . wrap "[" "]"
			  , ppUrgent = xmobarColor "#8C001A" "" . wrap "*" "*"
                          , ppLayout = xmobarColor "#DC506A" ""
                          , ppTitle = xmobarColor "#ADDFFF" "" . shorten 80
                          , ppSep = "<fc=#DC506A> | </fc>"
                     }
 
-- some nice colors for the prompt windows to match the dzen status bar.
myXPConfig = def                                   
    { 
	font  = "-*-terminus-*-*-*-*-12-*-*-*-*-*-*-u" 
	,fgColor = "#ADDFFF"
	, bgColor = "#000000"
	, bgHLight    = "#000000"
	, fgHLight    = "#8C001A"
	, position = Top
    }
 
--- My Theme For Tabbed layout
myTheme = def           { decoHeight = 14
                        , activeColor = "#ADDFFF"
                        , activeBorderColor = "#ADDFFF"
                        , activeTextColor = "#000000"
                        , inactiveBorderColor = "#000000"
                        }
 
--LayoutHook
myLayoutHook  =  onWorkspace "1:chat" imLayout $  onWorkspace "2:web" webL $  onWorkspace "9:pic" standardLayouts $ onWorkspace "6:vbox" standardLayouts $ onWorkspace "6:music" fullL $ onWorkspace "8:vid" fullL $ standardLayouts 
   where
	standardLayouts =   avoidStruts  $ (tiled |||  reflectTiled ||| Mirror tiled ||| Grid ||| Full ||| FixedColumn 1 20 80 10 ||| Dishes 2 (1/6)) 
 
        --Layouts
	tiled     = smartBorders (ResizableTall 1 (2/100) (1/2) [])
        reflectTiled = (reflectHoriz tiled)
	tabLayout = (tabbed shrinkText myTheme)
	full 	  = noBorders Full
 
        --Im Layout
        imLayout = avoidStruts $ smartBorders $ withIM ratio pidginRoster $ reflectHoriz $ withIM skypeRatio skypeRoster (tiled ||| reflectTiled ||| Grid ||| FixedColumn 1 20 80 10) where
                chatLayout      = Grid
	        ratio = (1%9)
                skypeRatio = (1%8)
                pidginRoster    = And (ClassName "Pidgin") (Role "buddy_list")
                skypeRoster     = (ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "Chats")) `And` (Not (Role "CallWindowForm"))
 
	--Gimp Layout
	--gimpL = avoidStruts $ smartBorders $ withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full 
 
	--Web Layout
	webL      = avoidStruts $  tabLayout  ||| tiled ||| reflectHoriz tiled |||  full ||| FixedColumn 1 20 80 10
 
        --VirtualLayout
        fullL = avoidStruts $ standardLayouts
 
 
 
 
 
-------------------------------------------------------------------------------
---- Terminal --
myTerminal :: String
myTerminal = "urxvtc"
 
-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
myModMask :: KeyMask
myModMask = mod4Mask
 
 
 
-- borders
myBorderWidth :: Dimension
myBorderWidth = 1
--  
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = "#850047"
myFocusedBorderColor = "#ADDFFF"
--
 
 
--Workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:chat", "2:web", "3:code", "4:paper", "5:doc", "6:music" ,"7:other", "8:vid", "9:pic"] 
--
 
-- Switch to the "web" workspace
viewWeb = windows (W.greedyView "2:web")                           -- (0,0a)
--
 
 
 
-- keys
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- killing programs
    [ ((modMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask, xK_c ), kill)
 
    -- opening program launcher / search engine
    ,((modMask , xK_p), shellPrompt myXPConfig)
 
 
    -- GridSelect
    , ((modMask, xK_g), goToSelected def)
 
    -- layouts
    , ((modMask, xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask, xK_b ), sendMessage ToggleStruts)
 
    -- floating layer stuff
    , ((modMask, xK_t ), withFocused $ windows . W.sink)
 
    -- refresh'
    , ((modMask, xK_n ), refresh)
 
    -- focus
    , ((modMask, xK_Tab ), windows W.focusDown)
    , ((modMask, xK_j ), windows W.focusDown)
    , ((modMask, xK_k ), windows W.focusUp)
    , ((modMask, xK_m ), windows W.focusMaster)
 
 
    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )
 
    -- increase or decrease number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))
 
    -- resizing
    , ((modMask, xK_h ), sendMessage Shrink)
    , ((modMask, xK_l ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)
 
     
    -- scratchpad
    , ((modMask , xK_grave), scratchpadSpawnAction def  {terminal = myTerminal}) 
 
     
    --Programs
    , ((modMask .|.  shiftMask, xK_u ), spawn "pcmanfm")
    , ((modMask .|.  shiftMask, xK_p ), spawn "audacious")
    , ((modMask .|.  shiftMask, xK_b ), spawn "chromium")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
 
    --Lock The Screen
    , ((modMask .|.  shiftMask, xK_l ), spawn "slock")

    --Power
    , ((modMask .|.  shiftMask, xK_F11 ), spawn "systemctl reboot")
    , ((modMask .|.  shiftMask, xK_F12 ), spawn "systemctl poweroff")

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask , xK_q ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
