import 'package:flutter/material.dart';

class RangeSliderV1 extends StatefulWidget {
  const RangeSliderV1({Key? key}) : super(key: key);

  @override
  State<RangeSliderV1> createState() => _RangeSliderV1State();
}

class _RangeSliderV1State extends State<RangeSliderV1> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Color.fromARGB(255, 54, 200, 244),
          inactiveTrackColor: Color.fromARGB(255, 54, 200, 244),
        ),
        child: RangeSlider(
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
            });
          },
        ),
      ),
    );
  }
}
