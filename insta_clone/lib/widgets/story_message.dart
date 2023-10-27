import 'package:flutter/material.dart';

class StoryMessage extends StatelessWidget {
  const StoryMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Send Message...",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.favorite_border_outlined,
            color: Colors.grey,
            size: 28,
          ),
        ),
      ],
    );
  }
}
