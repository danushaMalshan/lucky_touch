
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:lucky_touch/beanResponse/api_key_model.dart';

import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/app_bar.dart';


class UpdateKeyScreen extends StatefulWidget {
  const UpdateKeyScreen({Key? key}) : super(key: key);

  @override
  State<UpdateKeyScreen> createState() => _UpdateKeyScreenState();
}

class _UpdateKeyScreenState extends State<UpdateKeyScreen> {
  TextEditingController apiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ApiKeyModel? _apiModel;

  _updateKey(String key) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateApiKey(key);
    if (res == null) return;
  }

  getApiKey() async {

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getApiKey();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _apiModel = ApiKeyModel.fromJson(parsed);

    apiController.text = _apiModel?.apiKey ?? '';

    return _apiModel;
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
        //     gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
        // )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar('Change Key'),
          body: FutureBuilder(
              future: getApiKey(),
              builder: ((context, snapshot) {
                if (snapshot.data != null) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                                hint: 'Api Key',
                                controller: apiController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Notification cannot be empty';
                                  } else {
                                    return null;
                                  }
                                }),

                            AddButton(context),
                            // imageButtons(context),
                            // showImage ? imageList() : Container(),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return SpinKitWave(
                    color: Colors.amberAccent,
                    size: 80,
                  );
                }
              })),
        ));
  }

  Widget AddButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try {
            await _updateKey(apiController.text);
            apiController.clear();
            getApiKey();
            setState(() {
              
            });
            
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                margin: EdgeInsets.only(bottom: 20),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.amber.withOpacity(0.3),
                content: Text(
                  'Api key updated',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )));
          } catch (e) {
            Servicewrapper wrapper = Servicewrapper();
            wrapper.showErrorMsg(e.toString());
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
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
            'Change Key',
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
          var validator}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            cursorColor: Colors.white,
            controller: controller,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red, fontSize: 15),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18, horizontal: 30),
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

  Widget UserDetailsPopUp(
      {required String firstName,
      required String lastName,
      required String country,
      required String usdtAddress,
      required String email,
      required String boughtTicket,
      required DateTime lastOnline,
      required DateTime registerDate}) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.white),
        height: 600,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Align(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  '$firstName $lastName',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DetailRow('First Name', firstName),
                  DetailRow('Last Name', lastName),
                  DetailRow('Country', country),
                  DetailRow('USDT Address', usdtAddress),
                  DetailRow('Email', email),
                  DetailRow('Bought Tickets', boughtTicket),
                  DetailRow('Last online',
                      '${lastOnline.year}-${lastOnline.month}-${lastOnline.day}  ${lastOnline.hour}:${lastOnline.minute}'),
                  DetailRow('Register Date',
                      '${registerDate.year}-${registerDate.month}-${registerDate.day}  ${registerDate.hour}:${registerDate.minute}'),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, bottom: 0),
              child: InkWell(
                onTap: () {
                  // context.read<ModelGoldenTicketScreen>().getTickets();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                      color: Colors.cyan.shade400),
                  child: Center(
                      child: Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding DetailRow(String detailName, String detail) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              detailName,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              ':',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              detail,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomTile(
      BuildContext context, String title, dynamic onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width - 50,
        height: 60,
        decoration: BoxDecoration(
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
