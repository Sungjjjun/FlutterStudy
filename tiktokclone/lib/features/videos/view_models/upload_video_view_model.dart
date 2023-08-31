import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokclone/features/user/view_models/user_view_model.dart';
import 'package:tiktokclone/features/videos/models/video_model.dart';
import 'package:tiktokclone/features/videos/repos/video_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepostory _videoRepostory;
  @override
  FutureOr<void> build() {
    _videoRepostory = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final uid = ref.read(authRepo).user!.uid;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _videoRepostory.uploadVideoFile(video, uid);
        if (task.metadata != null) {
          await _videoRepostory.saveVideo(
            VideoModel(
              title: 'From Flutter',
              description: 'Wow!!',
              fileUrl: await task.ref.getDownloadURL(),
              thumbnailUrl: '',
              likes: 0,
              comments: 0,
              creatorUid: uid,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              creator: userProfile.name,
            ),
          );
          context.pushReplacement('/home');
        }
      });
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
