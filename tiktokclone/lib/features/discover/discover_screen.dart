import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/breakpoint.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController(
    text: "Initial Text",
  );

  @override
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSumitted(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          leading: const Center(
            child: FaIcon(
              FontAwesomeIcons.arrowLeft,
            ),
          ),
          title: Container(
            constraints: const BoxConstraints(
              maxWidth: BreakPoint.sm,
            ),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSumitted,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.sliders,
              ),
            ),
          ],
          bottom: TabBar(
            onTap: (context) => _onTap,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.grey,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size6,
                horizontal: Sizes.size6,
              ),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > BreakPoint.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/placeholder.png",
                          image:
                              "https://images.unsplash.com/photo-1666025067647-da80f0385da4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                        ),
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      "${constraints.maxWidth}This is very long caption for my tiktok that im upload just now currently",
                      style: const TextStyle(
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Gaps.v5,
                    if (constraints.maxWidth < 200 ||
                        constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              child: Image.network(
                                "https://avatars.githubusercontent.com/u/103017099?v=4",
                              ),
                            ),
                            Gaps.h5,
                            const Expanded(
                              child: Text(
                                "Sungjjjunnnnnnnnnnnn",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size14,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h3,
                            const Text(
                              "2.0M",
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size52,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
