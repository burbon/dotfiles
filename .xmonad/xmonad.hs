-- Imports.
import XMonad
-- statusBar
import XMonad.Hooks.DynamicLog
-- additional keys
import qualified Data.Map as M
-- for two screens
import XMonad.Layout.TwoPane
import XMonad.Layout.LayoutScreens
-- layout hook
import XMonad.Layout.BinarySpacePartition (emptyBSP)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Layout.Grid
import XMonad.Layout.Combo
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation
-- prompt
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell
-- handle exit
import System.Exit

-- import XMonad.Util.Paste


-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
-- myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
-- myPP = xmobarPP { ppCurrent = wrap "<" ">" }
myPP = xmobarPP
    -- { ppOutput = hPutStrLn xmproc
    -- , ppTitle = xmobarColor "green" "" . shorten 50
    -- }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {modMask = modm} = (modm, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig
    { modMask = mod4Mask
    , terminal = "urxvt"
    , layoutHook = myLayouts
    , manageHook = myManageHook <+> manageHook def
    , keys = myKeys <+> keys defaultConfig
    , focusFollowsMouse = False
    }

myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (3/5) []
        ||| emptyBSP
        ||| Grid
        ||| windowNavigation (combined)
        ||| TwoPane 0.03 0.5
    combined = combineTwo (TwoPane 0.03 0.5) (tabbed shrinkText def) (tabbed shrinkText def)
    -- combined = combineTwo (TwoPane 0.03 0.5) (Full) (Full)

myManageHook = composeAll
    [ className =? "Gimp"        --> doFloat
    , className =? "Vncviewer"   --> doFloat
    , className =? "Pidgin"      --> doFloat
    , className =? "Skype"       --> doFloat

    , className =? "Firefox"     --> doShift "2"
    , className =? "Opera"       --> doShift "2"
    , className =? "Thunderbird" --> doShift "4"

    , className =? "Pidgin"      --> doShift "3"
    , className =? "Skype"       --> doShift "5"

    , className =? "Sonata"      --> doShift "6"

    , className =? "Krusader"    --> doShift "7"

    , className =? "MPlayer"     --> doShift "8"]

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [ ((modm, xK_c), kill)
    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_space), layoutScreens 2 (TwoPane (3/100) (1/2)))
    , ((modm .|. controlMask .|. shiftMask, xK_space), rescreen)
    , ((modm, xK_Escape), sendMessage (Toggle "Full"))
    , ((modm, xK_i), spawn "clipmenu")
    , ((modm, xK_o), shellPrompt myXPConfig)
    , ((modm .|. shiftMask, xK_q), confirmPrompt myXPConfig "exit" (io exitSuccess))
    , ((modm .|. shiftMask, xK_b), spawn "sleep 0.1; xset dpms force off")
    , ((modm .|. shiftMask, xK_l), spawn "slock & (sleep 0.1 && xset dpms force off)")
    -- , ((0, xK_Insert), pasteSelection)
    , ((modm,                 xK_Right), sendMessage $ Go R)
    , ((modm,                 xK_Left ), sendMessage $ Go L)
    , ((modm,                 xK_Up   ), sendMessage $ Go U)
    , ((modm,                 xK_Down ), sendMessage $ Go D)
    , ((modm .|. controlMask, xK_Right), sendMessage $ Swap R)
    , ((modm .|. controlMask, xK_Left ), sendMessage $ Swap L)
    , ((modm .|. controlMask, xK_Up   ), sendMessage $ Swap U)
    , ((modm .|. controlMask, xK_Down ), sendMessage $ Swap D)
   , ((modm .|. controlMask .|. shiftMask, xK_Right), sendMessage $ Move R)
   , ((modm .|. controlMask .|. shiftMask, xK_Left ), sendMessage $ Move L)
   , ((modm .|. controlMask .|. shiftMask, xK_Up   ), sendMessage $ Move U)
   , ((modm .|. controlMask .|. shiftMask, xK_Down ), sendMessage $ Move D)
    ]

myXPConfig = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  , font              = "xft:Terminus:size=9"
  }
