import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconn2g15/firebase_options.dart';
import 'package:firebaseconn2g15/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false));
}
