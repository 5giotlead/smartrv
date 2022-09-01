import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/shared/models/rv.dart';
import 'package:flutter_rv_pms/utils/constant_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RVCard extends StatelessWidget {
  RVCard({super.key, required this.rv, required this.type});

  RV rv;
  String type;
  final _dio = Modular.get<Dio>();
  final baseImageUrl = 'https://rv.5giotlead.com/static/camp/';

  Future<void> clickIcon() async {
    if (type == 'manage') {
      await _dio.delete<dynamic>('/smartrv/rv/${rv.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.navigate('/booking', arguments: rv);
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
                child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.zero,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    '$baseImageUrl${rv.camp?.fileName}.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'rv',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(33, 45, 82, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: rv.name,
                              style: GoogleFonts.inter(
                                color: const Color.fromRGBO(33, 45, 82, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: clickIcon,
                        child: (type == 'manage')
                            ? Icon(
                                Icons.delete,
                                color: ConstantColors.primaryColor,
                              )
                            : Icon(
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
