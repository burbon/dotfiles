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
    , keys = myKeys <+> keys defaultConfig
    , focusFollowsMouse = False
    }

myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (3/5) [] ||| emptyBSP ||| Grid

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [ ((modm, xK_c), kill)
    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_space), layoutScreens 2 (TwoPane 0.5 0.5))
    , ((modm .|. controlMask .|. shiftMask, xK_space), rescreen)
    , ((modm, xK_Escape), sendMessage (Toggle "Full"))
    , ((modm, xK_i), spawn "clipmenu")
    , ((modm, xK_o), shellPrompt myXPConfig)
    , ((modm .|. shiftMask, xK_q), confirmPrompt myXPConfig "exit" (io exitSuccess))
    -- , ((0, xK_Insert), pasteSelection)
    ]

myXPConfig = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  , font              = "xft:Terminus:size=9"
  }
