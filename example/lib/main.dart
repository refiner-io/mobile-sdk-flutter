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
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await Refiner.showForm("4792f1e0-b6e8-11ed-84cf-d1abc91dbc3d",
                  force: true);
            },
            child: const Text("Show Form"),
          ),
        ),
      ),
    );
  }

  Future<void> initRefiner() async {
    //enableDebugMode : true for testing
    await Refiner.initialize(
        projectId: "a95a2e00-afb7-11ea-92d4-fd03275706ee",
        enableDebugMode: true);

    var userTraits = {
      'email': 'hello@hello.com',
      'a_number': 123,
      'a_date': '2022-16-04 12:00:00'
    };

    await Refiner.identifyUser(userId: "my-user-id", userTraits: userTraits);

    await Refiner.trackEvent("eventName");
    await Refiner.trackScreen("screenName");

    await Refiner.addToResponse({"testKey":"testValue"});

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
  }
}
