@echo off
setlocal enabledelayedexpansion
rem Builds IndexCardDemo.apk and BabyGirlBirthday.apk. Run from this folder.
cd /d "%~dp0"

where node >nul 2>nul || (echo Node.js is not installed. Install the LTS version from https://nodejs.org then run this again. & pause & exit /b 1)

rem --- find Java 21 (Android Studio ships one) ---
if not defined JAVA_HOME (
  for /d %%J in ("%ProgramFiles%\Eclipse Adoptium\jdk-21*") do if exist "%%J\bin\java.exe" set "JAVA_HOME=%%J"
)
if not defined JAVA_HOME (
  if exist "%ProgramFiles%\Android\Android Studio\jbr\bin\java.exe" set "JAVA_HOME=%ProgramFiles%\Android\Android Studio\jbr"
)
if not defined JAVA_HOME (
  if exist "%LOCALAPPDATA%\Programs\Android Studio\jbr\bin\java.exe" set "JAVA_HOME=%LOCALAPPDATA%\Programs\Android Studio\jbr"
)
if not defined JAVA_HOME (echo Could not find Java. Install Android Studio, or install JDK 21 and set JAVA_HOME. & pause & exit /b 1)
set "PATH=%JAVA_HOME%\bin;%PATH%"
rem Work around "Unable to establish loopback connection" when TEMP is an 8.3 short path
if not exist "%SystemDrive%\jtmp" mkdir "%SystemDrive%\jtmp"
set "JAVA_TOOL_OPTIONS=-Djdk.net.unixdomain.tmpdir=%SystemDrive%/jtmp"
echo Using Java at %JAVA_HOME%

rem --- find the Android SDK ---
if not defined ANDROID_HOME if defined ANDROID_SDK_ROOT set "ANDROID_HOME=%ANDROID_SDK_ROOT%"
if not defined ANDROID_HOME if exist "%LOCALAPPDATA%\Android\Sdk" set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
if not defined ANDROID_HOME (echo Could not find the Android SDK. Open Android Studio once, finish setup, then run this again. & pause & exit /b 1)
echo Using Android SDK at %ANDROID_HOME%
set "SDKDIR=%ANDROID_HOME:\=/%"

if not exist APKs mkdir APKs

for %%P in (IndexCardDemo BabyGirlBirthday) do (
  echo.
  echo ===== Building %%P =====
  pushd "%%P"
  echo sdk.dir=!SDKDIR!> android\local.properties
  call npm install --no-audit --no-fund || (echo npm install failed for %%P & popd & pause & exit /b 1)
  call npx cap sync android || (echo cap sync failed for %%P & popd & pause & exit /b 1)
  pushd android
  call .\gradlew.bat assembleDebug || (echo Gradle build failed for %%P & popd & popd & pause & exit /b 1)
  popd
  copy /y "android\app\build\outputs\apk\debug\app-debug.apk" "..\APKs\%%P.apk" >nul
  popd
)

echo.
echo Done. Your APKs are in the APKs folder:
dir /b APKs
pause
