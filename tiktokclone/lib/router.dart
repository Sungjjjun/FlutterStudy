import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclone/common/widgets/mainnavigation/main_navigation_screen.dart';
import 'package:tiktokclone/features/authentication/login_screen.dart';
import 'package:tiktokclone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokclone/features/authentication/sign_up_screen.dart';
import 'package:tiktokclone/features/indox/activity_screen.dart';
import 'package:tiktokclone/features/indox/chats_detail_screen.dart';
import 'package:tiktokclone/features/indox/chats_screen.dart';
import 'package:tiktokclone/features/onboarding/interests_screen.dart';
import 'package:tiktokclone/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider(
  (ref) {
    // ref.watch(authState);
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: InterestsScreen.routeName,
          path: InterestsScreen.routeURL,
          builder: (context, state) => const InterestsScreen(),
        ),
        GoRoute(
          name: MainNavigationScreen.routeName,
          path: "/:tab(home|discover|inbox|profile)",
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
        ),
        GoRoute(
          name: ActivityScreen.routeName,
          path: ActivityScreen.routeURL,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          name: ChatsScreen.routeName,
          path: ChatsScreen.routeURL,
          builder: (context, state) => const ChatsScreen(),
          routes: [
            GoRoute(
              name: ChatsDetailScreen.routeName,
              path: ChatsDetailScreen.routeURL,
              builder: (context, state) {
                final chatId = state.params["chatId"]!;
                return ChatsDetailScreen(chatId: chatId);
              },
            ),
          ],
        ),
        GoRoute(
          name: VideoRecordingScreen.routeName,
          path: VideoRecordingScreen.routeURL,
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(
              microseconds: 200,
            ),
            child: const VideoRecordingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position =
                  Tween(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  },
);
