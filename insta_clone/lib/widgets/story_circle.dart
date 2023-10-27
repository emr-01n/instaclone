import 'package:flutter/material.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/screens/story_page.dart';

class StoryTile extends StatelessWidget {
  final int userIndex;
  final List<User> users;

  const StoryTile({super.key, required this.userIndex, required this.users});

  @override
  Widget build(BuildContext context) {
    User user = users[userIndex];
    int storyIndex = user.indexOfUnwatchedStory();

    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return StoryScreen(
                initUserIndex: userIndex,
                initStoryIndex: storyIndex,
                users: users,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        side: const BorderSide(style: BorderStyle.none),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: user.isThereUnwatchedStory()
                ? const Color.fromRGBO(203, 73, 101, 1)
                : const Color.fromRGBO(158, 158, 158, 1),
            child: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(user.profileImageUrl),
            ),
          ),
          Text(
            user.username,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
