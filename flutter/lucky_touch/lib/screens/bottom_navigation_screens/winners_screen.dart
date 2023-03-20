import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucky_touch/providers/model_winners_screen.dart';
import 'package:lucky_touch/screens/bottom_navigation_screens/previous_winners_screen.dart';

import 'package:lucky_touch/widgets/app_bar_without_back_button.dart';
import 'package:provider/provider.dart';

class Winners extends StatelessWidget {
  Winners({Key? key}) : super(key: key);
  String defaultAvatar =
      'http://luckytouch.win/images/app_avatar/default/user.jpg';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
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
          appBar: CustomAppBarWithoutBackButton('Winners'),
          backgroundColor: Colors.transparent,
          body: FutureBuilder(
            future: context.read<ModelWinnersScreen>().getWinners(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data != null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2,
                        // color: Colors.red,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/decoration1.png'),
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipPath(
                              clipper: CustomClip(),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 40,
                                color: Colors.blue,
                              ),
                            ),
                            (context
                                            .watch<ModelWinnersScreen>()
                                            .lastRoundModel
                                            ?.roundNo ==
                                        null ||
                                    context
                                            .watch<ModelWinnersScreen>()
                                            .lastRoundModel
                                            ?.roundNo ==
                                        '' ||
                                    context
                                            .watch<ModelWinnersScreen>()
                                            .lastRoundModel
                                            ?.roundNo ==
                                        0)
                                ? Container()
                                : Positioned(
                                    bottom: -69,
                                    child: Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      color: Color(0xFF1D1CE5),
                                      child: Center(
                                          child: Text(
                                        'Round ${context.watch<ModelWinnersScreen>().lastRoundModel?.roundNo ?? ''}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )),
                            Positioned(
                                top: 50,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                PreviousWinnersScreen())));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      // color: Colors.white.withOpacity(0.4)
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.pinkAccent,
                                          Colors.deepPurpleAccent,
                                          Colors.red
                                        ],
                                      ),
                                    ),
                                    height: 40,
                                    width: 100,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Previous\nWinners',
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Icon(
                                            Icons.double_arrow,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Positioned.fill(
                              bottom: 180,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data !=
                                                null &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model!
                                                    .data!
                                                    .length >=
                                                1 &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model!
                                                    .data?[0]
                                                    ?.rank ==
                                                1
                                        ? WinnerCircle(
                                            '${context.watch<ModelWinnersScreen>().model!.data?[0]?.user?.profilePic ?? defaultAvatar}',
                                            '1',
                                            Colors.blue)
                                        : WinnerCircle(
                                            defaultAvatar, '1', Colors.blue),
                                    context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data !=
                                                null &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model!
                                                    .data!
                                                    .length >=
                                                1 &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data?[0]
                                                    ?.rank ==
                                                1
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              context
                                                      .watch<
                                                          ModelWinnersScreen>()
                                                      .model
                                                      ?.data?[0]
                                                      ?.user
                                                      ?.firstName ??
                                                  '',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              'Choosing',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 120,
                              left: 20,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data !=
                                                null &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model!
                                                    .data!
                                                    .length >=
                                                2 &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data?[1]
                                                    ?.rank ==
                                                2
                                        ? WinnerCircle(
                                            '${context.watch<ModelWinnersScreen>().model?.data?[1]?.user?.profilePic ?? defaultAvatar}',
                                            '2',
                                            Colors.amberAccent.shade700)
                                        : WinnerCircle(defaultAvatar, '2',
                                            Colors.amberAccent.shade700),
                                    context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data !=
                                                null &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model!
                                                    .data!
                                                    .length >=
                                                2 &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data?[1]
                                                    ?.rank ==
                                                2
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              context
                                                      .watch<
                                                          ModelWinnersScreen>()
                                                      .model
                                                      ?.data?[1]
                                                      ?.user
                                                      ?.firstName ??
                                                  'Choosing',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              'Choosing',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 120,
                              right: 20,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data !=
                                                null &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model!
                                                    .data!
                                                    .length >=
                                                3 &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data?[2]
                                                    ?.rank ==
                                                3
                                        ? WinnerCircle(
                                            '${context.watch<ModelWinnersScreen>().model?.data?[2]?.user?.profilePic ?? defaultAvatar}',
                                            '3',
                                            Colors.grey)
                                        : WinnerCircle(
                                            defaultAvatar, '3', Colors.grey),
                                    context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data !=
                                                null &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model!
                                                    .data!
                                                    .length >=
                                                3 &&
                                            context
                                                    .watch<ModelWinnersScreen>()
                                                    .model
                                                    ?.data?[2]
                                                    ?.rank ==
                                                3
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              context
                                                      .watch<
                                                          ModelWinnersScreen>()
                                                      .model
                                                      ?.data?[2]
                                                      ?.user
                                                      ?.firstName ??
                                                  '',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              'Choosing',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 40,
                              left: 25,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: context
                                                .watch<ModelWinnersScreen>()
                                                .model
                                                ?.data !=
                                            null &&
                                        context
                                                .watch<ModelWinnersScreen>()
                                                .model!
                                                .data!
                                                .length >=
                                            2 &&
                                        context
                                                .watch<ModelWinnersScreen>()
                                                .model
                                                ?.data?[1]
                                                ?.rank ==
                                            2
                                    ? Text(
                                        '${context.watch<ModelWinnersScreen>().model?.data?[1]?.price ?? 0} USDT',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Text(
                                        '. . . .',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 110,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: context
                                                .watch<ModelWinnersScreen>()
                                                .model
                                                ?.data !=
                                            null &&
                                        context
                                                .watch<ModelWinnersScreen>()
                                                .model!
                                                .data!
                                                .length >=
                                            1 &&
                                        context
                                                .watch<ModelWinnersScreen>()
                                                .model
                                                ?.data?[0]
                                                ?.rank ==
                                            1
                                    ? Text(
                                        '${context.watch<ModelWinnersScreen>().model?.data?[0]?.price ?? 0} USDT',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Text(
                                        '. . . .',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 40,
                              right: 25,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: context
                                                .watch<ModelWinnersScreen>()
                                                .model
                                                ?.data !=
                                            null &&
                                        context
                                                .watch<ModelWinnersScreen>()
                                                .model!
                                                .data!
                                                .length >=
                                            3 &&
                                        context
                                                .watch<ModelWinnersScreen>()
                                                .model
                                                ?.data?[2]
                                                ?.rank ==
                                            3
                                    ? Text(
                                        '${context.watch<ModelWinnersScreen>().model?.data?[2]?.price ?? 0} USDT',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Text(
                                        '. . . .',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: -20,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(
                                  'assets/images/trophy.png',
                                  height: 140,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 90),
                          child: ListView.builder(
                              itemCount: context
                                  .watch<ModelWinnersScreen>()
                                  .model
                                  ?.data
                                  ?.length,
                              itemBuilder: ((context, index) {
                                var item = context
                                    .watch<ModelWinnersScreen>()
                                    .model
                                    ?.data;
                                return item![index]!.rank! > 3
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, bottom: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        height: 90,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${item[index]?.rank ?? ''}.',
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 28,
                                                  backgroundImage: NetworkImage(
                                                      '${item[index]?.user?.profilePic ?? defaultAvatar}'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                  '${item[index]?.user?.firstName ?? ''}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25, bottom: 7),
                                              child: Text(
                                                '${item[index]?.price ?? ''} USDT',
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container();
                              })),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return SpinKitWave(
                  color: Colors.amberAccent,
                  size: 80,
                );
              }
            },
          )),
    );
  }

  Widget WinnerCircle(String img, String rank, Color color) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 55,
          child: CircleAvatar(
            backgroundImage: NetworkImage(img),
            radius: 50,
          ),
        ),
        Positioned.fill(
          bottom: -15,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 17,
                backgroundColor: color,
                child: Center(
                  child: Text(
                    rank,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);

    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(0, size.height - 100, 20, size.height - 100);
    path.lineTo((size.width / 3) - 20, size.height - 100);
    path.quadraticBezierTo((size.width / 3), size.height - 100,
        (size.width / 3), size.height - 120);
    path.lineTo(size.width / 3, size.height - 140);
    path.quadraticBezierTo((size.width / 3), size.height - 160,
        (size.width / 3) + 20, size.height - 160);
    path.lineTo(((size.width / 3) * 2) - 20, size.height - 160);
    path.quadraticBezierTo((size.width / 3) * 2, size.height - 160,
        (size.width / 3) * 2, size.height - 140);
    path.lineTo((size.width / 3) * 2, size.height - 120);
    path.quadraticBezierTo((size.width / 3) * 2, size.height - 100,
        ((size.width / 3) * 2) + 20, size.height - 100);
    path.lineTo(size.width - 20, size.height - 100);
    path.quadraticBezierTo(
        size.width, size.height - 100, size.width, size.height - 80);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    
    return false;
  }
}
