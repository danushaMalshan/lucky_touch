
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lucky_touch/beanResponse/create_payment_model.dart';

import 'package:lucky_touch/providers/model_golden_ticket_screen.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:lucky_touch/widgets/custom_ticket.dart';

import 'package:provider/provider.dart';

import 'package:qr_flutter/qr_flutter.dart';

class GoldenTicketsScreen extends StatefulWidget {
  @override
  State<GoldenTicketsScreen> createState() => _GoldenTicketsScreenState();
}

class _GoldenTicketsScreenState extends State<GoldenTicketsScreen> {
  CreatePaymentModel? createPaymentModel;

  bool createPayment = false;
  bool? paymentAddtoDatabase;
  String apiKey = '';

  String output = 'Output';

  _buyTicket(BuildContext context, int ticketId, String paymentId,
      String walletAddress) async {
    paymentAddtoDatabase = false;
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.buyTicket(ticketId, paymentId, walletAddress);
    if (res == null) return;

    paymentAddtoDatabase = true;
  }

  _updateTicketCount() async {
    String datetime = DateTime.now().toUtc().toString();
    print(datetime);
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateTicketCount();
    if (res == null) return;
  }

  bool checkExpireStatus(DateTime expireDate) {
    DateTime nowDate =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));
    DateTime formattedExprireDate = DateTime.parse(
        DateFormat('yyyy-MM-dd HH:mm').format(expireDate.toLocal()));
    final difference = formattedExprireDate.difference(nowDate).inMinutes;
    print(nowDate);
    print(formattedExprireDate);
    print(difference);

    if (difference <= 0) {
      print('dif' + '${difference}');
      return true;
    } else {
      return false;
    }
  }

  _createPayment(BuildContext context, ticketId, amount, ticketType) async {
    createPayment = false;
    String apiKey =
        context.read<ModelGoldenTicketScreen>().apiModel?.apiKey ?? '';
    Servicewrapper wrapper = new Servicewrapper();
    print('step 1');

    var res = await wrapper.createPayment(ticketId, amount, ticketType, apiKey);

    if (res == null) return;

    final Map<String, dynamic> parsed = res;

    print(parsed);
    createPaymentModel = CreatePaymentModel.fromJson(parsed);
    print('step 2' + '${createPaymentModel?.data?.addresses?.tether ?? ''}');
    if (createPaymentModel?.data != null) {
      createPayment = true;
      await _buyTicket(context, ticketId, createPaymentModel?.data?.id ?? '',
          createPaymentModel?.data?.addresses?.tether ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FutureBuilder(
              future: context.read<ModelGoldenTicketScreen>().getTickets(),
              builder: (context, snapshot) {
                if (snapshot.data != null &&
                    context
                            .watch<ModelGoldenTicketScreen>()
                            .model
                            ?.data
                            ?.length !=
                        0) {
                  return ListView.builder(
                      itemCount: context
                              .watch<ModelGoldenTicketScreen>()
                              .model
                              ?.data
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var item = context
                            .watch<ModelGoldenTicketScreen>()
                            .model
                            ?.data;
                        bool expired = checkExpireStatus(DateTime.parse(
                            item?[index]?.expireDate ?? '2000-00-00'));

                        return InkWell(
                          onTap: !expired
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Container()
                                                  : Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            radius: 20,
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 25,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                      color: Colors.amber,
                                                    ))
                                                  : Container(),
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Container()
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 16),
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        'Do you want to buy ticket number ${(item?[index]?.ticketNumber ?? 0).toString().padLeft(10, '0')}',
                                                        style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Container()
                                                  : Spacer(),
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 20,
                                                              bottom: 0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          try {
                                                            context
                                                                .read<
                                                                    ModelGoldenTicketScreen>()
                                                                .progressChange(
                                                                    true);
                                                            await _createPayment(
                                                                context,
                                                                item?[index]
                                                                        ?.ticketId ??
                                                                    0,
                                                                item?[index]
                                                                        ?.price ??
                                                                    0,
                                                                "Golden");
                                                            await _updateTicketCount();
                                                            // _getTickets(context);
                                                            Navigator.pop(
                                                                context);
                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return WalletDetailsPopUp(
                                                                      amount:
                                                                          item?[index]?.price ??
                                                                              0,
                                                                      walletAddress: createPaymentModel
                                                                              ?.data
                                                                              ?.addresses
                                                                              ?.tether ??
                                                                          '');
                                                                });
                                                            context
                                                                .read<
                                                                    ModelGoldenTicketScreen>()
                                                                .progressChange(
                                                                    false);
                                                          } catch (e) {
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            20),
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(e
                                                                    .toString())));
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                            color: Colors
                                                                .cyan.shade400,
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          height: 150,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Container()
                                                  : Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            radius: 20,
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 25,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                      color: Colors.amber,
                                                    ))
                                                  : Container(),
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Container()
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 16),
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        'You cannot buy this. it has expired!',
                                                        style: TextStyle(
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.7),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                              context
                                                      .watch<
                                                          ModelGoldenTicketScreen>()
                                                      .progress
                                                  ? Container()
                                                  : Spacer(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                          child: CustomTicket(
                            number: (item?[index]?.ticketNumber ?? 0)
                                .toString()
                                .padLeft(10, '0'),
                            color: Colors.amberAccent,
                            price: item?[index]?.price ?? 0,
                            date: item?[index]?.expireDate ??
                                '2000-00-00 00:00:00',
                            roundNo: item?[index]?.roundNo ?? 0,
                          ),
                        );
                      });
                } else if (context
                        .watch<ModelGoldenTicketScreen>()
                        .model
                        ?.data
                        ?.length ==
                    0) {
                  return Center(
                    child: Text(
                      'No Golden Tickets',
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
            )));
  }

  Widget WalletDetailsPopUp(
      {required int amount, required String walletAddress}) {
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
            QrImage(
              data: walletAddress,
              version: QrVersions.auto,
              size: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Send payment',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                textAlign: TextAlign.center,
                'To make a payment,send USDT to the address below',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.grey),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Amount : ',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    '$amount USDT',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.copy,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.grey),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'USDT Address : ',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Container(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        walletAddress,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () async {
                        await Clipboard.setData(
                            ClipboardData(text: walletAddress));
                        Fluttertoast.showToast(
                            msg: "Copy to Clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 10.0);
                      },
                      child: Icon(
                        Icons.copy,
                        size: 25,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, bottom: 0),
              child: InkWell(
                onTap: () {
                  context.read<ModelGoldenTicketScreen>().getTickets();
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
}
