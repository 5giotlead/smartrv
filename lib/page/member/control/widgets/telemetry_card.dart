// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:smart_rv_starter/shared/models/telemetry.dart';
//
// class TelemetryCard extends State<> {
//   TelemetryCard(this.telemetryData, {super.key});
//
//   Telemetry telemetryData;
//
//   final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: telemetryData.icon,
//               title: Text('${telemetryData.name}: ${telemetryData.data}'),
//               subtitle: Text(formatter.format(telemetryData.updateTime)),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 TextButton(
//                   child: const Text('Chart'),
//                   onPressed: () {
//                     /* ... */
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 TextButton(
//                   child: const Text('Log'),
//                   onPressed: () {
//                     /* ... */
//                   },
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
