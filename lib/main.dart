import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:travel_directory/login.dart';
import 'package:travel_directory/signup.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  Logger.level = Level.debug;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login and Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Welcome to Smile Tour'),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Smile Tour',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),

            //SizedBox(height: 5),
            Center(
              child: Text(
                'Enjoy every moment with us!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Get.to(() => LoginPage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 25, 173, 199),
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Get.to(() => SignupPage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 25, 173, 199),
              ),
              child: Text('Sign Up'),
            ),
            SizedBox(height: 2),
            Image.asset(
              'assets/images/logo_1.gif',
              width: 600,
              height: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
