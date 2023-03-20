import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:lucky_touch/beanResponse/login_model.dart';
import 'package:lucky_touch/screens/auth_screens/signin_screen.dart';

import 'package:lucky_touch/util/local_base.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool needToLogin = true;

  dynamic token;

  _checkUserLogged() async {
    try {
      token = await LocalRepo().getToken();
      if (token == null || token == '') {
        needToLogin = true;
      } else {
        usr = LoginModel(accessToken: token);
        Servicewrapper wrapper = new Servicewrapper();
        var res = await wrapper.userDetails();
        if (res == null) {
          needToLogin = true;
        } else {
          final Map<String, dynamic> parsed = res;
          usr?.id = parsed['users_id'];
          usr?.email = parsed['email'];
          usr?.firstName = parsed['first_name'];
          usr?.lastName = parsed['last_name'];
          usr?.profilePic = parsed['profile_pic'];
          usr?.isAdmin = parsed['is_admin'];
          _updateLastOnline(token);
        }

        if (usr?.id == null) {
          needToLogin = true;
        } else {
          needToLogin = false;
        }
      }
    } on Exception catch (e) {}
  }

  

  _updateLastOnline(token) async {
    String datetime = DateTime.now().toString();
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateLastOnline(datetime, token);
    if (res == null) return;
  }

  @override
  void initState() {
  
    super.initState();
    _checkUserLogged();

    Future.delayed(Duration(seconds: 5)).then((value) => {
          if (needToLogin)
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              ),
            }
          else
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(),
                ),
              ),
            }
        });
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
              image: AssetImage('assets/images/wallpaper.jpg'))
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
          // ),
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 600,
                width: 600,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icons/icon.png'))),
              ),
              SpinKitThreeBounce(
                color: Colors.amberAccent,
                size: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
