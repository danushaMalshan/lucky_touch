import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';







class LocalRepo {
  Future<String?> getToken() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    return value;
  }

  Future<void> setToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');
  }


   Future<String?> getTimeline(String payment_id) async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: payment_id);
    return value;
  }

  Future<void> setTimeline(String payment_id,String timeline) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: payment_id, value: timeline);
  }

  Future<void> deleteTimeline(String payment_id) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: payment_id);
  }


  
}
