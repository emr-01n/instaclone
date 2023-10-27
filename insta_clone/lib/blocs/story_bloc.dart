import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:insta_clone/models/story_model.dart';
import 'package:insta_clone/models/user_model.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final List<User> users;
  final List<PageController> _pageControllers;
  final CarouselSliderController _sliderController;
  final List<AnimationController> _animControllers;
  final Map<int, List<ChewieController?>> _videoControllers;
  BuildContext context;
  int userIndex;
  int storyIndex;

  StoryBloc(
      this.users,
      this._pageControllers,
      this._sliderController,
      this._animControllers,
      this._videoControllers,
      this.context,
      this.userIndex,
      this.storyIndex)
      : super(StoryInitialState()) {
    on<WatchStoryEvent>((event, emit) {
      emit(WatchingStoryState(
        context: context,
        newUserIndex: userIndex,
        newStoryIndex: storyIndex,
      ));
    });

    on<PauseStoryEvent>(
      (event, emit) {
        _animControllers[userIndex].stop();
        if (users[userIndex].stories[storyIndex].mediaType == MediaType.video) {
          _videoControllers[userIndex]?[storyIndex]?.pause();
        }
      },
    );

    on<ResumeStoryEvent>(
      (event, emit) {
        _animControllers[userIndex].forward();
        if (users[userIndex].stories[storyIndex].mediaType == MediaType.video) {
          _videoControllers[userIndex]?[storyIndex]?.play();
        }
      },
    );

    on<ExitStoryEvent>((event, emit) => emit(AllStoriesWatchedState()));

    on<NextStoryEvent>(
      (event, emit) {
        if (storyIndex >= users[userIndex].stories.length - 1) {
          emit(NoNextStoryState());
        } else {
          _animControllers[userIndex].reset();
          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.pause();
            _videoControllers[userIndex]?[storyIndex]?.seekTo(Duration.zero);
          }
          storyIndex += 1;
          _pageControllers[userIndex].nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.play();
          }
          _animControllers[userIndex].duration =
              users[userIndex].stories[storyIndex].duration;
          _animControllers[userIndex].forward();
          emit(WatchingStoryState(
            context: context,
            newUserIndex: userIndex,
            newStoryIndex: storyIndex,
          ));
        }
      },
    );

    on<PrevStoryEvent>(
      (event, emit) {
        if (storyIndex <= 0) {
          emit(NoPrevStoryState());
        } else {
          _animControllers[userIndex].reset();
          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.pause();
            _videoControllers[userIndex]?[storyIndex]?.seekTo(Duration.zero);
          }
          storyIndex -= 1;
          _pageControllers[userIndex].previousPage(
            duration: const Duration(milliseconds: 70),
            curve: Curves.linear,
          );
          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.play();
          }
          _animControllers[userIndex].duration =
              users[userIndex].stories[storyIndex].duration;
          _animControllers[userIndex].forward();
          emit(WatchingStoryState(
            context: context,
            newUserIndex: userIndex,
            newStoryIndex: storyIndex,
          ));
        }
      },
    );

    on<NextUserEvent>(
      (event, emit) {
        if (userIndex >= users.length - 1) {
          emit(NoNextUserState());
        } else {
          _animControllers[userIndex].reset();
          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.pause();
            _videoControllers[userIndex]?[storyIndex]?.seekTo(Duration.zero);
          }
          userIndex++;
          storyIndex = users[userIndex].indexOfUnwatchedStory();
          _sliderController.nextPage(const Duration(milliseconds: 800));

          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.play();
          }
          _animControllers[userIndex].duration =
              users[userIndex].stories[storyIndex].duration;
          _animControllers[userIndex].forward();
          emit(WatchingStoryState(
            context: context,
            newUserIndex: userIndex,
            newStoryIndex: storyIndex,
          ));
        }
      },
    );

    on<PrevUserEvent>(
      (event, emit) {
        if (userIndex <= 0) {
          emit(NoPrevUserState());
        } else {
          _animControllers[userIndex].reset();
          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.pause();
            _videoControllers[userIndex]?[storyIndex]?.seekTo(Duration.zero);
          }
          userIndex--;
          storyIndex = users[userIndex].indexOfUnwatchedStory();
          _sliderController.previousPage(const Duration(milliseconds: 1000));

          if (users[userIndex].stories[storyIndex].mediaType ==
              MediaType.video) {
            _videoControllers[userIndex]?[storyIndex]?.play();
          }
          _animControllers[userIndex].duration =
              users[userIndex].stories[storyIndex].duration;
          _animControllers[userIndex].forward();
          emit(WatchingStoryState(
            context: context,
            newUserIndex: userIndex,
            newStoryIndex: storyIndex,
          ));
        }
      },
    );
  }
}
