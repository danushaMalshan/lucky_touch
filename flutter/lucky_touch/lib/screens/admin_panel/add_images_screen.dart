import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddImages extends StatefulWidget {
  const AddImages({Key? key}) : super(key: key);

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  bool showImage = false;
  bool progress = false;
  late String imagePath;
  final List<dynamic> pics = [];
  File? image;
  File? imagePermanent2;
  // Future pickIamges() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     this.image = imageTemporary;
  //     pics.add(imageTemporary);
  //     setState(() {
  //       showImage = true;
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  Future pickIamge(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 480, maxWidth: 480);

      if (image == null) return;

      imagePath = image.path;
      final imagePermanent = await saveImagePermanently(imagePath);
      this.image = imagePermanent;

      List<dynamic> list = [imagePermanent, ''];
      pics.add(list);
      setState(() {
        showImage = true;
      });
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
    for (int i = 0; i < pics.length; i++) {
      await wrapper.uploadFile(pics[i][0], '/banners');

      var res = await wrapper.AddBanners(basename(pics[i][0].path), pics[i][1]);

      if (res == null) return;
    }

    setState(() {
      progress = false;
    });
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    Random random = new Random();
    int randomNumber = random.nextInt(100000000);
    final image =
        File('${directory.path}/banner_$randomNumber.${name.split(".").last}');
    print('imagee' + image.toString());

    return File(imagePath).copy(image.path);
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
      //     // colors: [Colors.blue, Colors.blueAccent, Colors.cyanAccent],
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: progress
            ? SpinKitWave(
                color: Colors.amberAccent,
                size: 80,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      imageButtons(context),
                      showImage ? imageList() : Container(),
                      SubmitButton(context)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  ListView imageList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pics.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Image.file(
                        pics[index][0],
                        width: 100,
                        height: 80,
                        fit: BoxFit.fill,

                        //cancelToken: cancellationToken,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.2),
                      radius: 22,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            pics.removeAt(index);
                          });
                        },
                      ),
                    )
                  ],
                ),
                TextField(
                  onChanged: ((value) {
                    pics[index][1] = value;
                  }),
                  decoration: InputDecoration(hintText: 'Enter lunch url'),
                )
              ],
            ),
          );
        });
  }

  Widget imageButtons(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickIamge(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 20, left: 40, right: 40),
        height: 65,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_outlined,
              size: 34,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Add Banner Images',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget SubmitButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (pics.length != 0) {
          try {
            await uploadImage(context);
            setState(() {
              pics.clear();
            });
          } catch (e) {
            Servicewrapper wrapper = Servicewrapper();
            wrapper.showErrorMsg(e.toString());
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
            'Submit',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
