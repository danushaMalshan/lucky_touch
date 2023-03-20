import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lucky_touch/beanResponse/get_banner_ads.dart';
import 'package:lucky_touch/beanResponse/get_last_round_model.dart';
import 'package:lucky_touch/beanResponse/ticket_model.dart';
import 'package:lucky_touch/screens/tab_screens/tickets_screen.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

import 'package:lucky_touch/widgets/app_bar_without_back_button.dart';


import 'package:url_launcher/url_launcher.dart';

class LotteryScreen extends StatefulWidget {
  LotteryScreen({Key? key}) : super(key: key);

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  GetLastRound? model;
  GetBannerAds? bannersModel;
  TicketModel? ticketModel;
  bool progress = false;
  bool goingtoExpire = false;
  final List<String> items = [
    'https://neilpatel.com/wp-content/uploads/2021/05/food-ads-1.jpg',
    'https://storage.googleapis.com/sales.appinst.io/2021/02/AI_FAFRHTGSAWNCI2021_Banner_1.png',
    'https://www.posist.com/restaurant-times/wp-content/uploads/2019/01/Choicest-online-platforms-to-run-your-restaurant-ads-and-how-to-do-it-USA-1.jpg'
  ];
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  _getRounds() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getLastRound();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    model = GetLastRound.fromJson(parsed);
    await _getBanners();
    await _getTickets();
    return model;
  }

  _getBanners() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getBanners();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    bannersModel = GetBannerAds.fromJson(parsed);
  }

  _getTickets() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getAllTickets();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    ticketModel = TicketModel.fromJson(parsed);
  }

  DateTime checkExpireStatus(DateTime expireDate) {
    DateTime nowDate =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));
    DateTime formattedExprireDate = DateTime.parse(
        DateFormat('yyyy-MM-dd HH:mm').format(expireDate.toLocal()));
    final difference = formattedExprireDate.difference(nowDate).inMinutes;
    print(nowDate);
    print(formattedExprireDate);
    print(difference);

    if (difference <= 60) {
      goingtoExpire = true;

      return formattedExprireDate;
    } else {
      goingtoExpire = false;

      return formattedExprireDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage('assets/images/inside_wallaper.jpg'))
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
          //   // colors: [Colors.blue, Colors.blueAccent, Colors.cyanAccent],
          // ),
          ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBarWithoutBackButton('Home'),
          body: body(context)),
    );
  }

  Widget body(BuildContext context) {
    return FutureBuilder(
        future: _getRounds(),
        builder: ((context, snapshot) {
          if (snapshot.data != null) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/decoration1.png'),
                ),
              ),
              child: Align(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height / 3 - 50,
                              width: double.infinity,
                              child: CarouselSlider.builder(
                                itemCount: (bannersModel?.data?.length == 0)
                                    ? 1
                                    : bannersModel?.data?.length,
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) =>
                                    Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _launchUrl(
                                            '${bannersModel?.data?[itemIndex]?.lunchUrl ?? ''}');
                                      },
                                      child: (bannersModel?.data?.length == 0 ||
                                              bannersModel?.data?[itemIndex]
                                                      ?.bannerUrl ==
                                                  null)
                                          ? bannerWidget(itemIndex,
                                              'https://luckytouch.win/images/banners/default/default_banner.jpg')
                                          : bannerWidget(itemIndex,
                                              '${bannersModel?.data?[itemIndex]?.bannerUrl ?? 'https://luckytouch.win/images/banners/default/default_banner.jpg'}'),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      right: 30,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.pinkAccent,
                                                Colors.deepPurpleAccent,
                                                Colors.red
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.white, width: 2)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'More',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Icon(
                                              Icons.double_arrow_outlined,
                                              size: 18,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                options: CarouselOptions(
                                  autoPlay: true,

                                  height: 800,
                                  // viewportFraction: 0.8,
                                  // enlargeCenterPage: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width - 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 5,
                                //     blurRadius: 7,
                                //     offset: Offset(
                                //         0, 3), // changes position of shadow
                                //   ),
                                // ],
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned.fill(
                                    // left: (MediaQuery.of(context).size.width - 260) / 2,
                                    top: -125,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 270,
                                        child: Image.asset(
                                            'assets/images/trophy.png'),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey.withOpacity(0.5),
                                        //     spreadRadius: 5,
                                        //     blurRadius: 7,
                                        //     offset: Offset(0,
                                        //         3), // changes position of shadow
                                        //   ),
                                        // ],
                                      ),
                                      height: 220,
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: Column(
                                        children: [
                                          (model?.roundNo == null ||
                                                  model?.roundNo == 0)
                                              ? Text(
                                                  'Round Not Added',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 30),
                                                )
                                              : Text(
                                                  'Round ${model?.roundNo ?? 'Not Added'}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 30),
                                                ),
                                          (model?.roundNo == null ||
                                                  model?.roundNo == 0)
                                              ? Text(
                                                  '',
                                                  style: new TextStyle(
                                                    fontSize: 45.0,
                                                    fontWeight: FontWeight.bold,
                                                    foreground: Paint()
                                                      ..shader = LinearGradient(
                                                        colors: <Color>[
                                                          Colors.pinkAccent,
                                                          Colors
                                                              .deepPurpleAccent,
                                                          Colors.red
                                                          //add more color here.
                                                        ],
                                                      ).createShader(
                                                        Rect.fromLTWH(0.0, 0.0,
                                                            200.0, 100.0),
                                                      ),
                                                  ),
                                                )
                                              : Text(
                                                  "${model?.price ?? ''} USDT",
                                                  style: new TextStyle(
                                                    fontSize: 45.0,
                                                    fontWeight: FontWeight.bold,
                                                    foreground: Paint()
                                                      ..shader = LinearGradient(
                                                        colors: <Color>[
                                                          Colors.pinkAccent,
                                                          Colors
                                                              .deepPurpleAccent,
                                                          Colors.red
                                                          //add more color here.
                                                        ],
                                                      ).createShader(
                                                        Rect.fromLTWH(0.0, 0.0,
                                                            200.0, 100.0),
                                                      ),
                                                  ),
                                                ),
                                          Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: CountDownText(
                                                due: checkExpireStatus(
                                                    DateTime.parse(
                                                        "${model?.endAt ?? '2000-00-00'}")),
                                                finishedText:
                                                    (model?.roundNo == null ||
                                                            model?.roundNo == 0)
                                                        ? ''
                                                        : "Finished",
                                                showLabel: true,
                                                longDateName: false,
                                                daysTextLong: " days",
                                                hoursTextLong: " hours",
                                                minutesTextLong: " mini",
                                                secondsTextLong: "S",
                                                style: goingtoExpire
                                                    ? TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)
                                                    : TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.purple),
                                              )),
                                          (ticketModel?.data?.length ?? 0) != 0
                                              ? GestureDetector(
                                                  onTap: () {
                                                    // add your code here.

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TicketsScreen()));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.only(top: 8),
                                                    height: 60,
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.pinkAccent,
                                                          Colors
                                                              .deepPurpleAccent,
                                                          Colors.red
                                                        ],
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'BUY TICKET',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 8),
                                                      height: 60,
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Colors.pinkAccent
                                                                .withOpacity(
                                                                    0.5),
                                                            Colors
                                                                .deepPurpleAccent
                                                                .withOpacity(
                                                                    0.5),
                                                            Colors.red
                                                                .withOpacity(
                                                                    0.5)
                                                          ],
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'BUY TICKET',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 23,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'New tickets have not been added yet',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SpinKitWave(
              color: Colors.amberAccent,
              size: 80,
            );
          }
        }));
  }

  Container bannerWidget(int itemIndex, String url) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
        // border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.5),
        image: DecorationImage(
            image: NetworkImage(correctHost(url)), fit: BoxFit.fitWidth),
      ),
    );
  }
}
