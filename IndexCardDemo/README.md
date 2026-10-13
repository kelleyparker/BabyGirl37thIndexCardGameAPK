# IndexCardDemo - the demo app

A safe-to-share version of the Index Card Game. Same app, same look, but every place is invented.

- App ID: `com.kelley.indexcarddemo`
- App name: IndexCardDemo
- Host PIN: the demo PIN is shared with whoever runs the demo (stored in the code only as a salted SHA-256 hash, `PIN_HASH` in `www/index.html`)
- Saved-data key (localStorage): `indexcard-demo-v1`
- A yellow DEMO tag shows in the top bar so nobody mistakes it for the real thing

## What it does

- 7 rounds of two face-down index cards each (fake places such as "Sample Pancake House, 100 Example Lane, Testville, TX 00001")
- Pick a card, then confirm with three escalating Lock taps (Lock it in, Are you sure?, FINAL ANSWER. LOCK IT.) to flip it over
- "Open in Google Maps" and "Copy address" on each revealed card
- A $100 spree tally in the shopping round
- Host mode (behind the host PIN): see every card, tick a confirmation checklist, and reset the game
- Android back button goes back one screen and never exits mid-game

## Layout

```
www/index.html            the whole app (single-file vanilla JS and CSS)
www/fonts, www/fonts.css  bundled fonts, so there are no network calls
capacitor.config.json     Capacitor config (app ID and name)
android/                  native Android project (Gradle)
```

`www/index.html` is the source of truth. After editing it, run `npx cap sync android` and rebuild.

## Build just this app

From this folder, with JDK 21, the Android SDK and Node installed (see the main README):

```
npm install
npx cap sync android
cd android
gradlew.bat assembleDebug
```

The APK appears at `android/app/build/outputs/apk/debug/app-debug.apk`. Create `android/local.properties` with `sdk.dir=C:/Users/YOU/AppData/Local/Android/Sdk` if Gradle cannot find the SDK. The repo-level `build-apks.bat` does all of this for both apps.

Do not copy real itinerary content into this project. It is the public-safe sample.
