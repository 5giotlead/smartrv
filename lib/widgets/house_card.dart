import 'package:flutter_rv_pms/widgets/models/property.dart';
import 'package:flutter_rv_pms/utils/constant_colors.dart';
import 'package:flutter_rv_pms/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

String base_image_url = 'https://rv.5giotlead.com/static/camp/';

class HouseCard extends StatelessWidget {
  HouseCard(this.house);
  HouseProperty house;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Helper.nextPage(context, SinglePropertyPage());
        String id = 'axssaf';
        print('booking');
        Modular.to.navigate('/booking', arguments: id);
      },
      child: Container(
        height: 300,
        width: 500,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(244, 245, 246, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      base_image_url + house.imagePath,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  )),
            )),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    house.location,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(33, 45, 82, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   house.description,
                  //   style: const TextStyle(
                  //     fontSize: 13,
                  //     color: Color.fromRGBO(138, 150, 190, 1),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            // TextSpan(
                            //   text: "From\n",
                            //   style: GoogleFonts.inter(
                            //     color: Color.fromRGBO(64, 74, 106, 1),
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                            TextSpan(
                              text: house.name,
                              style: GoogleFonts.inter(
                                color: Color.fromRGBO(33, 45, 82, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('已加入我的最愛');
                        },
                        child: Icon(
                          Icons.favorite,
                          color: ConstantColors.primaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
