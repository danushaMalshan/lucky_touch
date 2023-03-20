import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';

import 'package:lucky_touch/beanResponse/user_details_model.dart';


import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/app_bar.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class UpdateUserDetailsScreen extends StatefulWidget {
  UpdateUserDetailsScreen({Key? key, this.model}) : super(key: key);
  UserDetailsModel? model;
  @override
  State<UpdateUserDetailsScreen> createState() =>
      _UpdateUserDetailsScreenState();
}

class _UpdateUserDetailsScreenState extends State<UpdateUserDetailsScreen> {
  bool loginDone = false;

  bool updateSuccess = false;
  bool progress = false;

  late String imagePath;

  File? imagePermanent2;

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController usdtController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  File? _image;
  XFile? checkImage;
  Future pickIamge(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 480, maxWidth: 480);
      if (image == null) return;
      checkImage = image;
      imagePath = image.path;
      final imagePermanent = await saveImagePermanently(imagePath);
      _image = imagePermanent;
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadImage(BuildContext context) async {
    setState(() {
      progress = true;
    });
    final imagePermanent = await saveImagePermanently(imagePath);
    imagePermanent2 = imagePermanent;
    Servicewrapper wrapper = new Servicewrapper();
    await wrapper.uploadFile(imagePermanent, '/app_avatar');
    _image = imagePermanent;
    setState(() {
      progress = false;
    });
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    Random random = new Random();
    int randomNumber = random.nextInt(100000000);
    final image = File(
        '${directory.path}/avatar_${firstNameController.text}_$randomNumber.${name.split(".").last}');
    print('imagee' + image.toString());

    return File(imagePath).copy(image.path);
  }

  _updateUserDetails(BuildContext context) async {
    //if (!widget.isLoading) return;
    print("SignUp1");
    setState(() {
      progress = true;
    });
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateUserDetails(
        firstNameController.text,
        lastNameController.text,
        checkImage != null
            ? basename(imagePermanent2?.path ?? '')
            : '${widget.model?.profilePic ?? ''}',
        countryController.text,
        usdtController.text,
        emailController.text,
        checkImage != null ? 1 : 0);

    if (res == null) return;
    setState(() {
      progress = false;
    });
    updateSuccess = true;
  }

  @override
  void initState() {
 
    super.initState();
    firstNameController.text = widget.model?.firstName ?? '';
    lastNameController.text = widget.model?.lastName ?? '';
    countryController.text = widget.model?.country ?? '';
    usdtController.text = widget.model?.usdtAddress ?? '';
    emailController.text = widget.model?.email ?? '';
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
      child: Scaffold(
        appBar: CustomAppBar('Edit Profile'),
        backgroundColor: Colors.transparent,
        body: progress
            ? SpinKitWave(
                color: Colors.amberAccent,
                size: 80,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 60),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                      backgroundColor:
                                          Colors.black.withOpacity(0.1),
                                      radius: 65,
                                      child: (_image != null)
                                          ? ClipOval(
                                              child: Image.file(
                                                _image!,
                                                fit: BoxFit.cover,
                                                height: 140,
                                                width: 140,
                                              ),
                                            )
                                          : ClipOval(
                                              child: Image.network(
                                                '${widget.model?.profilePic ?? 'http://luckytouch.win/images/app_avatar/default/user.jpg'}',
                                                fit: BoxFit.cover,
                                                height: 140,
                                                width: 140,
                                              ),
                                            )),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.pinkAccent.withOpacity(0.8),
                                            Colors.deepPurpleAccent
                                                .withOpacity(0.8),
                                            Colors.red.withOpacity(0.8)
                                          ])),
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
                          SubmitButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget SubmitButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try {
            if (checkImage != null) {
              await uploadImage(context);
            }
            await _updateUserDetails(context);

            if (updateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  margin: EdgeInsets.only(bottom: 20),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.amber.withOpacity(0.3),
                  content: Text(
                    'Update Successfully',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )));

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomBottomNavigationBar()));

              setState(() {});
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  margin: EdgeInsets.only(bottom: 20),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text('Update failed ')));
              setState(() {});
            }
          } catch (e) {}
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
            'Update',
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
