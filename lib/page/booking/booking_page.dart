import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_rv_pms/widgets/chart.dart';
import 'package:flutter_rv_pms/widgets/datepicker_range.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required rv});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageStore = Modular.get<PageStore>();
  late dynamic rv;

  @override
  void initState() {
    super.initState();
    rv = Modular.args.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 219, 217, 217),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0.05, 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    width: double.infinity,
                    height: 500,
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Image.network(
                              'https://picsum.photos/seed/403/600',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 1,
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              'https://picsum.photos/seed/268/600',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              'https://picsum.photos/seed/141/600',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: SmoothPageIndicator(
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 3,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) {
                                pageViewController!.animateToPage(
                                  i,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              effect: ExpandingDotsEffect(
                                expansionFactor: 2,
                                spacing: 8,
                                radius: 16,
                                dotWidth: 16,
                                dotHeight: 16,
                                dotColor: Color(0xFF9E9E9E),
                                activeDotColor: Color(0xFF3F51B5),
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0.05),
                          child: Text(
                            (rv?['type'] != null)
                                ? rv['type']['typeName'] as String
                                : 'typeName',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 20),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.3,
                      //   height: 100,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //   ),
                      //   child: Align(
                      //     alignment: AlignmentDirectional(0, 0),
                      //     child: InkWell(
                      //       onTap: () async {},
                      //       child: Text(
                      //         'NOMADIC 5.8',
                      //         style: TextStyle(
                      //             color: Colors.black.withOpacity(0.6)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            (rv?['comments'] != null)
                                ? rv['comments'][0]['rate'].toString()
                                : '尚無評價',
                            style: TextStyle(color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Icon(
                              Icons.star_sharp,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          //   child: Text('135 評價',
                          //       style: TextStyle(color: Colors.black)),
                          // ),
                          Expanded(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Align(
                                alignment:
                                    const AlignmentDirectional(0.8, 0.05),
                                child: Text(
                                    (rv?['camp'] != null)
                                        ? rv['camp']['name'] as String
                                        : 'campName',
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: Column(
                            children: [
                              Text(
                                (rv?['type']['price'] != null)
                                    ? 'NT ${rv['type']['price'].toString() as String}'
                                    : '-',
                                style: const TextStyle(color: Colors.black),
                              ),
                              const DatePickerRange(),
                              // Align(
                              //   alignment: AlignmentDirectional(-1, 0),
                              //   child: Padding(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         0, 3, 0, 0),
                              //     child: Text(
                              //       'NTD 300',
                              //       style: TextStyle(color: Colors.black),
                              //     ),
                              //   ),
                              // ),
                              // Align(
                              //   alignment: AlignmentDirectional(-1, 0),
                              //   child: Padding(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         0, 2, 0, 0),
                              //     child: DatePicker(),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: PrimaryButton(
                              '訂房',
                              () {
                                Modular.to.navigate('/member/check');
                              },
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 1,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Text(
                                  (rv?['description'] != null)
                                      ? rv['description'] as String
                                      : 'description',
                                  style: const TextStyle(color: Colors.black)),
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              height: 150,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ChartCard(),
                                    ChartCard(),
                                    ChartCard(),
                                  ],
                                ),
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
