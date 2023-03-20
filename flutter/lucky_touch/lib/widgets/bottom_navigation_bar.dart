import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucky_touch/beanResponse/login_model.dart';

import 'package:lucky_touch/providers/model_bottom_navigation_bar.dart';
import 'package:lucky_touch/screens/bottom_navigation_screens/admin_chat_list_screen.dart';
import 'package:lucky_touch/screens/bottom_navigation_screens/chat_screen.dart';
import 'package:lucky_touch/screens/bottom_navigation_screens/lottery_screen.dart';

import 'package:lucky_touch/screens/bottom_navigation_screens/menu_screen.dart';
import 'package:lucky_touch/screens/bottom_navigation_screens/my_tickets_screen.dart';
import 'package:lucky_touch/screens/bottom_navigation_screens/winners_screen.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({Key? key}) : super(key: key);

  // int index = 2;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [
    MyTickets(),
    Winners(),
    LotteryScreen(),
    usr?.isAdmin == 1
        ? AdminChatListScreen()
        : ChatScreen(
            usersId: usr?.id ?? 0,
          ),
    Menu()
  ];
  final items = <Widget>[
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FaIcon(
        FontAwesomeIcons.solidBookmark,
        size: 25,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FaIcon(
        FontAwesomeIcons.trophy,
        size: 25,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FaIcon(
        Icons.money,
        size: 25,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FaIcon(
        FontAwesomeIcons.solidComments,
        size: 25,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: FaIcon(
        FontAwesomeIcons.bars,
        size: 25,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // image: DecorationImage(
          //     colorFilter: new ColorFilter.mode(
          //         Colors.black.withOpacity(0.2), BlendMode.dstATop),
          //     fit: BoxFit.cover,
          //     image: AssetImage('assets/images/inside_wallaper.jpg'))
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
          //   // colors: [Colors.blue, Colors.blueAccent, Colors.cyanAccent],
          // ),
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: screens[context.watch<ModelBottomNavigationBar>().index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bottom_wallaper.jpg'))
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
                //   // colors: [Colors.blue, Colors.blueAccent, Colors.cyanAccent],
                // ),
                ),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: Colors.amberAccent.withOpacity(0.5),
              height: 60,
              items: items,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 300),
              index: context.watch<ModelBottomNavigationBar>().index,
              backgroundColor: Colors.transparent,
              onTap: (index) {
                // Provider.of<ModelBottomNavigationBar>(context,listen: false).changeIndex(index);
                context.read<ModelBottomNavigationBar>().changeIndex(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
