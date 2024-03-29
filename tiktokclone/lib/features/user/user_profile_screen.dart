import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/settings/setting_screen.dart';
import 'package:tiktokclone/features/user/persistent_tab_bar.dart';
import 'package:tiktokclone/features/user/view_models/user_view_model.dart';
import 'package:tiktokclone/features/videos/views/widgets/avatar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onSettingTab(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: () => _onSettingTab(context),
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v32,
                            Avatar(
                              uid: data.uid,
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "@${data.email}",
                                  style: const TextStyle(
                                    fontSize: Sizes.size18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Gaps.h5,
                                const FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: Colors.lightBlue,
                                  size: Sizes.size16,
                                ),
                              ],
                            ),
                            Gaps.v24,
                            SizedBox(
                              height: Sizes.size48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "37",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: 1,
                                    color: Colors.grey.shade400,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "10M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: 1,
                                    color: Colors.grey.shade400,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "194.3M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Likes",
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FractionallySizedBox(
                                    widthFactor: 1.0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size20,
                                        vertical: Sizes.size12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            Sizes.size4,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Follow",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Sizes.size18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.h5,
                                Flexible(
                                  child: FractionallySizedBox(
                                    widthFactor: 0.4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size10,
                                        vertical: Sizes.size10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            Sizes.size4,
                                          ),
                                        ),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: FaIcon(
                                          FontAwesomeIcons.youtube,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.h5,
                                Flexible(
                                  child: FractionallySizedBox(
                                    widthFactor: 0.4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size8,
                                        vertical: Sizes.size10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            Sizes.size4,
                                          ),
                                        ),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: FaIcon(
                                          FontAwesomeIcons.arrowDown,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size32,
                              ),
                              child: Text(
                                "Hello my name is Sungjjjun Parky!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h5,
                                Text(
                                  "https://github.com/Sungjjjun",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v5,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: PersistentTabBar(),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 14,
                        ),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 9 / 14,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: "assets/images/placeholder.png",
                                image:
                                    "https://images.unsplash.com/photo-1666025067647-da80f0385da4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                              ),
                            ),
                            Positioned(
                              left: Sizes.size10,
                              bottom: Sizes.size5,
                              child: Row(
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.play,
                                    size: Sizes.size16,
                                    color: Colors.white,
                                  ),
                                  Gaps.h5,
                                  Text(
                                    "4.1M",
                                    style: TextStyle(
                                      fontSize: Sizes.size16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("Page 2"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
