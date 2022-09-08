import 'package:experiences/library/pages/first_page/first_page_view.dart';
import 'package:experiences/library/pages/main_page/main_page_view.dart';
import 'package:experiences/library/providers/bottom_navbar_provider.dart';
import 'package:experiences/library/providers/item_experiences_provider.dart';
import 'package:experiences/library/providers/user_page_provider.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/values.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox('faves');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      systemNavigationBarColor: Color(0xFFe9e8f1),
      systemNavigationBarIconBrightness: Brightness.dark));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<MotelItemExperienceProvider>(
          create: (context) => MotelItemExperienceProvider(),
        ),
        ChangeNotifierProvider<UserPageProvider>(
          create: (context) => UserPageProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experience',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink.shade100,
          surface: cPrimaryColor,
          surfaceTint: cSecondoryColor,
        ),
      ),
      home: AuthFirebase().isSignedIn
          ? const MainPageView()
          : const FirstPageView(),
    );
  }
}
