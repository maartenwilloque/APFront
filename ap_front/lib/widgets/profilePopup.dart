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
        return AlertDialog(
          title: const Text('Enter Username'),
          content: TextField(
            onChanged: (value) {
              _username = value;
            },
            decoration: const InputDecoration(hintText: 'Username'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
    return AlertDialog(
      title: const Text("Profile"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Username: $_username',
              style: const TextStyle(fontSize: 20),
            ),
            TextButton(
              child: const Text('Change Username'),
              onPressed: () {
                _showUsernamePopup();
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
