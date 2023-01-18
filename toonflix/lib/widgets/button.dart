import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episodes_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgcolor;
  final Color textcolor;
  final WebtoonEpisodeModel episodes;
  final String webtoonId;

  const Button({
    super.key,
    required this.text,
    required this.bgcolor,
    required this.textcolor,
    required this.episodes,
    required this.webtoonId,
  });

  onButtonTab() async {
    await launchUrlString(
        'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episodes.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTab,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: textcolor,
            width: 2,
          ),
          color: bgcolor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textcolor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: textcolor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
