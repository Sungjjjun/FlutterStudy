import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String ment;
  final Color color;

  const VideoButton({
    super.key,
    required this.icon,
    required this.ment,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: color,
          size: Sizes.size40,
        ),
        Gaps.v5,
        Text(
          ment,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
