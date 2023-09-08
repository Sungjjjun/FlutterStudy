import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/videos/models/video_model.dart';
import 'package:tiktokclone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktokclone/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktokclone/features/videos/views/widgets/video_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'video_comment.dart';

class VideoPost extends ConsumerStatefulWidget {
  final int index;
  final Function onVideoFinished;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  bool _isPaused = false;
  bool _isLiked = false;

  late final AnimationController _animationController;
  late final VideoPlayerController _videoPlayerController;
  final Duration _animatedDuration = const Duration(milliseconds: 200);

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onLikeTap() async {
    ref.read(videoPostProvider(widget.videoData.id).notifier).likeVideo();
    _isLiked = !_isLiked;
    setState(() {});
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/video.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) await _videoPlayerController.setVolume(0);
    _videoPlayerController.addListener(_onVideoChanged);
    _isLiked = await ref
        .read(videoPostProvider(widget.videoData.id).notifier)
        .isLikedVideo();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animatedDuration,
    );
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    final muted = ref.read(playbackConfigProvider).muted;
    ref.read(playbackConfigProvider.notifier).setMuted(!muted);
    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoPlay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentTab(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VideoComment(),
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: AnimatedOpacity(
                        opacity: _isPaused ? 1 : 0,
                        duration: _animatedDuration,
                        child: const FaIcon(
                          FontAwesomeIcons.play,
                          color: Colors.white,
                          size: Sizes.size52,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              icon: FaIcon(
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: _onPlaybackConfigChanged,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.videoData.creator}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size22,
                  ),
                ),
                Gaps.v10,
                Text(
                  widget.videoData.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/my-sungjun-1853.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media",
                  ),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onLikeTap,
                  child: VideoButton(
                    color: _isLiked ? Colors.red : Colors.white,
                    icon: FontAwesomeIcons.solidHeart,
                    ment: widget.videoData.likes.toString(),
                  ),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentTab(context),
                  child: VideoButton(
                    color: Colors.white,
                    icon: FontAwesomeIcons.solidComment,
                    ment: "${widget.videoData.likes.toString()}K",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  color: Colors.white,
                  icon: FontAwesomeIcons.share,
                  ment: 'Share',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
