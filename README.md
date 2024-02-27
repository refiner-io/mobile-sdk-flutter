# Refiner Mobile SDK integration

## Flutter

### 1) Installation

- To use this plugin, add refiner_flutter as a dependency in your pubspec.yaml file.

  ![Pub Version (including pre-releases)](https://img.shields.io/pub/v/refiner_flutter)

```yaml
dependencies:
  refiner_flutter: ^[version]
```

#### iOS

- Run command `pod install` in your ios directory

### 2) Usage

Visit our [documentation](https://refiner.io/docs/kb/mobile-sdk/mobile-sdk-reference/) for more
information about how to use the SDK methods.

#### Initialization & Configuration

Initialize the SDK in your application with the needed configuration parameters.

The second parameter is for activating a debug mode during development. If activated, the SDK will
log all interactions with the Refiner backend servers.

```dart
import 'package:refiner_flutter/refiner_flutter.dart';

await Refiner.initialize(projectId: 'PROJECT_ID', debugMode: false);
```

#### Identify User

Call `Identify User` to create or update user traits in Refiner.

The first parameter is the userId of your logged-in user and is the only mandatory parameter.

The second parameter is an object of user traits. You can provide an empty object if you don't want
to send any user traits to your Refiner account.

```dart

var userTraits = {
  'email': 'hello@hello.com',
  'a_number': 123,
  'a_date': '2022-16-04 12:00:00'
};

await Refiner.identifyUser(userId: 'my-user-id', userTraits: userTraits);
```

The third parameter is for setting the `locale` of a user and is optional. The expected format is a
two letter [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) language code. When
provided, the locale code is used for launching surveys for specific languages, as well as launching
translated sureys. You can set the value to `null` if you are not using any language specific
features.

The fourth parameter is an
optional [Identity Verification](https://refiner.io/docs/kb/mobile-sdk/identify-verification-for-mobile-sdks/)
signature. We recommend to use a Identify Verification signature for increased security in a
production environment. For development purposes, you can set this value to `null`.

```dart
var userTraits = {
  'email': 'hello@hello.com',
  'a_number': 123,
  'a_date': '2022-16-04 12:00:00'
};

awaitRefiner.identifyUser(userId: 'my-user-id',userTraits: userTraits,locale: 'LOCALE',signature: 'SIGNATURE');
```

#### Track Event

`Track Event` lets you track user events. Tracked events can be used to create user segments and
target audiences in Refiner.

```dart
await Refiner.trackEvent('EVENT_NAME');
```

#### Track Screen

`Track Screen` lets you to track screen that user is currently on. Screen information can be used to
launch surveys in specific areas of your app.

We recommend to track screens on which you might want to show a survey one day. There is no need to
systematically track all screens of your app.

```dart
await Refiner.trackScreen('SCREEN_NAME');
```

#### Ping

Depending on your setup, you might want to initiate regular checks for surveys that are scheduled
for the current user. For example when you are using time based trigger events, or when a target
audience is based on user data received by our backend API.

The `Ping` method provides an easy way to perform such checks. You can call the `Ping` method at key
moments in a user's journey, such as when the app is re-opened, or when the user performs a specific
action.

```dart
await Refiner.ping();
```

#### Show Form

If you use the Manual Trigger Event for your survey, you need to call `Show Form` whenever you want
to launch the survey.

```dart
await Refiner.showForm('FORM_UUID');
```

The second parameter is a boolean value to `force` the display of the survey and bypass all
targeting rules which were set in the Refiner dashboard. Setting the parameter to `true` can be
helpful when testing the SDK. In production, the parameter should be set to `false`.

```dart
await Refiner.showForm('FORM_UUID', force: true);
```

#### Attach Contextual Data

Attach contextual data to the survey submissions with `addToResponse`. Set `null` to remove the
contextual data.

```dart
var contextualData = { 'some_data': 'hello', 'some_more_data': 'hello again'};
await Refiner.addToResponse(contextualData);
```

#### Reset User

Call `Reset User` to reset the user identifier previously set through `Identify User`. We recommend
calling this method when the user logs out from your app.

```dart
await Refiner.resetUser();
```

#### Set Project

Change the environment UUID during runtime, after the SDK has been initialised.

```dart
await Refiner.setProject('PROJECT_ID');
```

#### Close Surveys

Close a survey programmatically without sending any information to the backend API with the `closeForm` method.

```dart
await Refiner.closeForm('FORM_UUID');
```

Close a survey programmatically and send a "dismissed at" timestamp to the backend server with the `dismissForm` method.

```dart
await Refiner.dismissForm('FORM_UUID');
```

#### Register callback functions

Registering callback functions allows you to execute any code at specific moments in the lifecycle
of a survey. A popular use-case for callback functions is to redirect a user to a new screen once
they completed a survey.

`onBeforeShow` gets called right before a survey is supposed to be shown.

```dart
Refiner.addListener("onBeforeShow", (value) {
    print("***onBeforeShow***");
    print(value);
});
```

`onNavigation` gets called when the user moves through the survey

```dart
Refiner.addListener("onNavigation", (value) {
    print("***onNavigation***");
    print(value);
});
```

`onShow` gets called when a survey widget becomes visible to your user.

```dart
Refiner.addListener("onShow", (value) {
    print("***onShow***");
    print(value);
});
```

`onClose` gets called when the survey widgets disappears from the screen.

```dart
Refiner.addListener("onClose", (value) {
    print("***onClose***");
    print(value);
});  
```

`onDismiss` gets called when the user dismissed a survey by clicking on the “x” in the top right
corner.

```dart
Refiner.addListener("onDismiss", (value) {
    print("***onDismiss***");
    print(value);
}); 
```

`onComplete` gets called when the user completed (submitted) a survey.

```dart
Refiner.addListener('onComplete', (args) {
    print('onComplete');
    print(value);
});   
```
