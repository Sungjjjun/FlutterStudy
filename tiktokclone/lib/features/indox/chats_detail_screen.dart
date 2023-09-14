import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokclone/features/indox/view_models/message_view_model.dart';
import 'package:tiktokclone/utils.dart';

class ChatsDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatsDetail";
  static const String routeURL = ":chatId";
  final String chatId;

  const ChatsDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatsDetailScreen> createState() => _ChatsDetailScreenState();
}

class _ChatsDetailScreenState extends ConsumerState<ChatsDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  void _onSendPress() {
    final text = _textEditingController.text;
    if (text == '') return;
    ref.read(messageProvider.notifier).sendMessage(text);
    _textEditingController.text = '';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messageProvider).isLoading;
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
          title: Text(
            "PSJ (${widget.chatId})",
            style: const TextStyle(
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
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size96,
                      right: Sizes.size14,
                      left: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine =
                          message.userId == ref.watch(authRepo).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
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
                              color: isMine
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: isDarkMode(context) ? Colors.black : Colors.grey.shade50,
              child: Padding(
                padding: EdgeInsets.only(
                  top: Sizes.size10,
                  left: Sizes.size40,
                  right: Sizes.size40,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade200
                              : Colors.grey.shade800,
                        ),
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
                                GestureDetector(
                                  onTap: isLoading ? null : _onSendPress,
                                  child: FaIcon(
                                    isLoading
                                        ? FontAwesomeIcons.hourglass
                                        : FontAwesomeIcons.paperPlane,
                                    color: isDarkMode(context)
                                        ? Colors.grey.shade600
                                        : Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
