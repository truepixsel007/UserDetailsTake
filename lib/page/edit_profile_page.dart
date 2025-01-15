import 'package:flutter/material.dart';

// ok 1
import 'dart:io';
// ok 2
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
//ok 3
import 'package:image_picker/image_picker.dart';
//ok 4
import 'package:path_provider/path_provider.dart';
//ok 5
import 'package:path/path.dart';
//ok 6
import '../model/user.dart';
//ok 7
import '../utils/user_preferences.dart';
//ok 8
import '../widget/appbar_widget.dart';
//ok 9
import '../widget/button_widget.dart';
//ok 10
import '../widget/profile_widget.dart';
//ok 11
import '../widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //6 import '../model/user.dart';
  late User user;

  @override
  void initState() {
    super.initState();
    //6 import '../model/user.dart';
    //7 import '../utils/user_preferences.dart';
    user = UserPreferences.getUser();
  }

  @override
  //2 import 'package:animated_theme_switcher/animated_theme_switcher.dart';
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            //8 import '../widget/appbar_widget.dart';
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
            //10 import '../widget/profile_widget.dart';
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {
                    //3 import 'package:image_picker/image_picker.dart';
                    final image = await ImagePicker()
                        //3 import 'package:image_picker/image_picker.dart';
                        .pickImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    //5 import 'package:path/path.dart';
                    final name = basename(image.path);
                    //1 import 'dart:io';
                    final imageFile = File('${directory.path}/$name');
                    final newImage =
                        //1 import 'dart:io';
                        await File(image.path).copy(imageFile.path);

                    setState(() => user = user.copy(imagePath: newImage.path));
                  },
                ),
                const SizedBox(height: 24),
                //11 import '../widget/textfield_widget.dart';
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) => user = user.copy(name: name),
                ),
                const SizedBox(height: 24),
                //11 import '../widget/textfield_widget.dart';
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) => user = user.copy(email: email),
                ),
                const SizedBox(height: 24),
                //11 import '../widget/textfield_widget.dart';
                TextFieldWidget(
                  label: 'About',
                  text: user.about,
                  maxLines: 5,
                  onChanged: (about) => user = user.copy(about: about),
                ),
                const SizedBox(height: 24),
                //9 import '../widget/button_widget.dart';
                ButtonWidget(
                  text: 'Save',
                  onClicked: () {
                    UserPreferences.setUser(user);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
