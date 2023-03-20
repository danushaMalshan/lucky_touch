import 'package:flutter/material.dart';
import 'package:lucky_touch/screens/admin_panel/Analytics/send_notification_screen.dart';
import 'package:lucky_touch/screens/admin_panel/add_images_screen.dart';
import 'package:lucky_touch/screens/admin_panel/add_price_screen.dart';
import 'package:lucky_touch/screens/admin_panel/add_tickets_screen.dart';
import 'package:lucky_touch/screens/admin_panel/select_winners_screen.dart';
import 'package:lucky_touch/screens/admin_panel/update_key_screen.dart';
import 'package:lucky_touch/screens/admin_panel/users_details_screen.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

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
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // Text(
                //   "I'm an Admin",
                //   style: GoogleFonts.pacifico(
                //     textStyle: TextStyle(
                //         color: Colors.white,
                //         fontSize: 40,
                //         fontWeight: FontWeight.w300),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                CustomTile(context, 'Add Banner Images', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddImages(),
                    ),
                  );
                }, Icons.image),
                CustomTile(context, 'Add Price', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPrice(),
                    ),
                  );
                }, Icons.monetization_on),
                CustomTile(context, 'Add Tickets', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTickets(),
                    ),
                  );
                }, Icons.plus_one),
                CustomTile(context, 'Select Winners', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectWinnersScreen(),
                    ),
                  );
                }, Icons.person_add_alt_sharp),
                CustomTile(context, 'Analytics', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(),
                    ),
                  );
                }, Icons.desktop_mac_sharp),
                CustomTile(
                  context,
                  'Send Notification',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendNotificationScreen(),
                      ),
                    );
                  },
                  Icons.notification_add,
                ),
                CustomTile(
                  context,
                  'Change Api Key',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateKeyScreen(),
                      ),
                    );
                  },
                  Icons.key,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomTile(
      BuildContext context, String title, dynamic onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width - 50,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.3)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Icon(
                  Icons.double_arrow_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
