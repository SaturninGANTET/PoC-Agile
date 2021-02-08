// 2>nul||@goto :batch
/*
:batch
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit
@echo off
setlocal
:: find csc.exe
set "csc="
for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do  set "csc=%%#"

if not exist "%csc%" (
   echo no .net framework installed
   exit /b 10
)

if not exist "%~n0.exe" (
   call %csc% /nologo /r:"Microsoft.VisualBasic.dll" /out:"%~n0.exe" "%~dpsfnx0" || (
      exit /b %errorlevel% 
   )
)

snippingtool.exe /clip
%~n0.exe %*


setlocal disableDelayedExpansion

setlocal enableDelayedExpansion
set "response="
for /f "delims= " %%r in ('curl -F "image=@tmp.png" satutu.ddns.net:3004/api/puush/up 2^>^&1') do (
  set response=%%r 
)

::msg /TIME:10 "%username%" !response!
::mshta javascript:alert(`!reponse!`);close();
echo "!response!"
start chrome !response!
del tmp.png
del %~n0.exe %*
echo done
echo !response! | CLIP

PowerShell ^
[reflection.assembly]::loadwithpartialname(\"System.Windows.Forms\"); ^
[reflection.assembly]::loadwithpartialname(\"System.Drawing\"); ^
$notify = new-object system.windows.forms.notifyicon; ^
$notify.icon = [System.Drawing.SystemIcons]::Information; ^
$notify.visible = $true; ^
$notify.showballoontip(10,\"ScreenShot Uploaded\",\"Lien copie dans le presse papier\",[system.windows.forms.tooltipicon]::None)

endlocal
endlocal
endlocal & exit
exit

*/


using System;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
using Microsoft.VisualBasic;
using System.Windows.Forms;

/// Provides functions to capture the entire screen, or a particular window, and save it to a file. 

public class ScreenCapture
{

	public Image CaptureArea()
	{
		return Clipboard.GetImage();
	}

	public void CaptureAreaToFile(string filename, ImageFormat format)
	{
		Image img = CaptureArea();
		img.Save(filename, format);
	}

    static String file = "screenshot.bmp";
    static System.Drawing.Imaging.ImageFormat format = System.Drawing.Imaging.ImageFormat.Bmp;


	[STAThread]
    public static void Main()
    {
        Console.WriteLine("Taking a capture of the area");
		file = "tmp.png";
		format = System.Drawing.Imaging.ImageFormat.Png;
		ScreenCapture scArea = new ScreenCapture();
		scArea.CaptureAreaToFile(file, format);
		return;
    }
}