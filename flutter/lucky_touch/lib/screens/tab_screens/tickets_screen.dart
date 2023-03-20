import 'package:flutter/material.dart';

import 'package:lucky_touch/screens/tab_screens/golden_tickets_screen.dart';
import 'package:lucky_touch/screens/tab_screens/platinum_tickets_screen.dart';
import 'package:lucky_touch/screens/tab_screens/silver_tickets_screen.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
   
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
 
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black,
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage('assets/images/inside_wallaper.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            bottom: TabBar(
              controller: controller,
              indicatorWeight: 2,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(0),
              tabs: [
                Tab(
                  child: Text(
                    'Golden',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Silver',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Platinum',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            GoldenTicketsScreen(),
            SilverTicketsScreen(),
            PlatinumTicketsScreen()
          ],
        ),
      ),
    );
  }
}
