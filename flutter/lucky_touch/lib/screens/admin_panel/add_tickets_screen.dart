import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucky_touch/beanResponse/get_last_round_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/app_bar.dart';
import 'package:lucky_touch/widgets/bottom_navigation_bar.dart';
import 'package:lucky_touch/widgets/custom_ticket.dart';

class AddTickets extends StatefulWidget {
  const AddTickets({Key? key}) : super(key: key);

  @override
  State<AddTickets> createState() => _AddTicketsState();
}

class _AddTicketsState extends State<AddTickets> {
  int price = 5;
  Color color = Colors.amberAccent;
  String number = '0000000045';
  final List<String> items = ['Golden', 'Silver', 'Platinum'];
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  String selectedValue = 'Golden';
  final List<File> pics = [];
  bool showImage = false;
  bool progress = false;
  DateTime? dateTime;
  GetLastRound? model;

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
      roundController.text = (model?.roundNo ?? 0).toString();
    });
  }

  Future pickIamges() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      pics.add(imageTemporary);
      setState(() {
        showImage = true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  _sendNotification(String msg) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.SendNotification(msg);
    if (res == null) return;
  }

  _addTickets(BuildContext context, String ticketType) async {
    String datetime = DateTime.now().toUtc().toString();
    print(datetime);
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.addTickets(
        ticketType,
        roundController.text,
        titleController.text,
        priceController.text,
        datetime,
        DateFormat('yyyy-MM-dd HH:mm').format(dateTime!.toUtc()),
        quantityController.text);
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
        appBar: CustomAppBar('Add Tickets'),
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
                        CustomTicket(
                          roundNo: model?.roundNo ?? 0,
                          price: price,
                          color: color,
                          number: number,
                          date: '2000-00-00',
                        ),
                        dropdownButton(context),
                        CustomRoundTextField(
                            hint: 'Round',
                            controller: roundController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Ticket Round';
                              } else {
                                return null;
                              }
                            }),
                        CustomTextField(
                            hint: 'Title',
                            controller: titleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Ticket Title';
                              } else {
                                return null;
                              }
                            }),
                        CustomTextField(
                            hint: 'Price',
                            controller: priceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Ticket Price';
                              } else {
                                return null;
                              }
                            }),
                        DateTimeTextField(context),
                        CustomTextField(
                            hint: 'Quantity',
                            controller: quantityController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Ticket Quantity';
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
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.file(
                    pics[index],
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
          );
        });
  }

  Widget imageButtons(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickIamges();
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
              Colors.pinkAccent.withOpacity(0.4),
              Colors.deepPurpleAccent.withOpacity(0.4),
              Colors.red.withOpacity(0.4)
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

  Widget AddButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try {
            setState(() {
              progress = true;
            });

            int type = items.indexOf(selectedValue);
            print(type);
            await _addTickets(context, type.toString());
            if (type == 0) {
              _sendNotification(
                  'New golden tickets added. Buy tickets and try your luck');
            } else if (type == 1) {
              _sendNotification(
                  'New silver tickets added. Buy tickets and try your luck');
            } else if (type == 2) {
              _sendNotification(
                  'New platinum tickets added. Buy tickets and try your luck');
            }
            titleController.clear();
            priceController.clear();
            dateController.clear();
            quantityController.clear();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                margin: EdgeInsets.only(bottom: 20),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.amber.withOpacity(0.3),
                content: Text(
                  'Tickets Added',
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
            'Add Tickets',
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
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
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

  Widget dropdownButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: [
                Expanded(
                  child: Text(
                    'Tickets Type',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
                if (value == 'Golden') {
                  color = Colors.amberAccent;
                } else if (value == 'Silver') {
                  color = Colors.grey;
                } else if (value == 'Platinum') {
                  color = Colors.blue;
                }
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.white,
            ),
            iconSize: 25,
            iconEnabledColor: Colors.grey,
            iconDisabledColor: Colors.grey,
            buttonHeight: 65,
            buttonWidth: double.infinity,
            buttonPadding: const EdgeInsets.only(left: 23, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border:
                  Border.all(color: Colors.white.withOpacity(0.6), width: 2),
              color: Colors.transparent,
            ),
            buttonElevation: 0,
            itemHeight: 50,
            itemPadding: const EdgeInsets.only(left: 23, right: 8),
            // dropdownMaxHeight: 200,
            // dropdownWidth: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pinkAccent,
                  Colors.deepPurpleAccent,
                  Colors.red
                ],
              ),
              border:
                  Border.all(color: Colors.white.withOpacity(0.6), width: 2),
            ),
            dropdownElevation: 0,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(0, 0),
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
