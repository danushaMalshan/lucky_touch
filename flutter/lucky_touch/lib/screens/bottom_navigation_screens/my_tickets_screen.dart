import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucky_touch/beanResponse/show_payment_model.dart';
import 'package:lucky_touch/beanResponse/user_tickets_model.dart';

import 'package:lucky_touch/webservice/servicewrapper.dart';

import 'package:lucky_touch/widgets/app_bar_without_back_button.dart';
import 'package:lucky_touch/widgets/custom_ticket.dart';
import 'package:lucky_touch/widgets/custom_ticket_with_status.dart';


class MyTickets extends StatefulWidget {
  const MyTickets({Key? key}) : super(key: key);

  @override
  State<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  // var timeline=new Map();
  // List<String> timeline = [];
  UserTicketModel? model;
  ShowPaymentModel? showPaymentModel;
  bool progress = false;
  bool dataLoading = false;

  // List<String> timeline = ['Complete','NEW','EXPIRED'];

  @override
  void initState() {
    super.initState();
  }

// List<>
  _getTickets() async {
    dataLoading = true;

    progress = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getUserTickets();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    model = UserTicketModel.fromJson(parsed);

    for (var i = 0; i < (model?.data?.length ?? 0); i++) {
      await _showPayment(model?.data?[i]?.paymentId ?? '');
      await _updateRank(model?.data?[i]?.buyerId ?? 0,
          showPaymentModel?.data?.timeline?.last?.status ?? '');
    }
    var res2 = await wrapper.getUserTickets();
    if (res == null) return;
    final Map<String, dynamic> parsed2 = res2;
    model = UserTicketModel.fromJson(parsed2);
    dataLoading = false;
    progress = false;
    return model;
  }

  _showPayment(String paymentId) async {
    dataLoading = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.showAPayment(paymentId);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    showPaymentModel = ShowPaymentModel.fromJson(parsed);
    dataLoading = false;
  }

  _updateRank(int buyerId, String timeline) async {
    String datetime = DateTime.now().toUtc().toString();
    print(datetime);
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateTimeline(buyerId, timeline);
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
      child: Scaffold(
        appBar: CustomAppBarWithoutBackButton('My Tickets'),
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 0),
            child: FutureBuilder(
              future: _getTickets(),
              builder: (context, snapshot) {
                if (snapshot.data != null && model?.data?.length != 0) {
                  return ListView.builder(
                      itemCount: model?.data?.length,
                      itemBuilder: (context, index) {
                        var item = model?.data;

                        if (item?[index]?.timeline == 'COMPLETED') {
                          if (item?[index]?.ticket?.ticketType == 0 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicket(
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.amberAccent,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                            );
                          } else if (item?[index]?.ticket?.ticketType == 1 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicket(
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.grey,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                            );
                          } else if (item?[index]?.ticket?.ticketType == 2 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicket(
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.blue,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                            );
                          } else {
                            return Container();
                          }
                        } else if (item?[index]?.timeline == 'NEW' ||
                            item?[index]?.timeline == 'PENDING') {
                          if (item?[index]?.ticket?.ticketType == 0 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicketWithStatus(
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.amberAccent,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                              status: 'PENDING',
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                            );
                          } else if (item?[index]?.ticket?.ticketType == 1 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicketWithStatus(
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.grey,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                              status: 'PENDING',
                            );
                          } else if (item?[index]?.ticket?.ticketType == 2 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicketWithStatus(
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.blue,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                              status: 'PENDING',
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          if (item?[index]?.ticket?.ticketType == 0 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicketWithStatus(
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.amberAccent,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                              status: item?[index]?.timeline ?? 'WAITING',
                            );
                          } else if (item?[index]?.ticket?.ticketType == 1 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicketWithStatus(
                              roundNo: item?[index]?.ticket?.roundNo ?? 0,
                              number: (item?[index]?.ticket?.ticketNumber ?? 0)
                                  .toString()
                                  .padLeft(10, '0'),
                              color: Colors.grey,
                              price: item?[index]?.ticket?.price ?? 0,
                              date: item?[index]?.ticket?.expireDate ??
                                  '2000-00-00 00:00:00',
                              status: item?[index]?.timeline ?? 'WAITING',
                            );
                          } else if (item?[index]?.ticket?.ticketType == 2 &&
                              item?[index]?.ticket?.ticketType != null) {
                            return CustomTicketWithStatus(
                                roundNo: item?[index]?.ticket?.roundNo ?? 0,
                                number:
                                    (item?[index]?.ticket?.ticketNumber ?? 0)
                                        .toString()
                                        .padLeft(10, '0'),
                                color: Colors.blue,
                                price: item?[index]?.ticket?.price ?? 0,
                                date: item?[index]?.ticket?.expireDate ??
                                    '2000-00-00 00:00:00',
                                status: item?[index]?.timeline ?? 'WAITING');
                          } else {
                            return Container();
                          }
                        }
                      });
                } else if (model?.data?.length == 0) {
                  return Center(
                    child: Text(
                      'My ticket list is empty',
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
}
