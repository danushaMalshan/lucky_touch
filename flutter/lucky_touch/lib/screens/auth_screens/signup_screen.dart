
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lucky_touch/beanResponse/login_model.dart';

import 'package:lucky_touch/providers/model_signup.dart';
import 'package:lucky_touch/screens/auth_screens/signin_screen.dart';
import 'package:lucky_touch/util/local_base.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  bool loginDone = false;
  bool registerSuccess = false;
  late String imagePath;
  File? imagePermanent2;
  XFile? checkImage;
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController usdtController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future pickIamge(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 480, maxWidth: 480);

      if (image == null) return;
      checkImage = image;
      imagePath = image.path;
      final imagePermanent = await saveImagePermanently(imagePath);
      context.read<ModelSignUp>().changeImage(imagePermanent);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadImage(BuildContext context) async {
    try {
      context.read<ModelSignUp>().changeProgressState(true);
      final imagePermanent = await saveImagePermanently(imagePath);
      imagePermanent2 = imagePermanent;
      Servicewrapper wrapper = new Servicewrapper();
      await wrapper.uploadFile(imagePermanent, '/app_avatar');
      context.read<ModelSignUp>().changeImage(imagePermanent);
    } catch (e) {
      Servicewrapper wrapper = new Servicewrapper();
      wrapper.showErrorMsg(e.toString());
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);

    final image = File(
        '${directory.path}/avatar_${firstNameController.text}.${name.split(".").last}');
    print('imagee' + image.toString());

    return File(imagePath).copy(image.path);
  }

  _logIn(BuildContext context) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res =
        await wrapper.logIn(emailController.text, passwordController.text);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    usr = LoginModel.fromJson(parsed);
    LocalRepo().setToken(usr?.accessToken ?? '');
    loginDone = true;
    print("SignUp2");
    context.read<ModelSignUp>().changeProgressState(false);
  }

  _signUp(BuildContext context) async {
    //if (!widget.isLoading) return;
    print("SignUp1");
    context.read<ModelSignUp>().changeProgressState(true);
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.signUp(
        firstNameController.text,
        lastNameController.text,
        basename(imagePermanent2?.path ?? ''),
        countryController.text,
        usdtController.text,
        emailController.text,
        passwordController.text);
    context.read<ModelSignUp>().changeProgressState(false);
    if (res == null) return;

    registerSuccess = true;
    await _logIn(context);
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
          body: context.watch<ModelSignUp>().progress
              ? Center(
                  child: SpinKitWave(
                  color: Colors.amberAccent,
                  size: 80,
                ))
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 5, color: Colors.white),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 65,
                                      child:
                                          (context.watch<ModelSignUp>().image !=
                                                  null)
                                              ? ClipOval(
                                                  child: Image.file(
                                                    height: 140,
                                                    width: 140,
                                                    context
                                                        .watch<ModelSignUp>()
                                                        .image!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.person_outline_sharp,
                                                  size: 70,
                                                  color: Colors.white,
                                                ),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent
                                        // gradient: LinearGradient(
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight,
                                        //     colors: [
                                        //       Colors.pinkAccent.withOpacity(0.3),
                                        //       Colors.deepPurpleAccent
                                        //           .withOpacity(0.3),
                                        //       Colors.red.withOpacity(0.3)
                                        //     ]),
                                        ),
                                    height: 130,
                                    width: 130,
                                  ),
                                  Positioned(
                                      bottom: 6,
                                      right: -12,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await pickIamge(context);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            CustomTextField(
                                hint: 'First Name',
                                controller: firstNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your first name";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: false),
                            CustomTextField(
                                hint: 'Last Name',
                                controller: lastNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your last name";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: false),
                            CustomTextField(
                                hint: 'Country',
                                controller: countryController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your country";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: false),
                            CustomTextField(
                                hint: 'USDT Address',
                                controller: usdtController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your usdt address";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: false),
                            CustomTextField(
                                hint: 'Email Address',
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return "Enter your valid email";
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
                                    return "Enter your password";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: true),
                            SubmitButton(context),
                            LoginText(context)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget LoginText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: 'Login',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ]),
        ),
      ),
    );
  }

  Widget SubmitButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try {
            print(checkImage);
            if (checkImage != null) {
              await uploadImage(context);
            }
            await _signUp(context);

            if (registerSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  margin: EdgeInsets.only(bottom: 20),
                  backgroundColor: Colors.amber,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Register Successfully')));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomBottomNavigationBar()));
            } else if (loginDone) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  margin: EdgeInsets.only(bottom: 20),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.amber,
                  content: Text(
                      'Your Registration Successfully. You Can Login Now!')));
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  margin: EdgeInsets.only(bottom: 20),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Registration failed ')));
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
          border: Border.all(color: Colors.white, width: 5),
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
            'Sign Up',
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
