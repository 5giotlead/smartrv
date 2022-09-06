import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/shared/models/rv.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required rv});

  @override
  State<StatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _tbClient = Modular.get<ThingsboardClient>();
  late RV rv = RV('', '', '', 0, '', null, null, [], []);

  Future<void> _saveOrd() async {
    final data = jsonEncode({
      'total': 3000,
      'state': '',
      'startDate': '2022-08-25',
      'endDate': '2022-08-26',
      'userId': '',
      'discountId': ''
    });
    await _tbClient.post<String>('/smartrv/ord', data: data);
  }

  @override
  void initState() {
    super.initState();
    if (Modular.args.data != null) {
      rv = Modular.args.data as RV;
    } else {
      // Modular.to.navigate('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 217, 217),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('申請預定'),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rv.type?.typeName ?? 'type',
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0,
                          8,
                          0,
                          0,
                        ),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                0,
                                8,
                                0,
                              ),
                              child: Icon(
                                Icons.date_range_rounded,
                                size: 20,
                              ),
                            ),
                            Text(
                              '2022/08/22-2022/08/24',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0,
                          4,
                          0,
                          0,
                        ),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                0,
                                8,
                                0,
                              ),
                              child: Icon(
                                Icons.access_time_rounded,
                                size: 20,
                              ),
                            ),
                            Text(
                              '9:30am',
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
          const Divider(
            height: 24,
            thickness: 2,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      '人數',
                    ),
                  ),
                ),
                Text(
                  '5',
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            thickness: 2,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      '付款方式',
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
          const Divider(
            height: 24,
            thickness: 2,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '價格明細',
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '費用一',
                        // style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      Text(
                        r'$150',
                        // style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '費用二',
                      ),
                      Text(
                        r'$25621',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            thickness: 2,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '總價',
                ),
                Text(
                  r'$50000',
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            thickness: 2,
            indent: 16,
            endIndent: 16,
            // color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Text(
                (rv.description != null) ? rv.description! : 'description',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
