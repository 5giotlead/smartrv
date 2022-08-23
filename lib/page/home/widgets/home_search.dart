import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/page/home/page/home_filter_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSearch extends StatelessWidget {
  HomeSearch();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();

    return GestureDetector(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(251, 251, 251, 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onEditingComplete: () {
                  print('enter finish');
                  print(controller.text);
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    labelText: '要去哪裡呢?',
                    border: InputBorder.none,
                    hintText: '輸入房型關鍵字...',
                    hintStyle: GoogleFonts.inter(
                      color: const Color.fromRGBO(153, 163, 196, 1),
                    ),
                    suffix: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        print('close');
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                    )),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 112, 195, 228),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                icon: const Icon(Icons.settings_input_composite_outlined),
                tooltip: 'Filter',
                onPressed: () {
                  print('Click Filter');
                  // Navigator.of(context).push(_createRoute());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomeFilterPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
