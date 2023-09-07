import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/features/videos/models/video_model.dart';
import 'package:tiktokclone/features/videos/repos/video_repo.dart';

class TimelineVM extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepostory _repostory;
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _repostory = ref.read(videoRepo);
    final result = await _repostory.fetchVideos();
    final newList = result.docs.map((doc) {
      return VideoModel.fromJson(doc.data());
    });
    _list = newList.toList();
    return _list;
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineVM, List<VideoModel>>(
  () => TimelineVM(),
);
