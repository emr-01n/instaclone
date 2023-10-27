import 'dart:convert';

import '../models/user_model.dart';
import 'package:flutter/services.dart' as rb;

class GetData {
  static Future<List<User>> getData(String path) async {
    String dataStr = await rb.rootBundle.loadString(path);
    List<dynamic> dataJson = json.decode(dataStr);
    return dataJson.map((userJson) => User.fromJson(userJson)).toList();
  }
}
