import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/screen_nav_bottom.dart';

// late FirebaseApp app;
// late FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDL6dsusnECOfPmLCnRFyCfml9N0ng25GM',
      appId: '1:386891168137:web:77916e1851f2ce5a314958',
      messagingSenderId: '386891168137',
      projectId: 'tintuc-a0ba2',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App tin tức',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScreenNavigationBottom(),
    );
  }
}
