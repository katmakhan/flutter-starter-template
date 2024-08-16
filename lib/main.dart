import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_name/Auth_Service/auth_service.dart';
import 'package:app_name/Helpers/get_database.dart';
import 'package:app_name/PushNotification/notifcation_service.dart';
import 'package:app_name/PushNotification/notifcation_service_firebase.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialisation

  try {
    await Firebase.initializeApp();
    // FirebaseDatabase.instance.setPersistenceEnabled(true);
    // await FirebaseAppCheck.instance.activate();
    await NotificationService().initNotification();
    await NotificationServiceFirebase().initNotificationFirebase();
    // await MobileAds.instance.initialize();

    await Get.put(Database()).initStorage();

    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  } catch (e) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    _testSetUserProperty();
    return GetMaterialApp(
      title: 'App_name',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthService().handleAuthState(),
      // home: LoginPage(),
    );
  }

  Future<void> _testSetUserProperty() async {
    await analytics.setUserProperty(name: 'regular', value: 'user');
    print('setUserProperty succeeded');
  }
}
