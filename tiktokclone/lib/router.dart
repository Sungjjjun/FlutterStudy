import 'package:go_router/go_router.dart';
import 'package:tiktokclone/features/authentication/email_screen.dart';
import 'package:tiktokclone/features/authentication/sign_up_screen.dart';
import 'package:tiktokclone/features/authentication/username_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeURL,
      name: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: UsernameScreen.routeURL,
          name: UsernameScreen.routeName,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              path: EmailScreen.routeURL,
              name: EmailScreen.routeName,
              builder: (context, state) {
                final arg = state.extra as EmailScreenArgs;
                return EmailScreen(username: arg.username);
              },
            ),
          ],
          // pageBuilder: (context, state) {
          //   return CustomTransitionPage(
          //     child: const UsernameScreen(),
          //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //       return FadeTransition(
          //         opacity: animation,
          //         child: ScaleTransition(
          //           scale: animation,
          //           child: child,
          //         ),
          //       );
          //     },
          //   );
          // },
        ),
      ],
    ),
    // GoRoute(
    //   path: LoginScreen.routeName,
    //   builder: (context, state) => const LoginScreen(),
    // ),
    // GoRoute(
    //   path: "/users/:username",
    //   builder: (context, state) {
    //     final username = state.params["username"];
    //     final tab = state.queryParams["show"];
    //     return UserProfileScreen(username: username!, tab: tab!);
    //   },
    // ),
  ],
);
