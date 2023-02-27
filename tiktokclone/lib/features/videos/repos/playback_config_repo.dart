import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepo {
  static const String _autoPlay = "autoPlay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;

  PlaybackConfigRepo(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoPlay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoPlay) ?? false;
  }
}
