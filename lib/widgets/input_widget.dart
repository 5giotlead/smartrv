import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  String hintText;
  IconData suffixIcon;
  bool obscureText;
  bool isValidator;
  TextEditingController controller = TextEditingController();

  InputWidget(
      this.hintText, this.obscureText, this.suffixIcon, this.isValidator) {
    this.controller.text = this.hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 247, 249, 1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        controller: controller,
        obscureText: this.obscureText,
        decoration: InputDecoration(
          hintText: this.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(124, 124, 124, 1),
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: this.suffixIcon == null
              ? null
              : Icon(
                  this.suffixIcon,
                  color: Color.fromRGBO(105, 108, 121, 1),
                ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        validator: this.isValidator == null
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return '請輸入字元...';
                }
                return null;
              },
      ),
    );
  }
}
