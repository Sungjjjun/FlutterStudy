import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktokclone/common/widgets/video_config/video_config.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/videos/repos/playback_config_repo.dart';
import 'package:tiktokclone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktokclone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepo(preferences);

  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider.overrideWith(
          () => PlaybackConfigVM(repository),
        ),
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: theme,
      builder: (context, value, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'TikTok Clone',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en"),
          Locale("ko"),
          Locale("es"),
        ],
        themeMode: value,
        //LightMode Theme
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          textTheme: Typography.blackMountainView,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.grey,
          ),
        ),
        //DarkMode Theme
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: Typography.whiteMountainView,
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade900,
            surfaceTintColor: Colors.grey.shade900,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE9435A),
          brightness: Brightness.dark,
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade700,
            indicatorColor: Colors.white,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
        ),
      ),
    );
  }
}
