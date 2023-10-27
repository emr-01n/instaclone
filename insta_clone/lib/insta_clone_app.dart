import 'package:flutter/material.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/nav_bar.dart';
import 'package:insta_clone/services/data_stream.dart';
import 'package:provider/provider.dart';

class InstaClone extends StatelessWidget {
  final List<User> users;
  const InstaClone({super.key, required this.users});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DataStream(users),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            iconTheme: const IconThemeData(
              color: Color.fromRGBO(40, 40, 40, 1),
            ),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Color.fromRGBO(40, 40, 40, 1),
              ),
              elevation: 1,
              color: Colors.white,
            ),
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(229, 229, 235, 1)),
            useMaterial3: true,
          ),
          home: const NavBar(),
        ));
  }
}
