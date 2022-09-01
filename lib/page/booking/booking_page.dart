import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_rv_pms/shared/models/rv.dart';
import 'package:flutter_rv_pms/widgets/comment.dart';
import 'package:flutter_rv_pms/widgets/datepicker_range.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

String baseImageUrl = 'https://rv.5giotlead.com/static/rv/';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required rv});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageStore = Modular.get<PageStore>();
  late RV rv;

  @override
  void initState() {
    super.initState();
    rv = Modular.args.data as RV;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 219, 217, 217),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: const AlignmentDirectional(0.05, 0.05),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageViewController ??=
                              PageController(initialPage: 0),
                          children: [
                            Image.network(
                              (rv.type?.filenames != null &&
                                      rv.type!.filenames.isNotEmpty)
                                  ? '$baseImageUrl${rv.type?.filenames[0]}.jpg'
                                  : '${baseImageUrl}1ca79d6e-340a-47b7-a426-4e7c367b6d3f.jpg',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 1,
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              (rv.type?.filenames != null &&
                                      rv.type!.filenames.isNotEmpty)
                                  ? '$baseImageUrl${rv.type?.filenames[1]}.jpg'
                                  : '${baseImageUrl}0dfb1be0-a9b3-44b3-b3ce-65b1db46ba64.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              (rv.type?.filenames != null &&
                                      rv.type!.filenames.isNotEmpty)
                                  ? '$baseImageUrl${rv.type?.filenames[2]}.jpg'
                                  : '${baseImageUrl}dc331115-0174-40de-8648-5c5049574f32.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0,
                              0,
                              0,
                              10,
                            ),
                            child: SmoothPageIndicator(
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 3,
                              onDotClicked: (i) {
                                pageViewController!.animateToPage(
                                  i,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              effect: const ExpandingDotsEffect(
                                expansionFactor: 2,
                                dotColor: Color(0xFF9E9E9E),
                                activeDotColor: Color(0xFF3F51B5),
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0.05),
                          child: Text(
                            (rv.type?.typeName != null)
                                ? rv.type!.typeName!
                                : 'typeName',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        20,
                        0,
                        0,
                        0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            (rv.comments.isNotEmpty)
                                ? rv.comments[0]!.rate.toString()
                                : '尚無評價',
                            style: const TextStyle(color: Colors.black),
                          ),
                          const Padding(
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
                                    (rv.camp?.name != null)
                                        ? rv.camp!.name!
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
                        child: Column(
                          children: [
                            Text(
                              (rv.type?.price != null)
                                  ? 'NT ${rv.type!.price.toString()}'
                                  : '-',
                              style: const TextStyle(color: Colors.black),
                            ),
                            const DatePickerRange(),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              20,
                              20,
                              20,
                              20,
                            ),
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
                            10,
                            10,
                            10,
                            10,
                          ),
                          child: Text(
                            (rv.description != null)
                                ? rv.description!
                                : 'description',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          height: 150,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            20,
                            0,
                            0,
                            0,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0,
                              10,
                              0,
                              0,
                            ),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var comment in rv.comments)
                                  CommentCard(comment!)
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
