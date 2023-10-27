part of 'story_bloc.dart';

@immutable
sealed class StoryEvent {}

class PauseStoryEvent extends StoryEvent {}

class ResumeStoryEvent extends StoryEvent {}

class ExitStoryEvent extends StoryEvent {}

class NextStoryEvent extends StoryEvent {}

class PrevStoryEvent extends StoryEvent {}

class NextUserEvent extends StoryEvent {}

class PrevUserEvent extends StoryEvent {}

class WatchStoryEvent extends StoryEvent {}
