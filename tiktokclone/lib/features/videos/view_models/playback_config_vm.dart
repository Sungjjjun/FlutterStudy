import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/features/videos/models/playback_config_model.dart';
import 'package:tiktokclone/features/videos/repos/playback_config_repo.dart';

class PlaybackConfigVM extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepo _repo;

  PlaybackConfigVM(this._repo);

  void setMuted(bool value) {
    _repo.setMuted(value);
    state = PlaybackConfigModel(muted: value, autoPlay: state.autoPlay);
  }

  void setAutoplay(bool value) {
    _repo.setAutoplay(value);
    state = PlaybackConfigModel(muted: state.muted, autoPlay: value);
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repo.isMuted(),
      autoPlay: _repo.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigVM, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
