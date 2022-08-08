import 'package:experiences/library/pages/first_page/first_page_view.dart';
import 'package:experiences/library/pages/main_page/main_page_view.dart';
import 'package:experiences/library/providers/bottom_navbar_provider.dart';
import 'package:experiences/library/providers/item_experiences_provider.dart';
import 'package:experiences/library/providers/user_page_provider.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/values.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox('faves');

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
          scaffoldBackgroundColor: cBackgroundColor,
          appBarTheme: appBarTheme,
          iconTheme: iconTheme,
          dividerTheme: dividerTheme,
          textTheme: context.textTheme
              .apply(bodyColor: cTextColor, displayColor: cTextColor)),
      home: AuthFirebase().isSignedIn
          ? const MainPageView()
          : const FirstPageView(),
    );
  }
}
