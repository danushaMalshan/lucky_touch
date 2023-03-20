import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lucky_touch/beanResponse/login_model.dart';
import 'package:lucky_touch/providers/model_signin.dart';

import 'package:lucky_touch/screens/auth_screens/reset_password.dart';
import 'package:lucky_touch/screens/auth_screens/signup_screen.dart';
import 'package:lucky_touch/util/local_base.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  bool loginDone = false;
  File? image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _logIn(BuildContext context) async {
    context.read<ModelSignIn>().changeProgressState(true);
    Servicewrapper wrapper = new Servicewrapper();
    var res =
        await wrapper.logIn(emailController.text, passwordController.text);
    context.read<ModelSignIn>().changeProgressState(false);
    if (res == null) return;

    final Map<String, dynamic> parsed = res;
    usr = LoginModel.fromJson(parsed);
    LocalRepo().setToken(usr?.accessToken ?? '');
    loginDone = true;
    print("SignUp2");

    loginDone = true;
  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
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
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: context.watch<ModelSignIn>().progress
              ? SpinKitWave(
                  color: Colors.amberAccent,
                  size: 80,
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: _formKey,
                      child: CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 450,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 250,
                                          width: 250,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/icons/icon.png'))),
                                        ),
                                        Positioned(
                                          left: 210,
                                          bottom: -8,
                                          child: Text(
                                            'Lucky \nTouch',
                                            style: GoogleFonts.satisfy(
                                              textStyle: TextStyle(
                                                  color: Colors.amberAccent,
                                                  fontSize: 74,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                CustomTextField(
                                    hint: 'Email',
                                    controller: emailController,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                        return "Enter correct email";
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: false),
                                CustomTextField(
                                    hint: 'Password',
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter correct password";
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: true),
                                LoginButton(context),
                                ResetPasswordText(context),
                                SignUpText()
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  GestureDetector ResetPasswordText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 4),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Forgot Password?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ]),
        ),
      ),
    );
  }

  InkWell LoginButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          await _logIn(context);

          try {
            if (loginDone) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomBottomNavigationBar()));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                margin: EdgeInsets.only(bottom: 20),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(e.toString())));
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 65,
        width: MediaQuery.of(context).size.width - 120,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          color: Colors.black,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.amber.withOpacity(0.4),
              Colors.black.withOpacity(0.4)
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget CustomTextField(
          {required String hint,
          required TextEditingController controller,
          required var validator,
          required bool obscureText}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            cursorColor: Colors.white,
            obscureText: obscureText,
            controller: controller,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red, fontSize: 15),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18, horizontal: 30),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
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
                    BorderSide(color: Colors.white.withOpacity(0.6), width: 2),
              ),
              fillColor: Colors.black.withOpacity(0.2),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              filled: true,
              // border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            validator: validator),
      );
}

class SignUpText extends StatelessWidget {
  const SignUpText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ]),
        ),
      ),
    );
  }
}
