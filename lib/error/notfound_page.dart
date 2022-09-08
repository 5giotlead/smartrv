import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/page/widgets/bottom_nav_bar.dart';
import 'package:flutter/rendering.dart';

class NotFoundPage extends StatelessWidget {
  NotFoundPage();

  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 219, 217, 217),
      ),
      child: Expanded(
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            child: const Text('Not Found'),
          ),
        ),
      ),
    );
  }
}
