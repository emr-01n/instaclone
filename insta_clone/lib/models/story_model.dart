import 'package:intl/intl.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String _url;
  final MediaType _mediaType;
  final Duration _duration;
  final DateTime _date;
  bool isWatched = false;

  Story({
    required url,
    required mediaType,
    required duration,
    required date,
  })  : _url = url,
        _mediaType = mediaType,
        _duration = duration,
        _date = date;

  String get url => _url;
  MediaType get mediaType => _mediaType;
  Duration get duration => _duration;
  DateTime get date => _date;

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      url: json['url'] as String,
      duration: _getDuration(json['duration'] as double),
      mediaType:
          json['mediaType'] == 'image' ? MediaType.image : MediaType.video,
      date:
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(json['date'] as String),
    );
  }

  static Duration _getDuration(double seconds) => Duration(
        seconds: seconds.toInt(),
        milliseconds: ((seconds % 1) * 1000).round(),
      );
}
