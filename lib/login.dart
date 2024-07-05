import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_directory/controller/login_controller.dart';
import 'package:travel_directory/home.dart';
import 'package:travel_directory/signup.dart';
import 'package:travel_directory/widgets/text_field.dart';

void main() {
  runApp(GetMaterialApp(home: LoginPage()));
}

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final nameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 25, 173, 199)),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1200),
                          child: Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1200),
                            child: makeInput(
                                label: "Name",
                                ctrl: nameCtrl,
                                icon: Icon(Icons.people))),
                        FadeInUp(
                            duration: Duration(milliseconds: 1300),
                            child: makeInput(
                                label: "Password",
                                obscureText: true,
                                ctrl: passwordCtrl,
                                icon: Icon(Icons.lock))),
                      ],
                    ),
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              controller.check(
                                  nameCtrl.text, passwordCtrl.text);
                              if (controller.user.value != null) {
                                Get.to(HomePage());
                              }
                            },
                            color: Color.fromARGB(255, 25, 173, 199),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignupPage());
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors
                                  .blue, // Optionally, you can set the color of the link
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo_1.gif'),
                    fit: BoxFit.contain, // Change fit to BoxFit.contain
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
