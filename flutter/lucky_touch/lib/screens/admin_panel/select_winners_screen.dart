import 'package:flutter/material.dart';

import 'package:lucky_touch/beanResponse/get_last_round_model.dart';
import 'package:lucky_touch/screens/admin_panel/all_ticket_buyers.dart';
import 'package:lucky_touch/screens/admin_panel/golden_ticket_buyers.dart';
import 'package:lucky_touch/screens/admin_panel/platinum_ticket_buyers.dart';
import 'package:lucky_touch/screens/admin_panel/silver_ticket_buyers.dart';

import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';

class SelectWinnersScreen extends StatefulWidget {
  const SelectWinnersScreen({Key? key}) : super(key: key);

  @override
  State<SelectWinnersScreen> createState() => _SelectWinnersScreenState();
}

class _SelectWinnersScreenState extends State<SelectWinnersScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  GetLastRound? model;
  @override
  void initState() {

    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
 
    controller.dispose();
    super.dispose();
  }


  _sendNotification(String msg) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.SendNotification(msg);
    if (res == null) return;
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
              image: AssetImage('assets/images/inside_wallaper.jpg'))),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
      //   ),
      // ),
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
                Tab(
                  child: Text(
                    'Custom',
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
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  GoldenTicketBuyers(),
                  SilverTicketBuyers(),
                  PlatinumTicketBuyers(),
                  AllTicketBuyers()
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _sendNotification('Round ${model?.roundNo} winners selected.');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    margin: EdgeInsets.only(bottom: 20),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.amber.withOpacity(0.3),
                    content: Text(
                      'Winners selected',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomBottomNavigationBar()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    border: Border.all(color: Colors.white, width: 2)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
