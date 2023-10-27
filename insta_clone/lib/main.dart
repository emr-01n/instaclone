import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/insta_clone_app.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/services/get_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<User> data = await GetData.getData("assets/data.json");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(InstaClone(
    users: data,
  ));
}
