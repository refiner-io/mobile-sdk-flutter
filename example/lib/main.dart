import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:refiner_flutter/refiner_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initRefiner();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Refiner Flutter Example'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var userTraits = {
                  'email': 'hello@hello.com',
                  'a_number': 123,
                  'a_date': '2022-16-04 12:00:00',
                };
                await Refiner.identifyUser(
                    userId: '111',
                    userTraits: userTraits,
                    locale: 'de');
              },
              child: const Text("Identify User"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Refiner.resetUser();
              },
              child: const Text("Reset User"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Refiner.showForm("e67598a0-cc8d-11ed-a913-47c5ab4910b7",
                    force: true);
                Future.delayed(Duration(seconds: 5),() async {

                  await Refiner.dismissForm('e67598a0-cc8d-11ed-a913-47c5ab4910b7');
                });
              },
              child: const Text("Show Form"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initRefiner() async {
    //enableDebugMode : true for testing
    await Refiner.initialize(
        projectId: "a95a2e00-afb7-11ea-92d4-fd03275706ee",
        debugMode: true);

    await Refiner.setProject(
        projectId: "a95a2e00-afb7-11ea-92d4-fd03275706ee");

    await Refiner.ping();

    await Refiner.trackEvent("eventName");
    await Refiner.trackScreen("screenName");

    await Refiner.addToResponse({"testKey": "testValue"});

    Refiner.addListener("onBeforeShow", (value) {
      print("***onBeforeShow***");
      print(value);
    });
    Refiner.addListener("onNavigation", (value) {
      print("***onNavigation***");
      print(value);
    });
    Refiner.addListener("onShow", (value) {
      print("***onShow***");
      print(value);
    });
    Refiner.addListener("onClose", (value) {
      print("***onClose***");
      print(value);
    });
    Refiner.addListener("onDismiss", (value) {
      print("***onDismiss***");
      print(value);
    });
    Refiner.addListener("onComplete", (value) {
      print("***onComplete***");
      print(value);
    });
  }
}
