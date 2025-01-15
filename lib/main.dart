import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:choose_profile_img/page/profile_page.dart';
import 'package:choose_profile_img/themes.dart';
import 'package:choose_profile_img/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeProvider.of(context),
          title: title,
          home: ProfilePage(),
        ),
      ),
    );
  }
}
