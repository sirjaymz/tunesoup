#cs
github- tunesoup
Main Module
Version: 0.0.0.1
Author: sirjaymz
Contact: sirjaymz@gmail.com
website: https://github.com/sirjaymz/tunesoup

Module Description
This is the main code for the TuneSoup script/app.

Program Description:
TuneSoup allows the control of USB devices, primarily minidsp devices initially, with generic enable/disable of multiple devices connected of the USB link, versus using a physical
USB switch that only supports a single unit connected via the USB at a time.
TuneSoup enables the ability to use multiple minidsp devices connected simutaneously to the USB chain on the computer, by enabling and disabling those units not being configured.

Vision : Later version of TuneSoup will include more programs/devices to be controlled, such as Room EQ Wizard, iNuke Amplifier software, and Behringer NX amplifiers, others...

Initial Release will just control miniDSP 2x4-HD. Others can be added later, additionals to include NX series and others such as the behringer iNuke and NX series devices, as they suffer from the same poor programming methods.
Additional device recognition will be done with a simple add a UDF file into the resources to be read as an enumerator for necessary C&C.

#ce

#include <Array.au3>
#include <GuiStatusBar.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <File.au3>
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiListBox.au3>
#include <Date.au3>
#include <GuiTab.au3>
#include <GuiTreeView.au3>
#include <TrayConstants.au3>

;UDF's to control different types of devices.
;#include <Control - minidsp2x4adv.au3>
;#include <Control - minidsp2x4hd.au3>
;#include <Control - inuke3kdsp.au3>
;#include <Control - inuke6kdsp.au3>
;#include <Control - RoomEQ.au3>


;#Global variables

#cs
;#Global variables
Programming notes..
Need to check and see if the ini files exists first, if not, app will just need to use all defaults and write and ini file so next boot, it's there..
Need to ensure the USBDeview exists all the time. check, double check, recheck, and if it doesn't, the app just makes them always point to go get it and set the location.
#ce

;Global $TuneSoupVersion					= IniRead( @ScriptDir & "\" & "TuneSoup.ini", "Main", "Version", "Experimental") ; Version of TuneSoup
Global Const $TuneSoupVersion					= "0.0.0.1"
Global $TuneSoupForm1					; Main Gui Form
Global $TuneSoupForm2					; Settings Gui Form
Global $TuneSoupFormAbout				; About Gui Form
Global $BtnSendToTray					; Button/function to minimize Main Gui, and to create Tray Icon
Global Const $FontSizeNorm				= 14
Global Const $FontSizeBig				= 18
Global Const $FontWeightNorm			= 400
Global Const $FontWeightBold			= 800
Global Const $FontAttrib				= 0
Global Const $FontName					= "Arial"



Global $TuneSoupToolUSBDeview			= "C:\Program Files (x86)\TuneSoup\tools\usbdeview.exe"
Global $TuneSoupToolinuke3k6k			= "C:\Program Files (x86)\TuneSoup\tools\iNukeRemoteConnect_V1.4.exe"
Global $TuneSoupToolminiDSP2x4hd		= "C:\Program Files (x86)\miniDSP\MiniDSP-2x4-HD\MiniDSP-2x4-HD.exe"
Global $miniDSP2x4hd_settings 			= "C:\Users\User\Documents\MiniDSP\MiniDSP-2x4-HD\setting"

Global $Tool_For_Grp1					= $TuneSoupToolminiDSP2x4hd
Global $Tool_For_Grp2					= $TuneSoupToolinuke3k6k

; List of all USB attached devices.
; Get a the tool to get all info... then run it through the loop to assigne device numbers to each minidsp and to each inuke that it sees.
; Once you get a list, which will be in a variable array, need to break in all down.
;








; These will be set by the "Path's" Form.
;#Global $Path2USBDeviewDefault			= IniRead( @ScriptDir & "\" & "TuneSoup.ini", "Settings", "Path2USBDeview", "C:\Program Files\ImgBurn\ImgBurn.exe")


;Func IniFileExist
;Does the TuneSoup INI file exist? if not, create it and use all default settings. If it does, set the variable values.
;EndFunc




;FileExists ( @ScriptDir & "\" & "TuneSoup.ini"
;   If
;EndFunc

; Global $Path2USBDeviewDefault			= IniRead( @ScriptDir & "\" & "TuneSoup.ini", "Settings", "Path2USBDeview", @ScriptDir & "\assets\" & USBDeview.exe")
; Global $Path2USBDeviewUD				= IniRead( @ScriptDir & "\" & "TuneSoup.ini", "Settings", "Path2USBDeviewUD" , $Path2USBDeviewDefault)


Opt("GUICloseOnESC", 0)
Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)

;Primary Form

$TuneSoupForm1 = GUICreate("TuneSoup Version: " & $TuneSoupVersion, 300, 500, -1 , -1)
GUISetIcon("C:\Program Files\AutoIt3\Icons\au3.ico")
GUISetCursor (2)
GUISetBkColor(0xC0C0C0)
GUISetOnEvent($GUI_EVENT_CLOSE, "TuneSoupForm1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "TuneSoupForm1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "TuneSoupForm1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "TuneSoupForm1Restore")

; Tool Bar
;Options to set the directory location for USBDeview
; Options to set the directory for the settings file to delete.

;C:\Users\User\Documents\MiniDSP
;C:\Users\User\Documents\MiniDSP\MiniDSP-2x4-HD\setting
;EnvGet HOMEDRIVE=C:
; HOMEPATH=\Users\User
;MiniDSP
; dsp name = MiniDSP-2x4-HD
; \settings
;files  = settings1.xml , settings2.xml , settings3.xml , settings4.xml
;   "C:\Program Files (x86)\miniDSP\MiniDSP-2x4-HD\MiniDSP-2x4-HD.exe"



; Tool Bar

;$BtnToolBar_Options = GUICtrlCreateButton("&Options", 10, 0, 80, 30)
;GUICtrlSetFont(-1, 12, $FontWeightNorm, $FontAttrib, $FontName)
;GUICtrlSetOnEvent(-1, "BtnOptionsClick")

;$BtnToolBar_SendToTray = GUICtrlCreateButton("&Send to Tray", 200, 0, 100, 30)
;GUICtrlSetFont(-1, 12, $FontWeightNorm, $FontAttrib, $FontName)
;GUICtrlSetOnEvent(-1, "SendToTrayClick")



;Menu
$SettingsMenu = GUICtrlCreateMenu("&Settings")
$SettingsMenuItemPaths = GUICtrlCreateMenuItem("&USBDeview", $SettingsMenu)
GUICtrlSetOnEvent(-1, "SettingsMenuItemTemp1Click")
$SettingsMenuItemPaths = GUICtrlCreateMenuItem("&Settings...", $SettingsMenu)
GUICtrlSetOnEvent(-1, "SettingsMenuItemSettingsClick")
$SettingsMenuItemTheme = GUICtrlCreateMenuItem("&Theme", $SettingsMenu)
GUICtrlSetOnEvent(-1, "SettingsMenuItemThemeClick")
$SettingsMenuItemSeparator2 = GUICtrlCreateMenuitem ("",$SettingsMenu)
$SettingsMenuItemSaveandExit = GUICtrlCreateMenuItem("Sa&ve and Exit", $SettingsMenu)
GUICtrlSetOnEvent(-1, "QueueMenuItemSaveandExitClick")
$SettingsMenuItemExit = GUICtrlCreateMenuItem("E&xit", $SettingsMenu)
GUICtrlSetOnEvent(-1, "TuneSoupForm1Close")
$HelpMenu = GUICtrlCreateMenu("&Help")
$HelpMenuItemContents = GUICtrlCreateMenuItem("&Contents", $HelpMenu)
GUICtrlSetOnEvent(-1, "HelpMenuItemContentsClick")
$HelpMenuItemSeparator1 = GUICtrlCreateMenuitem ("",$HelpMenu)
$HelpMenuItemHomePage = GUICtrlCreateMenuItem("&TuneSoup Homepage", $HelpMenu)
GUICtrlSetOnEvent(-1, "HelpMenuItemHomePageClick")
$HelpMenuLinksMenu = GUICtrlCreateMenu("Additional &Links", $HelpMenu)
$HelpMenuLinksMenuAIT = GUICtrlCreateMenuItem("&USBDeview", $HelpMenuLinksMenu)
GUICtrlSetOnEvent(-1, "HelpMenuLinksMenuUSBDeviewClick")
$HelpMenuLinksMenuIBHP = GUICtrlCreateMenuItem("&miniDSP", $HelpMenuLinksMenu)
GUICtrlSetOnEvent(-1, "HelpMenuLinksMenuMiniDSPClick")
$HelpMenuLinksMenuIBHP = GUICtrlCreateMenuItem("&Behringer iNuke", $HelpMenuLinksMenu)
GUICtrlSetOnEvent(-1, "HelpMenuLinksMenuiNukeClick")
$HelpMenuItemSeparator2 = GUICtrlCreateMenuitem ("",$HelpMenu)
$HelpMenuItemHomePage = GUICtrlCreateMenuItem("&Make a Donation", $HelpMenu)
GUICtrlSetOnEvent(-1, "HelpMenuItemDonationClick")
$HelpMenuItemSeparator3 = GUICtrlCreateMenuitem ("",$HelpMenu)
$HelpMenuItemAbout = GUICtrlCreateMenuItem("&About", $HelpMenu)
GUICtrlSetOnEvent(-1, "HelpMenuItemAboutClick")
$SendToTrayMenuItem = GUICtrlCreateMenuItem("&Send to Tray", -1)
GUICtrlSetOnEvent(-1, "SendToTrayMenuItemClick")

;Group 1 Device GUI Elements
$BtnEnableGrp1Dev1 = GUICtrlCreateButton("Enable", 10, 60, 80, 40)
GUICtrlSetFont(-1, $FontSizeNorm, $FontWeightNorm, $FontAttrib, $FontName)
$BtnEnableGrp1Dev2 = GUICtrlCreateButton("Enable", 10, 110, 80, 40)
GUICtrlSetFont(-1, $FontSizeNorm, $FontWeightNorm, $FontAttrib, $FontName)
$BtnEnableGrp1Dev3 = GUICtrlCreateButton("Enable", 10, 160, 80, 40)
GUICtrlSetFont(-1, $FontSizeNorm, $FontWeightNorm, $FontAttrib, $FontName)

;Group 2 Devices
$BtnEnableGrp2Dev1 = GUICtrlCreateButton("Enable", 10, 260, 80, 40)
GUICtrlSetFont(-1, $FontSizeNorm, $FontWeightNorm, $FontAttrib, $FontName)
$BtnEnableGrp2Dev2 = GUICtrlCreateButton("Enable", 10, 310, 80, 40)
GUICtrlSetFont(-1, $FontSizeNorm, $FontWeightNorm, $FontAttrib, $FontName)
$BtnEnableGrp2Dev3 = GUICtrlCreateButton("Enable", 10, 360, 80, 40)
GUICtrlSetFont(-1, $FontSizeNorm, $FontWeightNorm, $FontAttrib, $FontName)

; Tray Menu and Icon
$TuneSoupTray_ShowTuneSoup = TrayCreateItem ( "Show TuneSoup", -1, 0)
TrayItemSetOnEvent ( $TuneSoupTray_ShowTuneSoup, "ReturnFromTray")
$TuneSoupTray_Separator1 = TrayCreateItem("", -1, 1)
$TuneSoupTray_Exit = TrayCreateItem ( "Exit", -1, 2)
TrayItemSetOnEvent ( $TuneSoupTray_Exit, "TuneSoupForm1Close")


GUISetState(@SW_SHOWNORMAL, $TuneSoupForm1)

While 1
 Sleep(100)
WEnd









; USBDeview Settings Form
; The line below is how you run usbd as administrator
; USBDeview.exe /RunAsAdmin /disable "USB\Vid_1058&Pid_1023\8539583490834690"











; Functions

;Windows Boxes, Top Right of Window
Func TuneSoupForm1Close()
   GUIDelete()
   Exit
EndFunc

Func TuneSoupForm1Maximize()
GUISetState ( @SW_SHOWMAXIMIZED , $TuneSoupForm1 )
EndFunc

Func TuneSoupForm1Minimize()
GUISetState ( @SW_SHOWMINIMIZED , $TuneSoupForm1 )
EndFunc

Func TuneSoupForm1Restore()
GUISetState ( @SW_RESTORE , $TuneSoupForm1 )
EndFunc


Func SendToTrayMenuItemClick ()
TrayItemSetState ( $TuneSoupTray_ShowTuneSoup, $TRAY_ENABLE)
	$TuneSoupMinimized = GUISetState( @SW_MINIMIZE, $TuneSoupForm1)
	Sleep ( 250 )
	$TuneSoupToTray = GUISetState ( @SW_HIDE , $TuneSoupForm1)
EndFunc

Func ReturnFromTray()
	TrayItemSetState ( $TuneSoupTray_ShowTuneSoup, $TRAY_DISABLE)
	$TuneSoupFromTray = GUISetState ( @SW_SHOW , $TuneSoupForm1)
	Sleep(250)
	$TuneSoupMaximized = GUISetState( @SW_RESTORE, $TuneSoupForm1)
EndFunc

Func HelpMenuItemAboutClick()
;$TuneSoupFormAbout = GUICreate("About TuneSoup", 324, 234, 303, 219)
$TuneSoupFormAbout = GuiCreate("About TuneSoup",250,150,-1,-1,BitOR($WS_CAPTION,$WS_SYSMENU))
GUISetOnEvent ($GUI_EVENT_CLOSE, "AboutOK" )
GUICtrlCreateIcon (@AutoItExe,-1,11,11)
;GUICtrlCreateLabel ("TuneSoup Ver: " & $TuneSoupVersion ,59,11,135,20)
GUICtrlCreateLabel ("TuneSoup Ver: " & $TuneSoupVersion ,59,11)
GUICtrlSetFont (-1,10, 800, 0, "Arial") ; bold
GUICtrlCreateLabel ("(c) 2020" & @CRLF & @CRLF & "TuneSoup",59,30,135,40)
$email = GUICtrlCreateLabel ("sirjaymz@gmail.com",59,70,135,15)
GuiCtrlSetFont($email, 8.5, -1, 4) ; underlined
GuiCtrlSetColor($email,0x0000ff)
GuiCtrlSetCursor($email,0)
GUICtrlSetOnEvent(-1, "OnEmail")
$www = GUICtrlCreateLabel ("github.com/sirjaymz/tunesoup",59,85,140,15)
GuiCtrlSetFont($www, 8.5, -1, 4) ; underlined
GuiCtrlSetColor($www,0x0000ff)
GuiCtrlSetCursor($www,0)
GUICtrlSetOnEvent(-1, "OnWWW")
GUICtrlCreateButton ("OK",65,115,75,23,BitOr($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUICtrlSetState (-1, $GUI_FOCUS)
GUICtrlSetOnEvent(-1, "AboutOK")
GUISetState(@SW_SHOW, $TuneSoupFormAbout)
EndFunc
While 1
    Sleep(100)
WEnd

Func OnEmail()
    Run(@ComSpec & " /c " & 'start mailto:sirjaymz@gmail.com?subject=TuneSoup', "", @SW_HIDE)
EndFunc

Func OnWWW()
    Run(@ComSpec & " /c " & 'start https://github.com/sirjaymz/tunesoup', "", @SW_HIDE)
EndFunc

Func AboutOK()
    GUIDelete($TuneSoupFormAbout)
EndFunc

Func OnAutoItExit()
    GUIDelete($TuneSoupFormAbout)
EndFunc


Func HelpMenuItemHomePageClick()
   ShellExecute('https://github.com/sirjaymz/tunesoup')
EndFunc

Func HelpMenuLinksMenuUSBDeviewClick ()
   ShellExecute('http://www.nirsoft.net/utils/usb_devices_view.html')
EndFunc

Func HelpMenuLinksMenuMiniDSPClick()
   ShellExecute('https://www.minidsp.com/support/downloads')
EndFunc

Func HelpMenuLinksMenuiNukeClick()
   ShellExecute('https://www.minidsp.com/support/downloads')
EndFunc


#cs

Need to download this.. make a method built into.
;http://www.linux-usb.org/usb.ids




Disable/Enable/Remove Command-Line Options
Starting from version 1.20, you can also use the following commands to disable, enable or remove USB devices from command-line:

    /disable {\\RemoteComputer} <Device Name>
    /disable_by_serial {\\RemoteComputer} <Device Serial>
    /disable_by_drive {\\RemoteComputer} <Drive Letter>
    /disable_by_class {\\RemoteComputer} <USB Class;USB SubClass;USB Protocol>
    /disable_by_pid {\\RemoteComputer} <VendorID;ProductID>
    /disable_all {\\RemoteComputer}
    /enable {\\RemoteComputer} <Device Name>
    /enable_by_serial {\\RemoteComputer} <Device Serial>
    /enable_by_drive {\\RemoteComputer} <Drive Letter>
    /enable_by_class {\\RemoteComputer} <USB Class;USB SubClass;USB Protocol>
    /enable_by_pid {\\RemoteComputer} <VendorID;ProductID>
    /enable_all {\\RemoteComputer}
    /disable_enable {\\RemoteComputer} <Device Name>
    /disable_enable_by_serial {\\RemoteComputer} <Device Serial>
    /disable_enable_by_drive {\\RemoteComputer} <Drive Letter>
    /disable_enable_by_class {\\RemoteComputer} <USB Class;USB SubClass;USB Protocol>
    /disable_enable_by_pid {\\RemoteComputer} <VendorID;ProductID>
    /disable_enable_all {\\RemoteComputer}
    /remove {\\RemoteComputer} <Device Name>
    /remove_by_serial {\\RemoteComputer} <Device Serial>
    /remove_by_drive {\\RemoteComputer} <Drive Letter>
    /remove_by_class {\\RemoteComputer} <USB Class;USB SubClass;USB Protocol>
    /remove_by_pid {\\RemoteComputer} <VendorID;ProductID>
    /remove_all {\\RemoteComputer}
    /remove_all_connected - Remove all connected USB devices.
    /remove_all_disconnected - Remove all disconnected USB devices.

Disable, enable and remove actions require elevation ('Run As Administrator'). You can use the above command-line options with elevation by adding /RunAsAdmin to the command, for example:
USBDeview.exe /RunAsAdmin /disable "USB\Vid_1058&Pid_1023\8539583490834690"




Check if a device is connected/disconnected or enabled/disabled
Starting from version 2.70, you can check whether a device is connected/disconnected or enabled/disabled by using the following command-line options:

    /is_connected {\\RemoteComputer} <Device Name>
    /is_connected_by_serial {\\RemoteComputer} <Device Serial>
    /is_connected_by_drive {\\RemoteComputer} <Drive Letter>
    /is_connected_by_class {\\RemoteComputer} <USB Class;USB SubClass;USB Protocol>
    /is_connected_by_pid {\\RemoteComputer} <VendorID;ProductID>
    /is_disabled {\\RemoteComputer} <Device Name>
    /is_disabled_by_serial {\\RemoteComputer} <Device Serial>
    /is_disabled_by_drive {\\RemoteComputer} <Drive Letter>
    /is_disabled_by_class {\\RemoteComputer} <USB Class;USB SubClass;USB Protocol>
    /is_disabled_by_pid {\\RemoteComputer} <VendorID;ProductID>

When using the above commands, USBDeview returns the number of disabled or connected devices that match the specified string.
For example, the following batch file will display 1 if the device with serial number 7538957348957398 is connected or 0 if the device is not connected:
USBDeview.exe /is_connected_by_serial "7538957348957398"
echo %ERRORLEVEL%


Need to make an active debug output form window from the UDBDeview application when it's executed, for troublshooting if there are problems... or if you want to see it work..

AIT - Run command
AIT - StdoutRead
AIT - RunAs conmmand may play importance when looking to execute as administrator and eliminate the WAC bs from windwos..


#ce






