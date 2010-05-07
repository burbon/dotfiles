import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.Grid
 
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "Pidgin"    --> doFloat
    ]
 
main = do
    xmproc <- spawnPipe "/home/bc5042/bin/xmobar /home/bc5042/.xmobarrc"
    xmonad $ defaultConfig {
        terminal = "urxvt", 
        modMask = mod4Mask,     -- Rebind Mod to the Windows key
        borderWidth = 1,
        focusFollowsMouse = False,
        --workspaces = ["code", "web", "im"] ++ map show [4..9],

        manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig,
        logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        } `additionalKeys` [
            ((mod4Mask .|. shiftMask, xK_z), spawn "gnome-screensaver-command --lock"),
            ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
            ((0, xK_Print), spawn "scrot")
        ]



