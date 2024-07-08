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

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameCtrl = TextEditingController();
  final displayNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final SignupController controller = Get.put(SignupController());
  String errorMessage = '';
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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

  void registerUser(BuildContext context) {
    if (passwordCtrl.text != confirmPassCtrl.text) {
      setState(() {
        errorMessage = 'Password and Confirm Password do not match';
      });
    } else {
      setState(() {
        errorMessage = '';
      });
      controller.register(mapToUser(
          nameCtrl, displayNameCtrl, passwordCtrl, emailCtrl, phoneCtrl));
      Get.to(LoginPage());
    }
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
                        "Create an account, It's free!",
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
                          obscureText: !isPasswordVisible,
                          ctrl: passwordCtrl,
                          icon: Icon(Icons.lock),
                          togglePasswordVisibility: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          isPasswordVisible: isPasswordVisible)),
                  FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Confirm Password",
                          obscureText: !isConfirmPasswordVisible,
                          ctrl: confirmPassCtrl,
                          icon: Icon(Icons.lock),
                          togglePasswordVisibility: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                          isPasswordVisible: isConfirmPasswordVisible)),
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
              if (errorMessage.isNotEmpty)
                FadeInUp(
                  duration: Duration(milliseconds: 1500),
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  ),
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
                      onPressed: () => registerUser(context),
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
                    Text("Already have an account! "),
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

  Widget makeInput(
      {required String label,
      bool obscureText = false,
      required TextEditingController ctrl,
      required Icon icon,
      VoidCallback? togglePasswordVisibility,
      bool? isPasswordVisible}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: ctrl,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            prefixIcon: icon,
            suffixIcon: togglePasswordVisibility != null
                ? IconButton(
                    icon: Icon(isPasswordVisible!
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: togglePasswordVisibility,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
