import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/page/home/widgets/home_range_slider.dart';

class HomeFilterPage extends StatelessWidget {
  HomeFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 217, 217),
        appBar: AppBar(
          title: const Text('PMS'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: ListBody(children: [
            HomeRangeSlider(),
            // RangeSliderV1((value) {
            //   print(value.toString());
            // }),
          ]),
        ));
  }
}
