import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:intl/intl.dart';

class CustomTicket extends StatefulWidget {
  final int price;
  final Color color;
  final String number;
  final String date;
  final int roundNo;

  CustomTicket({
    Key? key,
    required this.price,
    required this.color,
    required this.number,
    required this.date,
    required this.roundNo,
  }) : super(key: key);

  @override
  State<CustomTicket> createState() => _CustomTicketState();
}

class _CustomTicketState extends State<CustomTicket> {
  bool goingtoExpire = false;

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
      setState(() {
        goingtoExpire = true;
      });

      return formattedExprireDate;
    } else {
      setState(() {
        goingtoExpire = false;
      });
      return formattedExprireDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: ClipPath(
        clipper: CustomClip(),
        child: Container(
          height: 230,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
              color: Colors.amberAccent,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.color,
                    Colors.white,
                    widget.color,
                  ])),
          child: CustomPaint(
            foregroundPainter: Painter(),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20.0, top: 6),
                                child: Text(
                                  'Round :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20.0, top: 0),
                                child: Text(
                                  'No :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 24.0, right: 15),
                            child: Text(
                              'Lucky \nTouch',
                              style: GoogleFonts.satisfy(
                                textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 34,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 180,
                      width: 2,
                      color: Colors.brown,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              '${widget.roundNo}',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            width: 145,
                            margin: EdgeInsets.only(top: 8, left: 20),
                          ),
                          Container(
                            child: Text(
                              widget.number,
                              style: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            width: 145,
                            margin: EdgeInsets.only(top: 8, left: 20),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.price}',
                                  style: GoogleFonts.pacifico(
                                    textStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 60,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    'USDT',
                                    style: GoogleFonts.merriweather(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 20),
                              child: CountDownText(
                                due: checkExpireStatus(
                                    DateTime.parse("${widget.date}")),
                                finishedText: "Expired!",
                                showLabel: true,
                                longDateName: false,
                                daysTextLong: " days",
                                hoursTextLong: " hours",
                                minutesTextLong: " mini",
                                secondsTextLong: "S",
                                style: goingtoExpire
                                    ? TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red)
                                    : TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(15, 50);
    path.lineTo(15, size.height - 50);
    path.quadraticBezierTo(50, size.height - 50, 50, size.height - 15);
    path.lineTo(size.width - 50, size.height - 15);
    path.quadraticBezierTo(
        size.width - 50, size.height - 50, size.width - 15, size.height - 50);
    path.lineTo(size.width - 15, 50);
    path.quadraticBezierTo(size.width - 50, 50, size.width - 50, 15);
    path.lineTo(50, 15);
    path.quadraticBezierTo(50, 50, 15, 50);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
  
    return false;
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(30, size.height - 30, 30, size.height);
    path.lineTo(size.width - 30, size.height);
    path.quadraticBezierTo(
        size.width - 30, size.height - 30, size.width, size.height - 30);
    path.lineTo(size.width, 30);
    path.quadraticBezierTo(size.width - 30, 30, size.width - 30, 0);
    path.lineTo(30, 0);
    path.quadraticBezierTo(30, 30, 0, 30);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  
    return false;
  }
}
