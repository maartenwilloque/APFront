import 'package:ap_front/widgets/titledisplay.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:math';

class ProfilePopup extends StatefulWidget {
  const ProfilePopup({Key? key}) : super(key: key);
  @override
  _ProfilePopupState createState() => _ProfilePopupState();
}

class User {
  String username;
  String GUID;
  User({required this.username, required this.GUID});

  toJSONEncodable() {
    Map<String, dynamic> m = {};

    m['username'] = username;
    m['guid'] = GUID;

    return m;
  }
}

class UserList {
  List<User> users;

  UserList({required this.users});

  toJSONEncodable() {
    return users.map((user) {
      return user.toJSONEncodable();
    }).toList();
  }
}

class _ProfilePopupState extends State<ProfilePopup> {
  late String _username;
  final LocalStorage storage = LocalStorage('user_storage');

  @override
  void initState() {
    super.initState();
    _username = storage.getItem('username') ?? '';
  }

  void _showUsernamePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextTheme theme = Theme.of(context).textTheme;

        return AlertDialog(
          title: Text(
            'Enter Username',
            style: theme.headlineMedium,
          ),
          content: TextField(
            onChanged: (value) {
              _username = value;
            },
            decoration: InputDecoration(
              hintText: 'Username',
              hintStyle: theme.bodyMedium,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: theme.bodyMedium,
              ),
              onPressed: () {
                //create GUID with random
                var random = Random();
                var GUID = random.nextInt(99999).toString() + _username;

                // Save username and close popup in local storage
                storage.setItem('username', _username);
                storage.setItem('guid', GUID);

                setState(() {
                  _username = storage.getItem('username') ?? '';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const TitleDisplayWidget(
        title: "Profile",
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Username:\u2002$_username',
              style: theme.headlineSmall,
            ),
            TextButton(
              child: Text(
                'Change Username',
                style: theme.bodyLarge?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                _showUsernamePopup();
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(290, 50),
            backgroundColor: scheme.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: theme.displaySmall,
          ),
        ),
      ],
    );
  }
}
