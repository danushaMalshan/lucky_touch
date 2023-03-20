
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lucky_touch/beanResponse/get_previous_winners_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class RoundWinnersCard extends StatefulWidget {
  RoundWinnersCard({Key? key, required this.round_no}) : super(key: key);
  int round_no = 0;
  GetPreviousWinnersModel? model;
  @override
  State<RoundWinnersCard> createState() => _RoundWinnersCardState();
}

class _RoundWinnersCardState extends State<RoundWinnersCard> {
  String defaultAvatar =
      'http://luckytouch.win/images/app_avatar/default/user.jpg';
  _getPreviouswinners() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getPreviousWinners(widget.round_no);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    widget.model = GetPreviousWinnersModel.fromJson(parsed);

    return widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getPreviouswinners(),
        builder: ((context, snapshot) {
          if (snapshot.data != null) {
            return Container(
              height: 330,
              width: MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/decoration1.png'),
                ),
                color: Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                    child: Center(
                      child: Text('Round ${widget.round_no}',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.purple,
                              fontSize: 35)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: (widget.model?.data != null &&
                                    widget.model!.data!.length > 1)
                                ? WinnerCircle(
                                    '${widget.model?.data?[1]?.user?.profilePic ?? defaultAvatar}',
                                    '${widget.model?.data?[1]?.rank ?? ''}',
                                    Colors.amberAccent.shade700)
                                : WinnerCircle(defaultAvatar, '',
                                    Colors.amberAccent.shade700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (widget.model?.data != null &&
                                  widget.model!.data!.length > 1)
                              ? Text(
                                  '${widget.model?.data?[1]?.user?.firstName ?? ''}',
                                  style: GoogleFonts.pacifico(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ))
                              : Text(''),
                          (widget.model?.data != null &&
                                  widget.model!.data!.length > 1)
                              ? Text(
                                  '${widget.model?.data?[1]?.price ?? ''}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(''),
                        ],
                      ),
                      Column(
                        children: [
                          (widget.model?.data != null &&
                                  widget.model!.data!.length > 0)
                              ? WinnerCircle(
                                  '${widget.model?.data?[0]?.user?.profilePic ?? defaultAvatar}',
                                  '${widget.model?.data?[0]?.rank ?? ''}',
                                  Colors.blue)
                              : WinnerCircle(
                                  defaultAvatar, '', Colors.blue.shade700),
                          SizedBox(
                            height: 20,
                          ),
                          (widget.model?.data != null &&
                                  widget.model!.data!.length > 0)
                              ? Text(
                                  '${widget.model?.data?[0]?.user?.firstName ?? ''}',
                                  style: GoogleFonts.pacifico(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ))
                              : Text(''),
                          (widget.model?.data != null &&
                                  widget.model!.data!.length > 0)
                              ? Text(
                                  '${widget.model?.data?[0]?.price ?? ''}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(''),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: (widget.model?.data != null &&
                                    widget.model!.data!.length > 2)
                                ? WinnerCircle(
                                    '${widget.model?.data?[2]?.user?.profilePic ?? defaultAvatar}',
                                    '${widget.model?.data?[2]?.rank ?? ''}',
                                    Colors.grey)
                                : WinnerCircle(
                                    defaultAvatar, '', Colors.grey.shade700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (widget.model?.data != null &&
                                  widget.model!.data!.length > 2)
                              ? Text(
                                  '${widget.model?.data?[2]?.user?.firstName ?? ''}',
                                  style: GoogleFonts.pacifico(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ))
                              : Text(''),
                          (widget.model?.data != null &&
                                  widget.model!.data!.length > 2)
                              ? Text(
                                  '${widget.model?.data?[2]?.price ?? ''}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(''),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        }));
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
