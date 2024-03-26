import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kamus_kebidanan/routes/pages_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBX8uIYySr5pn0MNcIAXGI-fZmY6eOs7QM",
    appId: "1:858472032082:android:e326ea02041541929c7c8b",
    messagingSenderId: "858472032082",
    projectId: "kamus-kebidanan",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromARGB(255, 27, 165, 66),
            ),
      ),
      // home: RouteName,
      initialRoute: '/navbar',
      getPages: PagesRouting.pages,
    );
  }
}
