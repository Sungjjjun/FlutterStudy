import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/discover/discover_screen.dart';
import 'package:tiktokclone/features/indox/inbox_screen.dart';
import 'package:tiktokclone/common/widgets/mainnavigation/widgets/nav_tab.dart';
import 'package:tiktokclone/common/widgets/mainnavigation/widgets/post_video_button.dart';
import 'package:tiktokclone/features/user/user_profile_screen.dart';
import 'package:tiktokclone/features/videos/video_recording_screen.dart';
import 'package:tiktokclone/features/videos/video_timeline_screen.dart';
import 'package:tiktokclone/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxxxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTab(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTab() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "SJ",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: isDarkMode(context) ? Colors.black : Colors.white,
        padding: const EdgeInsets.only(
          bottom: Sizes.size32,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                selectedIcon: FontAwesomeIcons.house,
                icon: FontAwesomeIcons.house,
                label: "Home",
                isSelected: _selectedIndex == 0,
                onTab: () => _onTab(0),
              ),
              NavTab(
                selectedIcon: FontAwesomeIcons.solidCompass,
                icon: FontAwesomeIcons.compass,
                label: "Discover",
                isSelected: _selectedIndex == 1,
                onTab: () => _onTab(1),
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTab,
                child: PostVideoButton(
                  inverted: isDarkMode(context),
                ),
              ),
              Gaps.h24,
              NavTab(
                selectedIcon: FontAwesomeIcons.solidMessage,
                icon: FontAwesomeIcons.message,
                label: "Inbox",
                isSelected: _selectedIndex == 3,
                onTab: () => _onTab(3),
              ),
              NavTab(
                selectedIcon: FontAwesomeIcons.solidUser,
                icon: FontAwesomeIcons.user,
                label: "Profile",
                isSelected: _selectedIndex == 4,
                onTab: () => _onTab(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
