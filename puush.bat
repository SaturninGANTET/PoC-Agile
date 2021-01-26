// 2>nul||@goto :batch
/*
:batch
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
endlocal & exit

*/


using System;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
using Microsoft.VisualBasic;
using System.Windows.Forms;

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