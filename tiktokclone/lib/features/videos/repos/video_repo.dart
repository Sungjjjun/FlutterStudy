import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/features/videos/models/video_model.dart';

class VideoRepostory {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
        '/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}');
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel model) async {
    await _db.collection('videos').add(model.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos() async {
    return _db
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .get();
  }
}

final videoRepo = Provider((ref) => VideoRepostory());
