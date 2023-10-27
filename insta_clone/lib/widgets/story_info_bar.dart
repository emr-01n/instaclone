import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/blocs/story_bloc.dart';

import '../models/user_model.dart';

class StoryInfo extends StatefulWidget {
  final BuildContext context;
  final int id;
  final int storyCount;
  final int currentStoryIndex;
  final User user;
  final AnimationController animController;

  const StoryInfo({
    super.key,
    required this.context,
    required this.id,
    required this.storyCount,
    required this.currentStoryIndex,
    required this.user,
    required this.animController,
  });

  @override
  State<StoryInfo> createState() => _StoryInfoState();
}

class _StoryInfoState extends State<StoryInfo> {
  @override
  late BuildContext context;
  late int id;
  late int storyCount;
  late int currentStoryIndex;
  late User user;
  late AnimationController animController;
  late double barWidth;
  late double barSpace;
  late StoryBloc bloc;

  @override
  void initState() {
    super.initState();
    context = widget.context;
    id = widget.id;
    storyCount = widget.storyCount;
    currentStoryIndex = widget.currentStoryIndex;
    user = widget.user;
    bloc = BlocProvider.of<StoryBloc>(context);
    animController = widget.animController;
    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        bloc.add(NextStoryEvent());
      }
    });
    barWidth = MediaQuery.of(context).size.width / storyCount;
    barSpace = 2.5;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryBloc, StoryState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 3,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: storyCount,
                itemBuilder: (context, i) {
                  return _barBuilder(barIndex: i);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: CachedNetworkImageProvider(
                    user.profileImageUrl,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 30.0,
                    color: Colors.grey,
                  ),
                  onPressed: () => bloc.add(ExitStoryEvent()),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _onStateChanged(context, state) {
    if (state is WatchingStoryState) {
      if (state.newUserIndex == id) {
        setState(() {
          currentStoryIndex = state.newStoryIndex;
        });
      } else {
        animController.stop();
        animController.reset();
      }
    }
  }

  Widget _barBuilder({required int barIndex}) {
    if (barIndex < currentStoryIndex) {
      return Padding(
        padding: EdgeInsets.only(left: barSpace, right: barSpace),
        child: Container(
          width: barWidth - (2 * barSpace),
          color: Colors.white,
        ),
      );
    } else if (barIndex == currentStoryIndex) {
      return Padding(
        padding: EdgeInsets.only(left: barSpace, right: barSpace),
        child: AnimatedBuilder(
          animation: animController,
          builder: (context, child) {
            return Row(
              children: [
                Container(
                  width: (barWidth - (2 * barSpace)) * animController.value,
                  color: Colors.white,
                ),
                Container(
                  width:
                      (barWidth - (2 * barSpace)) * (1 - animController.value),
                  color: Colors.grey,
                ),
              ],
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: barSpace, right: barSpace),
        child: Container(
          width: barWidth - (2 * barSpace),
          color: Colors.grey,
        ),
      );
    }
  }
}
