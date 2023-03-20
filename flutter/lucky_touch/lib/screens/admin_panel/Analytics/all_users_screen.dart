
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:lucky_touch/beanResponse/all_users_model.dart';
import 'package:lucky_touch/providers/model_all_users.dart';

import 'package:lucky_touch/webservice/servicewrapper.dart';

import 'package:provider/provider.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  TextEditingController searchController = TextEditingController();
  AllUsersModel? model;
  String query = '';
  _getAllUsers(String query) async {
    print('step 1');
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getAllUsers(query);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    model = AllUsersModel.fromJson(parsed);

    return model;
  }

  _removeUser(int id) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.deleteUser(id);
    if (res == null) return;
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.amber.withOpacity(0.2),
            centerTitle: true,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Text(
                    'All Users',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.white),
                  ),
                  Text(
                    '${context.watch<ModelAllUsers>().model?.data?.length ?? ''}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width - 70,
                        child: CustomTextField(
                            hint: '', controller: searchController)),
                  )
                ],
              ),
            ),
            // title:
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FutureBuilder(
              future: _getAllUsers(query),
              builder: (context, snapshot) {
                if (snapshot.data != null && model!.data!.length > 0) {
                  return ListView.builder(
                      itemCount: model?.data?.length,
                      itemBuilder: (context, index) {
                        var item = model?.data?[index];
                        return Container(
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.4),
                          ),
                          height: 90,
                          width: MediaQuery.of(context).size.width - 40,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundImage:
                                        AssetImage('assets/images/user.jpg'),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                    '${item?.firstName ?? ''} ${item?.lastName ?? ''}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return UserDetailsPopUp(
                                                firstName:
                                                    item?.firstName ?? '',
                                                lastName: item?.lastName ?? '',
                                                country: item?.country ?? '',
                                                usdtAddress:
                                                    item?.usdtAddress ?? '',
                                                email: item?.email ?? '',
                                                boughtTicket:
                                                    (item?.ticketCount ?? '')
                                                        .toString(),
                                                lastOnline: DateTime.parse(
                                                        item?.lastOnline ??
                                                            '2000-00-00')
                                                    .toLocal(),
                                                registerDate: DateTime.parse(
                                                        item?.createdAt ??
                                                            '2000-00-00')
                                                    .toLocal());
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber.withOpacity(0.4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'More',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return UserRemovePopUp(
                                                userId: item?.usersId ?? 0,
                                                firstName:
                                                    item?.firstName ?? '',
                                                lastName: item?.lastName ?? '',
                                                country: item?.country ?? '',
                                                usdtAddress:
                                                    item?.usdtAddress ?? '',
                                                email: item?.email ?? '',
                                                boughtTicket:
                                                    (item?.ticketCount ?? '')
                                                        .toString(),
                                                lastOnline: DateTime.parse(
                                                        item?.lastOnline ??
                                                            '2000-00-00')
                                                    .toLocal(),
                                                registerDate: DateTime.parse(
                                                        item?.createdAt ??
                                                            '2000-00-00')
                                                    .toLocal());
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red.withOpacity(0.4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Remove',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                } else if (model?.data?.length == 0) {
                  return Center(
                    child: Text(
                      'Cannot find user',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  );
                } else {
                  return SpinKitWave(
                    color: Colors.amberAccent,
                    size: 80,
                  );
                  
                }
              },
            )),
      ),
    );
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                '$firstName $lastName',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
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

  Widget UserRemovePopUp(
      {required int userId,
      required String firstName,
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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                '$firstName $lastName',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
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
            Text(
              'Are you sure to ban this user?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, bottom: 0),
              child: InkWell(
                onTap: () async {
                  // context.read<ModelGoldenTicketScreen>().getTickets();
                  await _removeUser(userId);
                  await _getAllUsers(query);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                      color: Colors.red),
                  child: Center(
                      child: Text(
                    'Remove',
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

  Widget CustomTextField(
          {required String hint,
          required TextEditingController controller,
          var validator}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            onChanged: (value) {
              print(value);

              setState(() {
                query = value;
              });
            },
            cursorColor: Colors.white,
            controller: controller,
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
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
