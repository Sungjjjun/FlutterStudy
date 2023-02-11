import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/utils.dart';

class ChatsDetailScreen extends StatefulWidget {
  const ChatsDetailScreen({super.key});

  @override
  State<ChatsDetailScreen> createState() => _ChatsDetailScreenState();
}

class _ChatsDetailScreenState extends State<ChatsDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _text = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _text = _textEditingController.text;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                radius: 22,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/103017099?v=4",
                ),
                child: Text("PSJ"),
              ),
              Positioned(
                bottom: -Sizes.size5,
                right: -Sizes.size5,
                child: Container(
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size4,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            "PSJ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                size: Sizes.size20,
                color: isDarkMode(context)
                    ? Colors.grey.shade600
                    : Colors.grey.shade800,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
                color: isDarkMode(context)
                    ? Colors.grey.shade600
                    : Colors.grey.shade800,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size12,
              horizontal: Sizes.size14,
            ),
            itemBuilder: (context, index) {
              final isMine = index % 2 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.size14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(
                          Sizes.size20,
                        ),
                        topRight: const Radius.circular(
                          Sizes.size20,
                        ),
                        bottomLeft: Radius.circular(
                          isMine ? Sizes.size20 : 0,
                        ),
                        bottomRight: Radius.circular(
                          isMine ? 0 : Sizes.size20,
                        ),
                      ),
                      //border: Border.all(color: ),
                      color:
                          isMine ? Colors.blue : Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      "This is a message",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v10,
            itemCount: 10,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              padding: const EdgeInsets.only(
                right: Sizes.size14,
                left: Sizes.size14,
                top: Sizes.size14,
                bottom: Sizes.size28,
              ),
              color: isDarkMode(context)
                  ? Colors.grey.shade900
                  : Colors.grey.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDarkMode(context)
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        hintText: "Send a messages...",
                        hintStyle: const TextStyle(
                          fontSize: Sizes.size18,
                          color: Colors.grey,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              Sizes.size32,
                            ),
                            topRight: Radius.circular(
                              Sizes.size32,
                            ),
                            bottomLeft: Radius.circular(
                              Sizes.size32,
                            ),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: Sizes.size10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.faceSmile,
                                color: isDarkMode(context)
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade800,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDarkMode(context)
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.paperPlane,
                        color: isDarkMode(context)
                            ? Colors.grey.shade600
                            : Colors.grey.shade800,
                        size: Sizes.size28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
