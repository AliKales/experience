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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Experience',
        theme: ThemeData(
            scaffoldBackgroundColor: cBackgroundColor,
            appBarTheme: _appBarTheme(),
            iconTheme: _iconTheme(),
            dividerTheme: _dividerTheme(context),
            textTheme: context.textTheme
                .apply(bodyColor: cTextColor, displayColor: cTextColor)),
        home: AuthFirebase().isSignedIn
            ? const MainPageView()
            : const FirstPageView(),
      ),
    );
  }

  DividerThemeData _dividerTheme(BuildContext context) =>
      const DividerThemeData(color: cSecondryColor, thickness: 2);

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: _iconTheme(),
    );
  }

  IconThemeData _iconTheme() {
    return const IconThemeData(
      color: Colors.white,
    );
  }
}
