// import 'package:flutter/material.dart';
// import 'package:smart_rv_starter/widgets/models/sensor.dart';

// class SensorData extends StatelessWidget {
//   final List<Sensor> sensers = [
//     Sensor("Temperature", "2022/08/09", "26"),
//     Sensor("Humidity", "2022/08/09", "80"),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 20.0,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 24.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Read Data",
//                   style: TextStyle(
//                     color: Color.fromRGBO(19, 22, 33, 1),
//                     fontSize: 18.0,
//                   ),
//                 ),
//                 Text(
//                   "View All",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ListView.separated(
//             shrinkWrap: true,
//             padding: EdgeInsets.symmetric(
//               horizontal: 16.0,
//               vertical: 10.0,
//             ),
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (BuildContext context, int index) {
//               // Lets pass the order to a new widget and render it there
//               return sensers[index];
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return SizedBox(
//                 height: 15.0,
//               );
//             },
//             itemCount: orders.length,
//           )
//           // Let's create an order model
//         ],
//       ),
//     );
//   }
// }
