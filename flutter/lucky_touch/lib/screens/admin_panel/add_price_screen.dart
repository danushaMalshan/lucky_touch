
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lucky_touch/beanResponse/get_last_round_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/app_bar.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';


class AddPrice extends StatefulWidget {
  const AddPrice({Key? key}) : super(key: key);

  @override
  State<AddPrice> createState() => _AddPriceState();
}

class _AddPriceState extends State<AddPrice> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GetLastRound? model;
  final _formKey = GlobalKey<FormState>();
  DateTime? dateTime;
  bool progress = false;
  @override
  void initState() {

    super.initState();
    _getRounds();
  }

  _getRounds() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getLastRound();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    model = GetLastRound.fromJson(parsed);

    setState(() {
      roundController.text = ((model?.roundNo ?? 0) + 1).toString();
    });
  }

  _addPrice() async {
    String datetime = DateTime.now().toUtc().toString();
    print(datetime);
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.addRound(
      roundController.text,
      priceController.text,
      datetime,
      DateFormat('yyyy-MM-dd HH:mm').format(dateTime!.toUtc()),
    );
    if (res == null) return;
  }

  _sendNotification() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.SendNotification(
        'Round ${roundController.text} Start. Join this round and be a winner');
    if (res == null) return;
  }


  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(dateTime!);
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: dateTime != null
            ? TimeOfDay(hour: dateTime!.hour, minute: dateTime!.minute)
            : initialTime);
    if (newTime == null) return null;

    return newTime;
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
        appBar: CustomAppBar('Add Price'),
        body: progress
            ? SpinKitWave(
                color: Colors.amberAccent,
                size: 80,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomRoundTextField(
                            hint: 'Round',
                            controller: roundController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Round Number";
                              } else {
                                return null;
                              }
                            }),
                        CustomTextField(
                            hint: 'Price',
                            controller: priceController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter correct price";
                              } else {
                                return null;
                              }
                            }),
                        DateTimeTextField(context),

                        AddButton(context),
                        // imageButtons(context),
                        // showImage ? imageList() : Container(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget AddButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try {
            setState(() {
              progress = true;
            });
            await _addPrice();
            await _sendNotification();
            priceController.clear();
            dateController.clear();
            roundController.clear();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                margin: EdgeInsets.only(bottom: 20),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.amber.withOpacity(0.3),
                content: Text(
                  'Price Added',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )));
            setState(() {
              progress = false;
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomBottomNavigationBar()));
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
            'Add Price',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding DateTimeTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        cursorColor: Colors.white,
        readOnly: true,
        controller: dateController,
        style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red, fontSize: 15),
          suffixIcon: GestureDetector(
            onTap: () {
              pickDateTime(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: Icon(
                Icons.calendar_month_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
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
          hintText: 'Expire Date',
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {});
            return 'Select Expire Date';
          } else {
            setState(() {});
            return null;
          }
        },
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
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
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

  Widget CustomRoundTextField(
          {required String hint,
          required TextEditingController controller,
          var validator}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            cursorColor: Colors.white,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
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
              prefix: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'Round',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
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

              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            validator: validator),
      );
}
