part of 'story_bloc.dart';

@immutable
sealed class StoryState {}

final class StoryInitialState extends StoryState {}

final class NoNextStoryState extends StoryState {}

final class NoNextUserState extends StoryState {}

final class NoPrevStoryState extends StoryState {}

final class NoPrevUserState extends StoryState {}

final class AllStoriesWatchedState extends StoryState {}

// ignore: must_be_immutable
final class WatchingStoryState extends StoryState {
  BuildContext context;
  int newUserIndex;
  int newStoryIndex;

  WatchingStoryState({
    required this.context,
    required this.newUserIndex,
    required this.newStoryIndex,
  });
}
