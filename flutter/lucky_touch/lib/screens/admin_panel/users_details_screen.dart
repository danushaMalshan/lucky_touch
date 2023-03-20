
import 'package:flutter/material.dart';

import 'package:lucky_touch/screens/admin_panel/Analytics/all_users_screen.dart';
import 'package:lucky_touch/screens/admin_panel/Analytics/banned_users.dart';
import 'package:lucky_touch/screens/admin_panel/Analytics/new_users_screen.dart';
import 'package:lucky_touch/screens/admin_panel/Analytics/online_users_screen.dart';
import 'package:lucky_touch/widgets/app_bar.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
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
      //     gradient: LinearGradient(
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
      // )),
      child: Scaffold(
        appBar: CustomAppBar('Users Details'),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                CustomTile(context, 'All Users', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllUsersScreen(),
                    ),
                  );
                }, Icons.people),
                CustomTile(context, 'Online Users', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnlineUsersScreen(),
                    ),
                  );
                }, Icons.online_prediction),
                CustomTile(context, 'New Users', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewUsersScreen(),
                    ),
                  );
                }, Icons.new_label),
                CustomTile(context, 'Banned Users', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BannedUsersScreen(),
                    ),
                  );
                }, Icons.warning),
                // CustomTile(context, 'Ticket Details', () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => NewUsersScreen(),
                //     ),
                //   );
                // }, Icons.info),
              ],
            ),
          )),
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
