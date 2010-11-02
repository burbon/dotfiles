import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Cross

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Hooks.SetWMName
 
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "Pidgin" --> doFloat

    , className =? "Namoroka" --> doShift "2"
    , className =? "Opera" --> doShift "2"

    , className =? "Pidgin" --> doShift "3"

    , className =? "Shredder" --> doShift "4"
    , className =? "Lanikai" --> doShift "4"

    , className =? "Sonata" --> doShift "5"

    , className =? "Krusader" --> doShift "6"

    , className =? "MPlayer" --> doShift "7"
    ]
 
--myLayoutHook = Full ||| Accordion

myLayoutHook = avoidStruts ( Full ||| smartBorders Full ||| Tall 1 0.03 0.5 ||| Accordion ||| simpleTabbed ||| Grid ||| simpleCross )

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/burbon/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
        --, layoutHook = avoidStruts  $  layoutHook defaultConfig
        , layoutHook = myLayoutHook
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , startupHook = setWMName "LG3D"
        , terminal = "urxvt"
        , focusFollowsMouse = False
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]

