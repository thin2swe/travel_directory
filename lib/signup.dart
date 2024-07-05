import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_directory/controller/singup_controller.dart';
import 'package:travel_directory/login.dart';
import 'package:travel_directory/models/user.dart';
import 'package:travel_directory/widgets/text_field.dart';

void main() {
  runApp(GetMaterialApp(home: SignupPage()));
}

class SignupPage extends StatelessWidget {
  final nameCtrl = TextEditingController();
  final displayNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final SingupController controller = Get.put(SingupController());
  //User user = User(userName: '', password: '');

  User mapToUser(
      TextEditingController name,
      TextEditingController dispName,
      TextEditingController pass,
      TextEditingController email,
      TextEditingController phone) {
    return User(
        userName: name.text,
        password: pass.text,
        email: email.text,
        phone: phone.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 25, 173, 199)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        "Create an account, It's free !",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: makeInput(
                          label: "User Name",
                          ctrl: nameCtrl,
                          icon: Icon(Icons.people))),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: makeInput(
                          label: "Password",
                          obscureText: true,
                          ctrl: passwordCtrl,
                          icon: Icon(Icons.lock))),
                  FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Confirm Password",
                          obscureText: true,
                          ctrl: confirmPassCtrl,
                          icon: Icon(Icons.lock))),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: makeInput(
                          label: "Email",
                          ctrl: emailCtrl,
                          icon: Icon(Icons.email))),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: makeInput(
                          label: "Phone",
                          ctrl: phoneCtrl,
                          icon: Icon(Icons.phone))),
                ],
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 1500),
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
                      height: 10,
                      onPressed: () {
                        controller.register(mapToUser(nameCtrl, displayNameCtrl,
                            passwordCtrl, emailCtrl, phoneCtrl));
                        Get.to(LoginPage());
                      },
                      color: Color.fromARGB(255, 25, 173, 199),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  )),
              FadeInUp(
                duration: Duration(milliseconds: 1600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account ! "),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginPage());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
