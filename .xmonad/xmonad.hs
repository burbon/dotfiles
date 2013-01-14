import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName

import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Cross

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

import System.IO

import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane

 
myManageHook = composeAll
    [
        className =? "Gimp"      --> doFloat,
        className =? "Vncviewer" --> doFloat,
        className =? "Pidgin" --> doFloat,
        className =? "Skype" --> doFloat,

        className =? "Firefox" --> doShift "2",
        className =? "Opera" --> doShift "2",
        className =? "Thunderbird" --> doShift "4",

        className =? "Pidgin" --> doShift "3",
        className =? "Skype" --> doShift "5",

        className =? "Sonata" --> doShift "6",

        className =? "Krusader" --> doShift "7",

        className =? "MPlayer" --> doShift "8"
    ]

modm = mod1Mask
 
--myLayoutHook = Full ||| Accordion

myLayoutHook = avoidStruts ( Full ||| smartBorders Full ||| Tall 1 0.03 0.5 ||| Accordion ||| simpleTabbed ||| Grid ||| simpleCross )

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/burb/.xmobarrc"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
            <+> manageHook defaultConfig,
        --layoutHook = avoidStruts  $  layoutHook defaultConfig
        layoutHook = myLayoutHook,
        logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "green" "" . shorten 50
        },
        --modMask = mod4Mask     -- Rebind Mod to the Windows key
        startupHook = setWMName "LG3D",
        terminal = "urxvt",
        focusFollowsMouse = False
    } `additionalKeys`
        [
            ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
            -- ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
            ((mod4Mask, xK_p), spawn "sleep 0.2; scrot -s"),
            ((0, xK_Print), spawn "scrot"),
            ((modm .|. shiftMask,                 xK_space), layoutScreens 2 (TwoPane 0.5 0.5)),
            ((modm .|. controlMask .|. shiftMask, xK_space), rescreen)
        ]
