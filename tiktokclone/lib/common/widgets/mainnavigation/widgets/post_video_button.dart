import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  final bool inverted;
  const PostVideoButton({
    super.key,
    required this.inverted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            height: Sizes.size32,
            width: Sizes.size24,
            decoration: BoxDecoration(
              color: const Color(0xFF61D4F0),
              borderRadius: BorderRadius.circular(
                Sizes.size11,
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            height: Sizes.size32,
            width: Sizes.size24,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size11,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size10,
          ),
          height: Sizes.size32,
          decoration: BoxDecoration(
            color: inverted ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(
              Sizes.size11,
            ),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: inverted ? Colors.black : Colors.white,
              size: Sizes.size20,
            ),
          ),
        ),
      ],
    );
  }
}
