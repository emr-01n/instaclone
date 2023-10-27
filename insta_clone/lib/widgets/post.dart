import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("images/storyLine.png"),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundImage: AssetImage("images/img1.jpg"),
                      ),
                    ),
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(Icons.more_horiz),
            ],
          ),
        ),
        Container(
          height: 350,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Image.asset("images/ben_max.jpeg"),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.chat_bubble_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.share)
                ],
              ),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              Text("Liked by "),
              Text(
                "Yusuf",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" and "),
              Text(
                "others",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 8),
          child: Row(
            children: [
              Text(
                "Sevgi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" Very cool!! "),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 5),
          child: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "2 days ago",
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
