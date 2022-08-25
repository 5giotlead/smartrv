import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  final _tbClient = Modular.get<ThingsboardClient>();

  Future<void> _saveOrd() async {
    final data = jsonEncode({
      'total': 3000,
      'state': '',
      'startDate': '2022-08-25',
      'endDate': '2022-08-26',
      'userId': '',
      'discountId': ''
    });
    print(await _tbClient.post<String>('/smartrv/ord', data: data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 217, 217),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                tooltip: 'xxx',
              );
            },
          ),
          title: const Text('申請預定'),
          actions: [
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            //   child: IconButton(
            //     icon: const Icon(Icons.access_time_filled_outlined),
            //     tooltip: 'aa',
            //     onPressed: () {
            //       // Modular.to.navigate('/auth/logout');
            //       ScaffoldMessenger.of(context)
            //           .showSnackBar(const SnackBar(content: Text('Home')));
            //     },
            //   ),
            // ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 24, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOMADIC 5.8 遊牧款豪華衛浴車',
                          // style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  size: 20,
                                ),
                              ),
                              Text(
                                '2022/08/22-2022/08/24',
                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.access_time_rounded,
                                  size: 20,
                                ),
                              ),
                              Text(
                                '9:30am',
                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              indent: 16,
              endIndent: 16,
              // color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                      child: Text(
                        '人數',
                        // style: FlutterFlowTheme.of(context).subtitle1,
                      ),
                    ),
                  ),
                  Text(
                    '5',
                  ),
                ],
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              indent: 16,
              endIndent: 16,
              // color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                      child: Text(
                        '付款方式',
                        // style: FlutterFlowTheme.of(context).subtitle1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    child: Icon(
                      Icons.credit_card,
                      // color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                  ),
                  Text(
                    '信用卡',
                    // style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      // color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              indent: 16,
              endIndent: 16,
              // color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '價格明細',
                    // style: FlutterFlowTheme.of(context).subtitle1,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '費用一',
                          // style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Text(
                          '\$150',
                          // style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '費用二',
                          // style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Text(
                          '\$25621',
                          // style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              indent: 16,
              endIndent: 16,
              // color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '總價',
                    // style: FlutterFlowTheme.of(context).subtitle1,
                  ),
                  Text(
                    '\$50000',
                    // style: FlutterFlowTheme.of(context).title3,
                  ),
                ],
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              indent: 16,
              endIndent: 16,
              // color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Text(
                  '尺寸 : 含托架全車長710公分，車高2米4，車寬2米2。特色 :高級乾濕分離衛浴設備、寢室與上下舖分區住宿互不打擾、mini吧檯(活動層板/可放置冰箱與除溼機)、專屬USB插座，新穎設計好整理/可快速移動。適合「營業」擺放：露營區 、休閒農場、飯店、民宿、度假村皆適宜。',
                  // style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: PrimaryButton(
                  '確認送出',
                  () {
                    print('123');
                  },
                )),
          ],
        ));
  }
}
