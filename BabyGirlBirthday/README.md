# BabyGirlBirthday - the real app

The birthday-day game for Stephani's 37th, Thursday, October 15, 2026, roughly 9 AM to 5 PM.

- App ID: `com.kelley.stephaniday`
- App name: Baby Girl's Birthday
- Saved-data key (localStorage): `stephani-day-v1`
- Host PIN: stored in the code only as a salted SHA-256 hash (`PIN_HASH` in `www/index.html`), so the PIN itself is not published

## What it does

- 7 rounds, two face-down index cards each, with the real itinerary
- Pick a card, then confirm with three escalating Lock taps (Lock it in, Are you sure?, FINAL ANSWER. LOCK IT.) to flip it over
- Each revealed card shows the address, "Open in Google Maps", "Copy address", and any tips
- A $100 spree tally in the shopping round
- A "Your day" summary at the end with the full list of picks
- Host mode (behind the PIN): see every card, work through the "Confirm before Thursday" checklist, and reset the game
- Picks and the spree tally are saved on the phone and survive closing and reopening the app

## Host checklist

A few venue hours in the itinerary are not yet verified. The host checklist in host mode flags them. Confirm those with the venues before Thursday. Do not remove the flags until they are verified.

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

## Install on her phone

1. Copy `APKs/BabyGirlBirthday.apk` to the phone.
2. Open it from the Files app, allow "Install unknown apps" for that app, and tap Install.
3. Do not clear the app's data before Thursday, because that wipes her picks.

## Keep this content separate

The real itinerary lives only in this project. The demo app (`../IndexCardDemo`) uses invented places and a different host PIN and storage key. Do not mix the two.
