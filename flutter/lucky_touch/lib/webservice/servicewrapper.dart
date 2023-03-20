import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:kahawanu/beanResponse/model_login.dart';
import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/login_model.dart';
// import 'package:kahawanu/util/color_scheme.dart';
// import 'package:kahawanu/util/app_theme.dart';
import 'package:lucky_touch/globles.dart';


class Servicewrapper {
  var apifolder = "";
  var mainfolder = "";
  var mediafolder = "media/";
  var indexpage = "index.php/";
  String token = usr?.accessToken ?? '';

  //production
  var baseurl = "https://luckytouch.pw/";
  final ftpDomain = 'luckytouch.win';
  final ftpHost = 'ftp.luckytouch.win';
  final ftpUsr = 'dan@luckytouch.win';
  final ftpPass = 'G2(2V_7qVb0y';
  final ftpPath = '/images';
  final ftpPathPrefix = '';

  //--debug--
  // var baseurl = "http://192.168.1.5:8082/";
  // final ftpDomain = 'kahawanu.xyz';
  // final ftpHost = 'ftp.kahawanu.xyz';
  // final ftpUsr = 'kahawanu';
  // final ftpPass = 'fb2da9d052f9';
  // final ftpPath = '/screenshots';
  // final ftpPathPrefix = '/public_html';

  final printMinPriority = 5;
  printPriority(Object? object, int priority) {
    if (printMinPriority <= priority) print(object);
  }

  void showErrorMsg(String error) {
    final SnackBar snackBar = SnackBar(
        margin: EdgeInsets.only(bottom: 20),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        content: Text(
          error,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ));
    snackbarKey.currentState?.showSnackBar(snackBar);
  }

  var language = 1;
  dynamic _response(http.Response response) {
    if (response.statusCode != 200) {
      print('response.statusCode != 200');
      print(response.body);
      var responseJson = json.decode(response.body.toString());
      final Map<String, dynamic> parsed = responseJson;
      if (parsed['message'] != null) showErrorMsg(parsed['message']);
    }
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        printPriority(responseJson, 1);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
        throw Exception(response.body.toString());
      default:
      //throw FetchDataException(
      //'Invalid URL StatusCode : ${response.statusCode}');
    }
  }

  dynamic _coinbaseResponse(http.Response response) {
    if (response.statusCode != 201) {
      print('response.statusCode != 200');
      print(response.body);
      var responseJson = json.decode(response.body.toString());
      final Map<String, dynamic> parsed = responseJson;
      if (parsed['message'] != null) showErrorMsg(parsed['message']);
    }
    switch (response.statusCode) {
      case 201:
        var responseJson = json.decode(response.body.toString());
        printPriority(responseJson, 1);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
        throw Exception(response.body.toString());
      default:
      //throw FetchDataException(
      //'Invalid URL StatusCode : ${response.statusCode}');
    }
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  uploadFile(File file, String remoteDir) async {
    FTPConnect ftpConnect =
        FTPConnect(ftpHost, user: ftpUsr, pass: ftpPass, port: 21);
    File fileToUpload = file;
    printPriority('fileToUploadd' + '$fileToUpload', 6);
    await ftpConnect.connect();
    await ftpConnect.changeDirectory(ftpPathPrefix + remoteDir);
    bool res =
        await ftpConnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);
    await ftpConnect.disconnect();
    printPriority(res, 6);
  }

  //signUp
  signUp(firstName, lastName, String filename, country, usdtAddress, email,
      password) async {
    var responseJson;
    var url = baseurl + "api/auth/signup";
    final body = {
      'first_name': firstName,
      'last_name': lastName,
      'profile_pic': filename != ''
          ? 'http://$ftpDomain/images/app_avatar/$filename'
          : null,
      'country': country,
      'usdt_address': usdtAddress,
      'email': email,
      'password': password,
      'role': ['user']
    };
    printPriority("signup" + url + "---" + json.encode(body), 1);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
        },
        body: json.encode(body));
    try {
      responseJson = _response(response);
    } catch (e) {
      print('error caught signup : $e');
      return responseJson;
    }
    return responseJson;
  }

  //LogIn
  logIn(String email, password) async {
    var responseJson;
    var url = baseurl + "api/auth/signin";
    final body = {'email': email, 'password': password};
    printPriority('*****logIn*****', 5);
    printPriority(body, 5);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
        },
        body: json.encode(body));
    try {
      //printPriority(response.body, 5);
      responseJson = _response(response);
    } catch (e) {
      print('error caught Login : $e');
      return responseJson;
    }
    return responseJson;
  }

  //LogIn
  logOut(String email, password) async {
    var responseJson;
    var url = baseurl + "api/auth/signout";
    final body = {'email': email, 'password': password};
    printPriority('*****logOut*****', 5);
    printPriority(body, 5);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
        },
        body: json.encode(body));
    try {
      //printPriority(response.body, 5);
      responseJson = _response(response);
    } catch (e) {
      print('error caught Login : $e');
      return responseJson;
    }
    return responseJson;
  }

  String correctHost(String url) {
    Servicewrapper wrapper = new Servicewrapper();
    Uri uri = Uri.parse(url);
    uri = uri.replace(scheme: 'http', host: wrapper.ftpDomain);
    return uri.toString();
  }

  userDetails() async {
    var responseJson;
    var url = baseurl + "api/users/info";
    final body = {};
    printPriority("user info" + url + "---" + json.encode(body), 1);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    printPriority("user_info_json" + response.body, 1);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught userinfo : $e');
      return responseJson;
    }
    return responseJson;
  }

  getOnlineUsers() async {
    var responseJson;
    var url = baseurl + "api/users/online";
    final body = {};
    printPriority("online users" + url + "---" + json.encode(body), 1);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    printPriority("online_users" + response.body, 1);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught online_users : $e');
      return responseJson;
    }
    return responseJson;
  }

  getBanUsers() async {
    var responseJson;
    var url = baseurl + "api/users/banned";
    final body = {};
    printPriority("online users" + url + "---" + json.encode(body), 1);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    printPriority("banned_users" + response.body, 1);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught banned_users : $e');
      return responseJson;
    }
    return responseJson;
  }

  getNewUsers() async {
    var responseJson;
    var url = baseurl + "api/users/new";
    final body = {};
    printPriority("new users" + url + "---" + json.encode(body), 1);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    printPriority("new users" + response.body, 1);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught new users : $e');
      return responseJson;
    }
    return responseJson;
  }

  // getAllUsers(String query) async {
  //   var responseJson;
  //   var url = baseurl + "api/users/findAll";
  //   final body = {'query': 'ss'};
  //   printPriority("getAllUsers" + url + "---" + json.encode(body), 1);
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-type': 'application/json;charset=UTF-8',
  //       'Accept': 'application/json',
  //       'x-access-token': token
  //     },
  //     //body: json.encode(body)
  //   );
  //   // final response  = await http.post( url, headers: headerParams, body: bodyparam );
  //   //var data=json.encode(responseJson);
  //   printPriority("getAllUsers" + response.body, 1);
  //   try {
  //     responseJson = _response(response);
  //     //print("responseJson"+response.toString() );
  //     //var data=json.encode(response);
  //     // print("responseJson"+data);
  //   } catch (e) {
  //     print('error caught getAllUsers : $e');
  //     return responseJson;
  //   }
  //   return responseJson;
  // }

  getAllUsers(String query) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/users/findAll";
    final body = {
      'query': query,
    };
    print("getAllUsers" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getAllUsers" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getAllUsers : $e');
      return responseJson;
    }
    return responseJson;
  }

  getAllTicketBuyers(String query) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/tickets/buyers/all";
    final body = {
      'query': query,
    };
    print("getAllTicketBuyers" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getAllTicketBuyers" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getAllTicketBuyers : $e');
      return responseJson;
    }
    return responseJson;
  }

  getPreviousWinners(int roundId) async {
    var responseJson;
    var url = baseurl + "api/tickets/previous_winners/$roundId";
    final body = {};
    printPriority("getPreviousWinners" + url + "---" + json.encode(body), 1);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    printPriority("getPreviousWinners" + response.body, 1);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught new users : $e');
      return responseJson;
    }
    return responseJson;
  }

  getApiKey() async {
    var responseJson;
    var url = baseurl + "api/get";
    final body = {};
    printPriority("getApiKey" + url + "---" + json.encode(body), 1);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    printPriority("getApiKey" + response.body, 1);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught new users : $e');
      return responseJson;
    }
    return responseJson;
  }

  addTickets(ticketType, roundNo, title, price, startDate, expireDate,
      quantity) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/tickets/add";
    final body = {
      'ticket_type': ticketType,
      'round_no': roundNo,
      'title': title,
      'price': price,
      'start_date': startDate,
      'expire_date': expireDate,
      'quantity': quantity
    };
    print("addTickets" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("addTickets" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught additional : $e');
      return responseJson;
    }
    return responseJson;
  }

  addRound(roundNo, price, startAt, endAt) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/rounds/add";
    final body = {
      'round_no': roundNo,
      'price': price,
      'start_at': startAt,
      'end_at': endAt,
    };
    print("addRounds" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("addRounds" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught additional : $e');
      return responseJson;
    }
    return responseJson;
  }

  resetPassword(String step, email, code, password) async {
    var responseJson;
    var url = baseurl + "api/auth/resetPassword";
    final body = {
      'step': step,
      'email': email,
      'code': code,
      'password': password
    };
    printPriority('*****email*****', 5);
    printPriority(body, 5);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
        },
        body: json.encode(body));
    try {
      //printPriority(response.body, 5);
      responseJson = _response(response);
    } catch (e) {
      print('error caught email : $e');
      return responseJson;
    }
    return responseJson;
  }

  AddTickets(usersId, msg, isSender) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/chats/add";
    final body = {"users_id": usersId, "msg": msg, "is_sender": isSender};
    print("addTickets" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("addTickets" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught addTickets : $e');
      return responseJson;
    }
    return responseJson;
  }

  SendNotification(String msg) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = "https://onesignal.com/api/v1/notifications";
    final body = {
      "app_id": "dd96ae3d-6e96-4ac3-890a-c8723cc03ad5",
      "included_segments": ["Subscribed Users"],
      "data": {"foo": "bar"},
      "contents": {"en": "$msg"}
    };
    print("addTickets" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization':
              'Basic ZDc1ZTg0NzEtNDJlYi00Zjg5LThiYTItNzg3YWQxNDMzZjc2'
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("sendNotification" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught sendNotification : $e');
      return responseJson;
    }
    return responseJson;
  }

  AddBanners(banner_url, lunch_url) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/banners/add";
    final body = {
      "banner_url": banner_url != ''
          ? 'http://$ftpDomain/images/banners/$banner_url'
          : null,
      "lunch_url": lunch_url
    };
    print("addBanners" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("addBanners" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught addTickets : $e');
      return responseJson;
    }
    return responseJson;
  }

  getBanners() async {
    var responseJson;
    var url = baseurl + "api/banners/get";
    final body = {};
    print("getBanners" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getBanners" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getBanners : $e');
      return responseJson;
    }
    return responseJson;
  }

  getTickets(ticketType) async {
    var responseJson;
    var url = baseurl + "api/tickets/find_tickets/$ticketType";
    final body = {};
    print("FBCamp" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getTickets" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught fbcamps : $e');
      return responseJson;
    }
    return responseJson;
  }

  getAllTickets() async {
    var responseJson;
    var url = baseurl + "api/tickets/find_tickets/all";
    final body = {};
    print("getAllTickets" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getAllTickets" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getAllTickets : $e');
      return responseJson;
    }
    return responseJson;
  }

  getChats() async {
    var responseJson;
    var url = baseurl + "api/user/chat/all";
    final body = {};
    print("getChats" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getChats" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getChats : $e');
      return responseJson;
    }
    return responseJson;
  }

  getUserChats(id) async {
    var responseJson;
    var url = baseurl + "api/user/chat/$id";
    final body = {};
    print("getUserChats" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getUserChats" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getUserChats : $e');
      return responseJson;
    }
    return responseJson;
  }

  getChattedUsers() async {
    var responseJson;
    var url = baseurl + "api/users/chatted";
    final body = {};
    print("getChattedUsers" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getChattedUsers" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getChattedUsers : $e');
      return responseJson;
    }
    return responseJson;
  }

  getNotifications() async {
    var responseJson;
    var url = baseurl + "api/notifications/all";
    final body = {};
    print("Notifications" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getNotifications" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getNotifications : $e');
      return responseJson;
    }
    return responseJson;
  }

  getLastRound() async {
    var responseJson;
    var url = baseurl + "api/last_round/get";
    final body = {};
    print("getRounds" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getRounds" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught fbcamps : $e');
      return responseJson;
    }
    return responseJson;
  }

  showAPayment(paymentId) async {
    var responseJson;
    var url = "https://api.commerce.coinbase.com/charges/$paymentId";
    final body = {};
    print("ShowPayment" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CC-Api-Key': 'af03689c-141f-4b5f-9bde-b93a4ca53bec',
        'X-CC-Version': '2018-03-22'
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("ShowPayment" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught showPayment : $e');
      return responseJson;
    }
    return responseJson;
  }

  getUserTickets() async {
    var responseJson;
    var url = baseurl + "api/tickets/user";
    final body = {};
    print("userTickets" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("userTickets" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught fbcamps : $e');
      return responseJson;
    }
    return responseJson;
  }

  getWinners() async {
    var responseJson;
    var url = baseurl + "api/tickets/winners";
    final body = {};
    print("getWinners" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getWinners" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught getWinners : $e');
      return responseJson;
    }
    return responseJson;
  }

  getTicketBuyers(int ticket_type) async {
    var responseJson;
    var url = baseurl + "api/tickets/buyers/$ticket_type";
    final body = {};
    print("getTicketBuyers" + url + "---" + json.encode(body));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'x-access-token': token
      },
      //body: json.encode(body)
    );
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("getTicketBuyers" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught fbcamps : $e');
      return responseJson;
    }
    return responseJson;
  }

  buyTicket(ticketId, paymentId, walletAddress) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/tickets/buy";
    final body = {
      'ticket_id': ticketId,
      'payment_id': paymentId,
      'wallet_address': walletAddress
    };
    print("addTickets" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("addTickets" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught additional : $e');
      return responseJson;
    }
    return responseJson;
  }

  deleteUser(int id) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/users/remove/$id";
    final body = {};
    print("removeUser" + url + "---" + json.encode(body));
    final response = await http.delete(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("removeUser" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught removeUser : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateRank(buyerId, rank) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/tickets/buyers/update/rank";
    final body = {
      'buyer_id': buyerId,
      'rank': rank,
    };
    print("addTickets" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("addTickets" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught additional : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateApiKey(String key) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/update";
    final body = {
      'api_key': key,
    };
    print("UpdateApi" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("UpdateApi" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught UpdateApi : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateUserDetails(firstName, lastName, profilePic, country, usdtAddress,
      email, int containImage) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/users/details/update";
    var body;
    if (containImage == 1) {
      body = {
        'first_name': firstName,
        'last_name': lastName,
        'profile_pic': profilePic != ''
            ? 'http://$ftpDomain/images/app_avatar/$profilePic'
            : null,
        'country': country,
        'usdt_address': usdtAddress,
        'email': email
      };
    } else if (containImage == 0) {
      body = {
        'first_name': firstName,
        'last_name': lastName,
        'country': country,
        'usdt_address': usdtAddress,
        'email': email
      };
    }

    print("userDetailsUpdate" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("userDetailsUpdate" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught userDetailsUpdate : $e');
      return responseJson;
    }
    return responseJson;
  }

  updatePrice(buyerId, price) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/tickets/buyers/update/price";
    final body = {
      'buyer_id': buyerId,
      'price': price,
    };
    print("updatePrice" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("updatePrice" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught updatePrice : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateChattedUser(msg) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/users/chat/update";
    final body = {
      'last_msg': msg,
    };
    print("lastMsg" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("lastMsg" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught lastMsg : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateMsgSeen(id) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/users/chat/seen/update/$id";
    final body = {};
    print("updateMsgSeen" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("updateMsgSeen" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught lastMsg : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateLastOnline(lastOnline, tokenn) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/users/last_online/update";
    final body = {
      'last_online': lastOnline,
    };
    print("LastOnline" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': tokenn
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("LastOnline" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught LastOnline : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateTicketCount() async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/users/ticket_count/update";
    final body = {};
    print("updateTicketCount" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("updateTicketCount" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught additional : $e');
      return responseJson;
    }
    return responseJson;
  }

  updateTimeline(buyerId, timeline) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = baseurl + "api/tickets/buyers/update/timeline";
    final body = {
      'buyer_id': buyerId,
      'timeline': timeline,
    };
    print("updateTimeline" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'x-access-token': token
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("updateTimeline" + response.body);
    try {
      responseJson = _response(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught additional : $e');
      return responseJson;
    }
    return responseJson;
  }

  createPayment(ticketId, amount, ticketType, apiKey) async {
    // print('noooo' + whatsappNo);
    var responseJson;
    var url = "https://api.commerce.coinbase.com/charges";
    final body = {
      "name": ticketId,
      "description": ticketType,
      "pricing_type": "fixed_price",
      "local_price": {"amount": amount, "currency": "USD"},
      "redirect_url": "https://charge/completed/page",
      "cancel_url": "https://charge/canceled/page"
    };
    print("createPayment" + url + "---" + json.encode(body));
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CC-Api-Key': apiKey,
          'X-CC-Version': '2018-03-22'
        },
        body: json.encode(body));
    // final response  = await http.post( url, headers: headerParams, body: bodyparam );
    //var data=json.encode(responseJson);
    print("createPayment" + response.body);
    try {
      responseJson = _coinbaseResponse(response);
      //print("responseJson"+response.toString() );
      //var data=json.encode(response);
      // print("responseJson"+data);
    } catch (e) {
      print('error caught additional : $e');
      return responseJson;
    }
    return responseJson;
  }
}

String correctHost(String url) {
  Servicewrapper wrapper = new Servicewrapper();
  Uri uri = Uri.parse(url);
  uri = uri.replace(scheme: 'http', host: wrapper.ftpDomain);
  return uri.toString();
}
