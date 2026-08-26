## 1.9.0

* Added Swift Package Manager support for iOS, while keeping CocoaPods compatibility
* Reorganized iOS sources under `ios/refiner_flutter/Sources/refiner_flutter/`
* Raised minimum Flutter SDK to 3.24.0 and Dart SDK to 3.5.0 (required for Swift Package Manager)
* Updated Android native SDK to 1.7.5

## 1.8.2

* Updated Android native SDK to 1.7.4

## 1.8.1

* Upgraded Kotlin from 1.9.20 to 2.1.20 to align with native Android SDK 1.7.2
* Updated Android native SDK to 1.7.2

## 1.8.0

* Added `enableClient()` and `disableClient()` methods to pause and resume the SDK at runtime. When disabled, all API communication stops and open surveys are closed. State persists across app restarts
* Improved keyboard handling for survey text inputs (Android)
* Enhanced compatibility with R8 code optimization (Android)
* Fixed excluded screen rules being bypassed in a case

## 1.7.0

* Added anonymous mode support - userId is now optional in identifyUser and setUser
* Added setLocale method for setting user locale independently
* Added setAnonymousId method for setting custom anonymous IDs
* Updated Android SDK dependency to 1.6.0
* Updated iOS SDK dependency to ~> 1.6.1

## 1.6.7

Android hotfix.

* Fixed callback trigger issue
* Upgraded Refiner Android SDK to 1.5.9

## 1.6.6

* Improved WebView error handling
* Android: upgraded Refiner Android SDK to 1.5.8
* Android: improved SDK performance
* iOS: upgraded Refiner iOS SDK to 1.5.10
* iOS: added support for App-Bound Domain Limiting for iOS 14+

## 1.6.5

iOS hotfix.

* Fixed multiple survey display bug

## 1.6.4

* Improved survey delay in combination with allowed screens
* Added `writeOperation` capability to the identifyUser method
* Android: upgraded Refiner Android SDK to 1.5.7
* iOS: upgraded Refiner iOS SDK to 1.5.8

## 1.6.3

* Dismissed survey if any network error is received
* Added onError callback
* Internal improvements
* Android: upgraded Refiner Android SDK to 1.5.6
* iOS: upgraded Refiner iOS SDK to 1.5.6

## 1.6.2

* Android: upgraded Refiner Android SDK to 1.5.5
* Android: fixed ProGuard rules that might cause conflict with the host app
* iOS: upgraded Refiner iOS SDK to 1.5.5
* iOS: fixed presenting topViewController; multiple popup issue

## 1.6.0

* Android: upgraded Refiner Android SDK to 1.5.4
* Android: fixed survey screen delay, now set as seconds
* Android: added support for displaying content edge-to-edge
* iOS: upgraded Refiner iOS SDK to 1.5.4
* iOS: dismissed survey when no content is loaded due to an error in CSS code etc., and show an error log about this

## 1.5.1

* Added new method: `setUser`
* Android: fixed survey resize issue on device rotation change
* iOS: always show a survey in the device's current orientation, do not rotate UI on device rotation

## 1.4.0

* Added new method: `startSession`

## 1.3.10

* Limited the SDK to be initialized only once per app session
* Android: upgraded Refiner Android SDK to 1.3.10
* iOS: upgraded Refiner iOS SDK to 1.3.10
* iOS: added privacy manifest
* iOS: fixed bug regarding "custom styles" not being applied

## 1.3.6

* Android: upgraded Refiner Android SDK to 1.3.6
* Android: removed databinding requirement
* Android: fixed video rendering issue in a survey
* Android: dismissed the survey when an error occurred and the survey is not shown

## 1.3.4

* Added support for redirecting the user to the out-of-app browser with a provided URL after submitting a response to the survey

## 1.3.0

* Changed parameter name from `enableDebugMode` to `debugMode` in the initialize method
* Added new methods: `setProject`, `dismissForm` and `closeForm`
* Show surveys starting from the top of the screen, now covering the status bar (iOS only)

Versions used in this release:

* Flutter: `>=2.19.6 <4.0.0`
* Refiner Android SDK: `1.3.1`
* Gradle: `8.2`
* AGP: `8.1.4`
* Kotlin: `1.9.20`
* Refiner iOS SDK: `1.3.0`

Android: if you get an "Inconsistent JVM-target compatibility detected" error during your build, you
may choose to force JdkVersion 11 in your app's `build.gradle.kts` file:

```
android {
...

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlin {
        jvmToolchain(11)
    }
}
```

## 0.0.5

* Hotfix: fixed setting the `locale` parameter in the Flutter iOS SDK

## 0.0.4

* Hotfix due to crash on `resetUser` method usage on iOS (issue #2)

## 0.0.3

* Official Flutter wrapper for the Refiner.io Mobile SDK

## 0.0.2

* Official Flutter wrapper for the Refiner.io Mobile SDK

## 0.0.1

* Official Flutter wrapper for the Refiner.io Mobile SDK
