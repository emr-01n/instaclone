import 'package:flutter/material.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/services/data_stream.dart';
import 'package:insta_clone/widgets/post.dart';
import 'package:insta_clone/widgets/story_circle.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final DataStream dataStream = Provider.of<DataStream>(context);
    List<User> users = dataStream.users;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/insta_title.png",
          height: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: StoryTile(
                      userIndex: index,
                      users: users,
                    ),
                  );
                },
              ),
            ),
            const Post(),
            const Post(),
            const Post(),
            const Post(),
          ],
        ),
      ),
    );
  }
}
