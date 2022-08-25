import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  String imgPath;
  Avatar(this.imgPath);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 20.0,
      backgroundImage: AssetImage(imgPath),
      child: PopupMenuButton<Text>(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              child: Text('First'),
            ),
            const PopupMenuItem(
              child: Text('Second'),
            ),
            const PopupMenuItem(
              child: Text('Third'),
            ),
          ];
        },
        tooltip: 'Me',
      ),
    );
  }
}
