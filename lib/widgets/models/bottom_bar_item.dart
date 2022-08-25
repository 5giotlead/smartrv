import 'package:flutter/material.dart';

class BottomBarItem {
  String key;
  IconData icon;
  Function onPressed;

  BottomBarItem(this.onPressed, this.icon, this.key);
}
