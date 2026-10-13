INDEX CARD GAME - ANDROID APKS
==============================

What is in this folder
  IndexCardDemo\      Android project for the DEMO app (fake sample rounds, host PIN 0000)
  BabyGirlBirthday\   Android project for the REAL app (host PIN 3335)
  build-apks.bat      One-click build script for Windows

Before you build (one time)
  1. Install Node.js LTS from https://nodejs.org
  2. Install Android Studio, open it once and let it finish downloading the Android SDK.
     (It also includes the Java 21 that the build needs.)

Build
  Double-click build-apks.bat. The first run downloads Gradle and the Android build
  tools, so it can take 5 to 15 minutes. When it finishes you will find:
    APKs\IndexCardDemo.apk
    APKs\BabyGirlBirthday.apk

Install on your Android phone
  Option A, copy the file:
    1. Copy the APK to the phone (USB cable, Google Drive, or email it to yourself).
    2. Open it from the Files app. When asked, allow "Install unknown apps" for that app.
    3. Tap Install.
  Option B, adb (phone in USB debugging mode):
    adb install -r APKs\IndexCardDemo.apk
    adb install -r APKs\BabyGirlBirthday.apk

Notes
  - Both apps work with no internet. Only the Open in Google Maps button needs a connection.
  - The two apps are separate. They have different saved data, so demo picks never touch the real game.
  - Picks are saved on the phone. Do not clear the app's data before Thursday.
  - Host reset: tap Host on the first screen, enter the PIN, and use the reset button.
  - These are debug-signed APKs, which is fine for installing on your own phone.
