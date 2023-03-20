
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucky_touch/beanResponse/get_last_round_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/round_winners_card.dart';

class PreviousWinnersScreen extends StatefulWidget {
  PreviousWinnersScreen({Key? key}) : super(key: key);
  GetLastRound? model;
  @override
  State<PreviousWinnersScreen> createState() => _PreviousWinnersScreenState();
}

class _PreviousWinnersScreenState extends State<PreviousWinnersScreen> {
  int lastRound = 0;
  _getRounds() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getLastRound();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    widget.model = GetLastRound.fromJson(parsed);

    lastRound = widget.model?.roundNo ?? 0;
    return widget.model;
  }

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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: FutureBuilder(
            future: _getRounds(),
            builder: ((context, snapshot) {
              if (snapshot.data != null && widget.model!.roundNo! > 1) {
                return ListView.builder(
                  reverse: false,
                  itemCount: lastRound > 5 ? 5 : lastRound - 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: RoundWinnersCard(
                          round_no: lastRound > 5
                              ? index + lastRound - 5
                              : index + 1),
                    );
                  },
                );
              } else if (widget.model!.roundNo! < 2) {
                return Center(
                  child: Text(
                    'No  previous rounds',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                );
              } else {
                return SpinKitWave(
                  color: Colors.amberAccent,
                  size: 80,
                );
              }
            }),
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
            backgroundImage: AssetImage(img),
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
                    style: GoogleFonts.pacifico(
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
