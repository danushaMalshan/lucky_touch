
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:intl/intl.dart';
import 'package:lucky_touch/providers/model_admin_chats.dart';
import 'package:lucky_touch/screens/bottom_navigation_screens/admin_chats.dart';

import 'package:lucky_touch/widgets/app_bar_without_back_button.dart';
import 'package:provider/provider.dart';

class AdminChatListScreen extends StatefulWidget {
  const AdminChatListScreen({Key? key}) : super(key: key);

  @override
  State<AdminChatListScreen> createState() => _AdminChatListScreenState();
}

class _AdminChatListScreenState extends State<AdminChatListScreen> {
  String getFormattedDate(DateTime date) {
    var outputFormat = DateFormat('yyyy/MM/dd');
    var outputDate = outputFormat.format(date);
    return outputDate.toString();
  }

  String getFormattedTime(DateTime date) {
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(date);
    return outputDate.toString();
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
              image: AssetImage('assets/images/inside_wallaper.jpg'))
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
          //   // colors: [Colors.blue, Colors.blueAccent, Colors.cyanAccent],
          // ),
          ),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: CustomAppBarWithoutBackButton('Messages'),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FutureBuilder(
              future: context.read<ModelAdminChats>().getChattedUsers(),
              builder: (context, snapshot) {
                if (snapshot.data != null &&
                    context.watch<ModelAdminChats>().model?.data?.length != 0) {
                  return ListView.builder(
                      itemCount: context
                              .watch<ModelAdminChats>()
                              .model
                              ?.data
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var item = context
                            .watch<ModelAdminChats>()
                            .model
                            ?.data?[index];
                        String msgDate = getFormattedDate(
                            DateTime.parse(item?.lastMsgTime ?? '0000-00-00')
                                .toLocal());
                        String msgTime = getFormattedTime(
                            DateTime.parse(item?.lastMsgTime ?? '0000-00-00')
                                .toLocal());
                        //     DateTime.parse(item?.lastMsgTime ?? '0000-00-00')
                        //         .toLocal();
                        // DateTime formattedtime = DateTime.parse(
                        //     DateFormat('yyyy-MM-dd hh:mm a').format(msgTime));
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminChats(
                                          usersId: item?.usersId ?? 0,
                                          userName:
                                              '${item?.firstName ?? ''} ${item?.lastName ?? ''}',
                                        )));

                            print('usersIDD' + '${item?.usersId}');
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            decoration: BoxDecoration(
                              border: item?.msgSeen == 0
                                  ? Border.all(
                                      width: 2, color: Colors.greenAccent)
                                  : Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            height: 90,
                            width: MediaQuery.of(context).size.width - 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
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
                                      height: 58,
                                      width: 58,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 3, color: Colors.white)),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 28,
                                        backgroundImage: NetworkImage(
                                            '${item?.profilePic ?? 'http://luckytouch.win/images/app_avatar/default/user.jpg'}'),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item?.firstName ?? ''} ${item?.lastName ?? ''}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '${item?.lastMsg ?? ''}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '$msgDate     $msgTime',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                item?.msgSeen == 0
                                    ? Container(
                                        width: 50,
                                        height: 30,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Center(
                                          child: Text(
                                            'New',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 50,
                                        height: 30,
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (context
                        .watch<ModelAdminChats>()
                        .model
                        ?.data
                        ?.length ==
                    0) {
                  return Center(
                    child: Text(
                      'No Messages',
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
            ),
          ),
        ),
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
}
