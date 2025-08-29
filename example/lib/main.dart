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
                await Refiner.showForm("616fc500-5d32-11ea-8fd5-f140dbcb9780",
                    force: true);
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
        projectId: "56421950-5d32-11ea-9bb4-9f1f1a987a49",
        debugMode: true);

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
