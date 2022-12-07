import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:reminder/view/home_page.dart';
import 'package:reminder/view/reminder_list.dart';
import 'package:reminder/view/search.dart';
import 'package:reminder/view/user.dart';
import 'package:reminder/view/user_info.dart';
import 'package:reminder/view/profile_widget.dart';

import 'package:reminder/main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = UserInfo.myUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReminderList()));
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: Icon(Icons.person),
          ),
          TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                Locale newLocale = Locale('en');
                await FlutterI18n.refresh(context, newLocale);
                setState(() {});
              },
              child: Text("EN")),
          TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                Locale newLocale = Locale('fr');
                await FlutterI18n.refresh(context, newLocale);
                setState(() {});
              },
              child: Text("FR")),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildProfile(user),
        ],
      ),
    );
  }

  Widget buildProfile(User user) => Column(
        children: [
          Text(FlutterI18n.translate(context, "fullName"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 16),
          Text(FlutterI18n.translate(context, "dateOfBirth"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 16),
          Text(FlutterI18n.translate(context, "email"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 16),
          Text(FlutterI18n.translate(context, "phone"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 16),
          Text(FlutterI18n.translate(context, "healthID"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ],
      );
}
