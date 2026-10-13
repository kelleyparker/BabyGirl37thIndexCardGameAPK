# Baby Girl 37th - Index Card Game (Android APKs)

A small birthday-day game app for Stephani's 37th birthday, Thursday, October 15, 2026. The day is seven rounds. Each round is two face-down index cards, and she picks a side, locks it in with three escalating taps, and then the card flips to show where they are going next. There is a $100 spree tally for the shopping round and a host mode for the person running the day.

This repo builds **two separate Android apps** from the same app design:

| App | Folder | App ID | Purpose |
| --- | --- | --- | --- |
| Demo | [`IndexCardDemo/`](IndexCardDemo/) | `com.kelley.indexcarddemo` | Seven made-up rounds with fake places. Safe to show anyone. Yellow DEMO tag in the top bar. |
| Real ("Baby Girl's Birthday") | [`BabyGirlBirthday/`](BabyGirlBirthday/) | `com.kelley.stephaniday` | The real itinerary. This is the one for Stephani's phone. |

The two apps keep separate saved data and never share content. The demo does not contain the real itinerary.

## What is in this repo

```
IndexCardDemo/       Capacitor 7 Android project, demo content
BabyGirlBirthday/    Capacitor 7 Android project, real content
APKs/                Pre-built debug-signed APKs of both apps
build-apks.bat       One-click Windows build script for both apps
README.txt           Short plain-text build and install notes
```

Each project folder has the same shape: `www/index.html` is the whole app (single-file vanilla JS, fonts bundled in `www/fonts`, no network calls), `android/` is the native Android shell, and `capacitor.config.json` configures Capacitor. See each folder's own README for details.

## Install on a phone (no build needed)

The ready-made APKs are in [`APKs/`](APKs/): `BabyGirlBirthday.apk` and `IndexCardDemo.apk`.

1. Copy the APK to the Android phone (USB cable, Google Drive, or email).
2. Open it from the Files app and allow "Install unknown apps" for that app when asked.
3. Tap Install.

With USB debugging enabled you can also use adb:

```
adb install -r APKs\BabyGirlBirthday.apk
adb install -r APKs\IndexCardDemo.apk
```

Notes:
- Both apps work offline. Only the "Open in Google Maps" button needs a connection.
- Picks are saved on the phone. Do not clear an app's data before the big day, because that wipes the picks.
- Host reset: tap Host on the first screen, enter the host PIN, and use the reset button.
- These are debug-signed APKs, which is fine for installing on your own phone.

## Build from source (Windows)

Prerequisites:
- Node.js LTS
- JDK 21 (for example Eclipse Temurin 21). Android Studio's bundled Java 25 is too new for Gradle 8.11.1, so install JDK 21.
- Android SDK with platform 35 and build-tools (installing Android Studio once and letting it finish setup does this)

Then run:

```
build-apks.bat
```

For each project the script runs `npm install`, `npx cap sync android`, and `gradlew.bat assembleDebug`, then copies the results to `APKs\IndexCardDemo.apk` and `APKs\BabyGirlBirthday.apk`. The first run downloads Gradle and the Android build tools, so allow 5 to 15 minutes.

### Build script notes

`build-apks.bat` was adjusted while getting the first real build working:
- It looks for JDK 21 under `C:\Program Files\Eclipse Adoptium\jdk-21*` before falling back to Android Studio's bundled Java.
- It calls `.\gradlew.bat` with an explicit relative path, because some Windows setups do not resolve bare names from the current folder.
- It sets `JAVA_TOOL_OPTIONS=-Djdk.net.unixdomain.tmpdir=C:/jtmp` to avoid Gradle's "Unable to establish loopback connection" error, which happens when the user's TEMP folder is an 8.3 short path such as `C:\Users\NAME~1\...`.

## Tech stack

- Capacitor 7.6.9 (Android), plugins: App, App Launcher, Clipboard, Splash Screen, Status Bar
- Android: compileSdk and targetSdk 35, minSdk 23, Android Gradle Plugin 8.7.2, Gradle 8.11.1, Java 21
- The app itself is a single `index.html` with vanilla JavaScript and CSS, no frameworks

## Tested

Both debug APKs were installed and exercised on a physical Android 16 phone over USB debugging:
- launches in portrait with the dark splash screen
- face-down card pick, then three Lock taps (Lock it in, Are you sure?, FINAL ANSWER) to reveal
- "Open in Google Maps" opens Maps, and "Copy address" copies to the clipboard
- the Android back button goes back one screen and never exits mid-game
- picks survive force-stopping and reopening the app
- dark status and navigation bars with nothing hidden under them (edge-to-edge)

## Privacy

The host PINs are not published anywhere in this repo. The app code stores each PIN only as a salted SHA-256 hash (`PIN_HASH` in each `www/index.html`), and the PIN check hashes what you type and compares. This keeps the PINs out of the source and the APKs, but a 4-digit PIN can still be brute-forced from its hash, so treat the host PIN as a casual gate for whoever runs the day, not as real security.

The real app's folder does contain the real birthday itinerary (places and times), which is public in this repo and inside `BabyGirlBirthday.apk`.
