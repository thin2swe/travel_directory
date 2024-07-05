import 'package:flutter/material.dart';

Widget makeInput({label, obscureText = false, ctrl, Icon? icon}) {
//Widget makeInput({label, obscureText = false, ctrl, Icon? icon, required Icon prefixicon, required InkWell suffixIcon}) {
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
          prefixIcon: icon,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
