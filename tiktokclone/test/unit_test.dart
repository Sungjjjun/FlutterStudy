import 'package:flutter_test/flutter_test.dart';
import 'package:tiktokclone/features/videos/models/video_model.dart';

void main() {
  group("Video Model Test", () {
    test("Constructor", () {
      final video = VideoModel(
        id: "id",
        title: "title",
        description: "description",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        creator: "creator",
        likes: 1,
        comments: 1,
        creatorUid: "creatorUid",
        createdAt: 1,
      );
      expect(video.title, 'title');
    });
    test(".fromJson Constructor", () {
      final video = VideoModel.fromJson(
        json: {
          "id": "id",
          "title": "title",
          "description": "description",
          "fileUrl": "fileUrl",
          "thumbnailUrl": "thumbnailUrl",
          "creator": "creator",
          "likes": 1,
          "comments": 1,
          "creatorUid": "creatorUid",
          "createdAt": 1,
        },
        videoId: "videoId",
      );
      expect(video.comments, greaterThan(0));
    });
    test(".toJson Constructor", () {
      final video = VideoModel(
        id: "id",
        title: "title",
        description: "description",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        creator: "creator",
        likes: 1,
        comments: 1,
        creatorUid: "creatorUid",
        createdAt: 1,
      );
      final json = video.toJson();
      expect(json['id'], "id");
      expect(json['title'], isInstanceOf<String>());
    });
  });
}
