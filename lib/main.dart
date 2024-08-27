import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:value_incriment/core/splashscreen.dart';
import 'package:value_incriment/feature/auth_servies/screen/login_screen.dart';
import 'package:value_incriment/home_page.dart';
var width;
var height;
String id="";
Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(
      child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Splashscreen(),
      ),
    );
  }
}


