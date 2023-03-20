import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lucky_touch/beanResponse/login_model.dart';
import 'package:lucky_touch/beanResponse/user_details_model.dart';
import 'package:lucky_touch/providers/model_bottom_navigation_bar.dart';

import 'package:lucky_touch/screens/admin_panel/admin_panel_screen.dart';
import 'package:lucky_touch/screens/auth_screens/signin_screen.dart';
import 'package:lucky_touch/screens/auth_screens/update_user_details_screen.dart';

import 'package:lucky_touch/util/local_base.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

import 'package:lucky_touch/widgets/app_bar_without_back_button.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);
  bool logOutDone = false;
  bool dataLoading = false;
  bool progress = true;
  UserDetailsModel? model;
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  TextEditingController passwordController = TextEditingController();
  _logOut(email, password) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.logOut(email, password);
    if (res == null) return;

    widget.logOutDone = true;
  }

  _userDetails() async {
    widget.dataLoading = true;
    setState(() {
      widget.progress = true;
    });

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.userDetails();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    widget.model = UserDetailsModel.fromJson(parsed);
    widget.dataLoading = false;
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    print('photooo' + '${randomNumber}');
    setState(() {
      widget.progress = false;
    });
  }

  @override
  void initState() {

    super.initState();
    _userDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.progress && !widget.dataLoading) _userDetails();
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
        appBar: CustomAppBarWithoutBackButton('menu'),
        // AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       size: 30,
        //     ),
        //     onPressed: () {},
        //   ),
        // ),
        body: widget.progress
            ? SpinKitWave(
                color: Colors.amberAccent,
                size: 80,
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${widget.model?.profilePic ?? 'http://luckytouch.win/images/app_avatar/default/user.jpg'}'),
                            backgroundColor: Colors.black.withOpacity(0.1),
                            radius: 70,
                            // backgroundImage: NetworkImage(
                            //     'https://smart-edu.ir/wp-content/uploads/2021/05/avatar.jpg.320x320px.jpg'),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 4, color: Colors.white)),
                          height: 140,
                          width: 140,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.model?.firstName ?? ''}',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        usr?.isAdmin == 1
                            ? CustomTile(context, 'Admin Panel', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminPanel(),
                                  ),
                                );
                              }, Icons.person)
                            : Container(),
                        CustomTile(context, 'Edit Profile', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateUserDetailsScreen(
                                        model: widget.model,
                                      )));
                        }, Icons.person_add),
                        CustomTile(context, 'My Tickets', () {
                          context
                              .read<ModelBottomNavigationBar>()
                              .changeIndex(0);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CustomBottomNavigationBar()));
                        }, Icons.bookmark),
                        CustomTile(context, 'Winners', () {
                          context
                              .read<ModelBottomNavigationBar>()
                              .changeIndex(1);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CustomBottomNavigationBar()));
                        }, Icons.face),
                        CustomTile(context, 'Contact Us', () {
                          context
                              .read<ModelBottomNavigationBar>()
                              .changeIndex(3);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CustomBottomNavigationBar()));
                        }, Icons.chat_bubble),
                        CustomTile(context, 'Log Out', () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 5,
                                          color: Colors.amber,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 300,
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Text(
                                              'Do you want to sign out?',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20, top: 30),
                                            child: CustomTextField(
                                                hint: 'Password',
                                                controller: passwordController),
                                          ),
                                          SignOutButton(context)
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              });
                        }, Icons.door_back_door_outlined),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget CustomTextField(
          {required String hint, required TextEditingController controller}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          cursorColor: Colors.amber,
          obscureText: true,
          controller: controller,
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide:
                  BorderSide(color: Colors.amber.withOpacity(0.6), width: 2),
            ),
            fillColor: Colors.amber.withOpacity(0.2),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide(color: Colors.amber, width: 2),
            ),
            filled: true,
            // border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              setState(() {});
              return '';
            } else {
              setState(() {});
              return null;
            }
          },
        ),
      );

  Widget SignOutButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await _logOut(widget.model?.email ?? '', passwordController.text);
          if (widget.logOutDone) {
            await LocalRepo().deleteToken();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          } else {
            passwordController.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar()),
            );
            throw Exception('Logout failed');
          }
        } on Exception catch (e) {}
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        height: 65,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 5),
          color: Colors.red,
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Colors.black, Colors.amber, Colors.black],
          // ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'Sign Out',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
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
            color: Colors.black.withOpacity(0.4)),
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
