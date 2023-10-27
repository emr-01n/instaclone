import 'package:flutter/foundation.dart';
import 'package:insta_clone/models/user_model.dart';

class DataStream extends ChangeNotifier {
  final List<User> _users;

  DataStream(this._users);

  List<User> get users => _users;

  void changeWatchStatus(int userIndex, int storyIndex) {
    _users[userIndex].stories[storyIndex].isWatched = true;
    notifyListeners();
  }
}
