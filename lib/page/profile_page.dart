

import 'package:flutter/material.dart';

//ok 1
import '../model/user.dart';
//ok 2
import '../utils/user_preferences.dart';
//ok 3
import '../widget/appbar_widget.dart';
//ok 4
import '../widget/button_widget.dart';
//ok 5
import '../widget/numbers_widget.dart';
// ok 6
import '../widget/profile_widget.dart';
// ok 7
import 'edit_profile_page.dart';
// ok 8
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //2 user_preferences
    final user = UserPreferences.getUser();

    //8 animated_theme_switcher
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
            //3 widget/appbar_widget.dart
          appBar: buildAppBar(context),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              //6 widget/profile_widget.dart
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () async {
                  await Navigator.of(context).push(
                    //7 edit_profile_page.dart
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),

              //buildName widget widget
              buildName(user),
              const SizedBox(height: 24),
              //buildUpgradeButton
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              //buildAbout
              //5 widget/numbers_widget.dart
              NumbersWidget(),
              const SizedBox(height: 48),
              buildAbout(user),
            ],
          ),
        ),
      ),
    );
  }

  //buildName widget widget
  //1 model/user.dart
  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  //buildUpgradeButton
  //4 widget/button_widget.dart
  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

  //buildAbout
  //1 model/user.dart
  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
