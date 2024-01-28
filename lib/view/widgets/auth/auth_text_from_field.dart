import 'package:flutter/material.dart';
import 'package:mydoctor/utils/constants.dart';

class AuthTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  String hintText;
  final Function validator;
  final TextInputType textInputType;
  final Widget prefixIcon;
  final Widget suffixIcon;

  AuthTextFromField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.hintText,
    required this.textInputType,
    required this.prefixIcon,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: grey,
      style: TextStyle(color: grey),
      keyboardType: textInputType,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          label: Text(
            hintText,
            style: TextStyle(color: Colors.black38),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mainColor2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }
}
