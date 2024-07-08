import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:travel_directory/AboutUs.dart';
import 'package:travel_directory/home.dart';
import 'package:travel_directory/login.dart';
import 'package:travel_directory/main.dart';
import 'package:travel_directory/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      drawer: Navbar(),
      body: Center(
        child: Text('Main Page Content'),
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  String userName = "", email = "";

  Navbar() {
    loadUser();
  }

  void loadUser() async {
    userName = await SessionManager().get("name");
    email = await SessionManager().get("email");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 25, 173, 199),
            ),
          ),
          ListTile(
            leading: Icon(Icons.content_copy),
            title: Text('Login'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Sign Up'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(0)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
