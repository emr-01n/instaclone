import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:insta_clone/blocs/story_bloc.dart';
import 'package:insta_clone/models/story_model.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/services/data_stream.dart';
import 'package:insta_clone/widgets/story_info_bar.dart';
import 'package:insta_clone/widgets/story_message.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';

class StoryScreen extends StatefulWidget {
  final List<User> users;
  final int initUserIndex;
  final int initStoryIndex;

  const StoryScreen({
    super.key,
    required this.users,
    required this.initUserIndex,
    required this.initStoryIndex,
  });

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with TickerProviderStateMixin {
  late List<User> _users;
  late int _currentUserIndex;
  late int _currentStoryIndex;
  late CarouselSliderController _sliderController;
  late List<PageController> _pageControllers;
  late List<AnimationController> _animControllers;
  late Map<int, List<ChewieController?>> _videoControllers;

  @override
  void initState() {
    super.initState();
    _users = widget.users;
    _currentUserIndex = widget.initUserIndex;
    _currentStoryIndex = widget.initStoryIndex;
    _sliderController = CarouselSliderController();
    _pageControllers = [];
    _animControllers = [];
    _videoControllers = {};
    _initCtrl(_users);
  }

  @override
  void dispose() {
    for (List<ChewieController?> value in _videoControllers.values) {
      for (ChewieController? controller in value) {
        controller?.videoPlayerController.dispose();
        controller?.dispose();
      }
    }
    for (PageController ctrl in _pageControllers) {
      ctrl.dispose();
    }
    for (AnimationController ctrl in _animControllers) {
      ctrl.dispose();
    }
    _sliderController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final StoryBloc bloc = StoryBloc(
          _users,
          _pageControllers,
          _sliderController,
          _animControllers,
          _videoControllers,
          context,
          _currentUserIndex,
          _currentStoryIndex,
        );

        bloc.add(WatchStoryEvent());
        return bloc;
      },
      child: BlocConsumer<StoryBloc, StoryState>(
        listener: _onStateChanged,
        builder: (context, state) {
          StoryBloc bloc = BlocProvider.of<StoryBloc>(context);

          return Scaffold(
            body: SafeArea(
              child: CarouselSlider.builder(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                slideTransform: const CubeTransform(),
                controller: _sliderController,
                initialPage: _currentUserIndex,
                itemCount: _users.length,
                slideBuilder: (userIndex) {
                  User user = _users[userIndex];
                  return GestureDetector(
                    onVerticalDragEnd: (details) {
                      bloc.add(ExitStoryEvent());
                    },
                    onHorizontalDragEnd: (details) {
                      double velocity = details.velocity.pixelsPerSecond.dx;
                      if (velocity > 0) {
                        bloc.add(PrevUserEvent());
                      } else if (velocity < 0) {
                        bloc.add(NextUserEvent());
                      }
                    },
                    onTapUp: (details) {
                      double pos = details.localPosition.dx /
                          MediaQuery.of(context).size.width;
                      if (pos > 0.33) {
                        bloc.add(NextStoryEvent());
                      } else {
                        bloc.add(PrevStoryEvent());
                      }
                    },
                    onLongPressUp: () {
                      bloc.add(ResumeStoryEvent());
                    },
                    onLongPressDown: (details) {
                      bloc.add(PauseStoryEvent());
                    },
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageControllers[userIndex],
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: user.stories.length,
                          itemBuilder: (context, storyIndex) {
                            Story story = user.stories[storyIndex];
                            return Center(
                                child: story.mediaType == MediaType.image
                                    ? CachedNetworkImage(
                                        imageUrl: story.url,
                                        fit: BoxFit.fill,
                                      )
                                    : Chewie(
                                        controller: _videoControllers[
                                            userIndex]![storyIndex]!));
                          },
                        ),
                        Column(
                          children: [
                            StoryInfo(
                              context: context,
                              id: userIndex,
                              storyCount: user.stories.length,
                              currentStoryIndex:
                                  _pageControllers[userIndex].initialPage,
                              user: user,
                              animController: _animControllers[userIndex],
                            ),
                            const Spacer(),
                            const StoryMessage(),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _onStateChanged(context, state) {
    if (state is NoNextStoryState) {
      BlocProvider.of<StoryBloc>(context).add(NextUserEvent());
    }
    if (state is NoNextUserState) {
      BlocProvider.of<StoryBloc>(context).add(ExitStoryEvent());
    }
    if (state is NoPrevStoryState) {
      BlocProvider.of<StoryBloc>(context).add(PrevUserEvent());
    }
    if (state is NoPrevUserState) {
      BlocProvider.of<StoryBloc>(context).add(ExitStoryEvent());
    }
    if (state is AllStoriesWatchedState) {
      Navigator.pop(context);
    }
    if (state is WatchingStoryState) {
      _currentUserIndex = state.newUserIndex;
      _currentStoryIndex = state.newStoryIndex;
      Provider.of<DataStream>(context, listen: false).changeWatchStatus(
        _currentUserIndex,
        _currentStoryIndex,
      );
    }
  }

  void _initCtrl(List<User> users) {
    users.asMap().forEach(
      (index, user) {
        int initialPage = user.indexOfUnwatchedStory();
        PageController pageController =
            PageController(initialPage: initialPage);
        _pageControllers.add(pageController);

        AnimationController animController = AnimationController(vsync: this);
        animController.duration = user.stories[initialPage].duration;
        _animControllers.add(animController);

        _videoControllers[index] = [];

        for (Story story in user.stories) {
          if (story.mediaType == MediaType.image) {
            _videoControllers[index]?.add(null);
          } else {
            VideoPlayerController vpCtrl = VideoPlayerController.networkUrl(
              Uri.parse(story.url).replace(scheme: 'https'),
            );
            ChewieController chewieCtrl = ChewieController(
              videoPlayerController: vpCtrl,
              autoInitialize: true,
              autoPlay: false,
              showControls: false,
            );
            _videoControllers[index]?.add(chewieCtrl);
          }
        }
      },
    );

    _animControllers[_currentUserIndex].forward();
    if (_users[_currentUserIndex].stories[_currentStoryIndex].mediaType ==
        MediaType.video) {
      _videoControllers[_currentUserIndex]?[_currentStoryIndex]?.play();
    }
  }
}
