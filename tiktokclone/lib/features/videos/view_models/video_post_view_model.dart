import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokclone/features/videos/repos/video_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepostory _repostory;
  late final String _videoId;
  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _repostory = ref.read(videoRepo);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repostory.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
