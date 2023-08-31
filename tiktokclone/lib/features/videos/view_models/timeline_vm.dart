import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/features/videos/models/video_model.dart';

class TimelineVM extends AsyncNotifier<List<VideoModel>> {
  final List<VideoModel> _list = [];

  void uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(
      const Duration(seconds: 2),
    );
    // final newVideo = VideoModel(title: "${DateTime.now()}");
    // _list = [..._list, newVideo];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    return _list;
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineVM, List<VideoModel>>(
  () => TimelineVM(),
);
