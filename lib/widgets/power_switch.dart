// import 'package:flutter/material.dart';
//
// class PowerSwitch extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _PowerState();
// }
//
// class _PowerState extends State<PowerSwitch> {
//   bool saving = false;
//   var https = HttpsPresenter('7f26eb40-0d82-11ed-8630-9f730c64b9e5', 0);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text('開關'),
//         Switch(
//             value: saving,
//             onChanged: (value) {
//               setState(() {
//                 saving = !saving;
//                 https.SendToTB();
//               });
//             })
//       ],
//     );
//   }
// }
