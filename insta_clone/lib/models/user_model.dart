import 'package:insta_clone/models/story_model.dart';

class User {
  final String _username;
  final String _profileImageUrl;
  final List<Story> _stories;

  User({
    required username,
    required profileImageUrl,
    required stories,
  })  : _username = username,
        _profileImageUrl = profileImageUrl,
        _stories = stories;

  String get username => _username;
  String get profileImageUrl => _profileImageUrl;
  List<Story> get stories => _stories;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      stories: (json['stories'] as List<dynamic>)
          .map((storyJson) => Story.fromJson(storyJson))
          .toList(),
    );
  }

  bool isThereUnwatchedStory() {
    for (Story story in _stories) {
      if (!story.isWatched) {
        return true;
      }
    }
    return false;
  }

  int indexOfUnwatchedStory() {
    int index = 0;

    for (int i = 0; i < _stories.length; i++) {
      if (!_stories[i].isWatched) {
        index = i;
        break;
      }
    }
    return index;
  }

  void sortStories() {
    _stories.sort((s1, s2) => s1.date.compareTo(s2.date));
  }
}
