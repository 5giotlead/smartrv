import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeRangeSlider extends StatefulWidget {
  const HomeRangeSlider({Key? key}) : super(key: key);

  @override
  State<HomeRangeSlider> createState() => _HomeRangeSliderState();
}

class _HomeRangeSliderState extends State<HomeRangeSlider> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  TextEditingController controller_min = new TextEditingController();
  TextEditingController controller_max = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color.fromARGB(255, 54, 200, 244),
            inactiveTrackColor: Color.fromARGB(255, 54, 200, 244),
          ),
          child: Column(
            children: [
              RangeSlider(
                values: _currentRangeValues,
                max: 100,
                divisions: 5,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                    controller_min.text = values.start.toString();
                    controller_max.text = values.end.toString();
                    // print(values.start.toString());
                    // print(values.end.toString());
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: TextField(
                        controller: controller_min,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: TextField(
                        controller: controller_max,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
