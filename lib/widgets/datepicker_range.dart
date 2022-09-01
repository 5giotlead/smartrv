import 'package:flutter/material.dart';

class DatePickerRange extends StatefulWidget {
  const DatePickerRange({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerRange> createState() => _DatePickerRangeState();
}

class _DatePickerRangeState extends State<DatePickerRange>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  final RestorableDateTimeN _endDate = RestorableDateTimeN(
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
      _restorableDateRangePickerRouteFuture,
      'date_picker_route_future',
    );
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(DateTime.now().year),
          currentDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
          lastDate: DateTime(DateTime.now().year + 1),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
          arguments['initialStartDate'] as int,
        ),
        end: DateTime.fromMillisecondsSinceEpoch(
          arguments['initialEndDate'] as int,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.date_range),
        iconSize: 20,
        tooltip: 'Date',
        onPressed: _restorableDateRangePickerRouteFuture.present,
      ),
      const Text(
        '2022/08/25~2022/09/28',
        style: TextStyle(fontSize: 10),
      )
    ]);
  }
}
