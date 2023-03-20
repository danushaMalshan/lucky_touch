import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucky_touch/providers/model_get_silver_ticket_buyers.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';
import 'package:provider/provider.dart';

class SilverTicketBuyers extends StatefulWidget {
  const SilverTicketBuyers({Key? key}) : super(key: key);

  @override
  State<SilverTicketBuyers> createState() => _SilverTicketBuyersState();
}

class _SilverTicketBuyersState extends State<SilverTicketBuyers> {
  _updateRank(int buyerId, String rank) async {
    String datetime = DateTime.now().toUtc().toString();
    print(datetime);
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateRank(buyerId.toString(), rank);
    if (res == null) return;
  }

  _updatePrice(int buyerId, String price) async {
    String datetime = DateTime.now().toUtc().toString();
    print(datetime);
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updatePrice(buyerId.toString(), price);
    if (res == null) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: context.read<ModelGetSilverTicketBuyers>().getTicketBuyers(),
          builder: (context, snapshot) {
            if (snapshot.data != null &&
                context
                        .watch<ModelGetSilverTicketBuyers>()
                        .model
                        ?.data
                        ?.length !=
                    0) {
              return ListView.builder(
                  itemCount: context
                          .watch<ModelGetSilverTicketBuyers>()
                          .model
                          ?.data
                          ?.length ??
                      0,
                  itemBuilder: ((context, index) {
                    String? dropdownvalue;
                    TextEditingController priceController =
                        TextEditingController();
                    var items = List<String>.generate(100, (i) => "$i");
                    var item =
                        context.watch<ModelGetSilverTicketBuyers>().model?.data;
                    if (item?[index]?.price == null ||
                        item?[index]?.price == 0) {
                      priceController.text = '0';
                    } else {
                      priceController.text = '${item?[index]?.price ?? 0}';
                    }
                    if (item?[index]?.rank != null) {
                      dropdownvalue = (item![index]!.rank).toString();
                    } else {
                      dropdownvalue = null;
                    }

                    DateTime userRegisterd = DateTime.parse(
                            '${item?[index]?.user?.createdAt ?? '2000-01-01'}')
                        .toLocal();

                    return Container(
                      margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
                      height: 270,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(width: 2, color: Colors.amberAccent)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomText('Owner'),
                                  CustomText('Registration Date'),
                                  CustomText('All Tickets '),
                                  CustomText('USDT Address'),
                                  CustomText('Ticket No.'),
                                  CustomText('Ticket Price'),
                                  CustomText('Winning Price'),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 16),
                                    child: CustomText('Rank'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              height: 190,
                              width: 1,
                              color: Colors.white.withOpacity(0.7)),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomText(
                                      '${item?[index]?.user?.firstName ?? ''} ${item?[index]?.user?.lastName ?? ''}'),
                                  CustomText(
                                      '${userRegisterd.year} - ${userRegisterd.month} - ${userRegisterd.day}'),
                                  CustomText(
                                      '${item?[index]?.user?.ticketCount ?? '0'}'),
                                  CustomText(
                                      '${item?[index]?.user?.usdtAddress ?? ''}'),
                                  CustomText(
                                    '${item?[index]?.ticket?.ticketNumber}'
                                        .toString()
                                        .padLeft(10, '0'),
                                  ),
                                  CustomText(
                                      '${item?[index]?.ticket?.price ?? 0} USDT'),
                                  SizedBox(
                                    height: 20,
                                    width: 60,
                                    child: TextField(
                                      onChanged: ((value) {
                                        _updatePrice(
                                            item?[index]?.buyerId ?? 0, value);
                                      }),
                                      controller: priceController,
                                      cursorColor: Colors.white,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              width: 1.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              width: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DropdownButton(
                                    hint: Text(
                                      'Rank',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    style: TextStyle(
                                        //te
                                        color: Colors.white, //Font color
                                        fontSize:
                                            15 //font size on dropdown button
                                        ),
                                    // Initial Value
                                    value: dropdownvalue,

                                    // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    dropdownColor:
                                        Colors.black.withOpacity(0.5),
                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                        _updateRank(item?[index]?.buyerId ?? 0,
                                            newValue);
                                        context
                                            .read<ModelGetSilverTicketBuyers>()
                                            .getTicketBuyers();
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
            } else if (context
                    .watch<ModelGetSilverTicketBuyers>()
                    .model
                    ?.data
                    ?.length ==
                0) {
              return Center(
                child: Text(
                  'No Silver Ticket Buyers',
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
    );
  }

  Text CustomText(String txt) {
    return Text(
      txt,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
    );
  }
}
