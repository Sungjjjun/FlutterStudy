import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/features/videos/models/video_model.dart';
import 'package:tiktokclone/features/videos/repos/video_repo.dart';

class TimelineVM extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepostory _repostory;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repostory.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final videos = result.docs.map((doc) {
      return VideoModel.fromJson(
        json: doc.data(),
        videoId: doc.id,
      );
    });
    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repostory = ref.read(videoRepo);
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineVM, List<VideoModel>>(
  () => TimelineVM(),
);
