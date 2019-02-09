#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Oxygen-Icons.org-Oxygen-Places-folder-red.ico
#AutoIt3Wrapper_Outfile_x64=File_Sizes_inFolders.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=Sorts in ascending by file size
#AutoIt3Wrapper_Res_Description=Gets ALL file sizes in chosen folder
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_ProductVersion=1.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Carm0
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
If UBound(ProcessList(@ScriptName)) > 2 Then Exit
#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
Local $sFileSelectFolder
Example()

$z = $sFileSelectFolder
$a = _FileListToArrayRec($z, "*", $FLTAR_FILES, $FLTAR_RECUR, $FLTAR_SORT, $FLTAR_FULLPATH)
Dim $b[UBound($a)][3]
Local $d

For $i = 1 To UBound($a) - 1
	$b[$i][0] = $a[$i]
	$iFileSize = FileGetSize($a[$i])
	;$b[$i][2] = ByteSuffix($iFileSize)
	$b[$i][1] = $iFileSize
	$d = $d + $b[$i][1]
	$y = FileGetTime($a[$i], $FT_MODIFIED)
	If @error Then
		Local $y[6] = ["N", "O", "_", "G", "O", "!"]
	EndIf
	;ConsoleWrite($i & "+" & $y[0] & '-' & $y[1] & '-' & $y[2] & '-' & $y[3] & '-' & $y[4] & '-' & $y[5] & @CRLF)
	$b[$i][2] = $y[0] & '-' & $y[1] & '-' & $y[2] & '-' & $y[3] & '-' & $y[4] & '-' & $y[5]
Next

ByteSuffix($d)
_ArraySort($b,0,0,0,1)
_ArrayAdd($b, 'total size |' & ByteSuffix($d))
_ArrayDisplay($b, $z, '1:' & UBound($a), "", "", 'File Name & Path|Size in Bytes|Date Last Modified (YYYY-MM-DD-HH-MM-SS)')
$f = StringSplit($sFileSelectFolder, '\')
$g = UBound($f) -1
_FileWriteFromArray(@ScriptDir & '\' & $f[$g] & ".csv", $b)

Func ByteSuffix($iBytes)
	Local $iIndex = 0, $aArray = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
	While $iBytes > 1023
		$iIndex += 1
		$iBytes /= 1024
	WEnd
	Return Round($iBytes) & $aArray[$iIndex]
EndFunc   ;==>ByteSuffix




Func Example()
	Global $sFi
	; Create a constant variable in Local scope of the message to display in FileSelectFolder.
	Local Const $sMessage = "Select The Profile to backup"

	; Display an open dialog to select a file.
	Global $sFileSelectFolder = FileSelectFolder($sMessage, "c:\")
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
		Exit
	Else
		; Display the selected folder.
		;MsgBox($MB_SYSTEMMODAL, "", "You chose the following folder:" & @CRLF & $sFileSelectFolder)

	EndIf
EndFunc   ;==>Example
