import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokclone/features/onboarding/interests_screen.dart';
import 'package:tiktokclone/features/user/view_models/user_view_model.dart';
import 'package:tiktokclone/utils.dart';

class SignUpVM extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUp(
        form["email"],
        form["password"],
      );
      await users.createProfile(userCredential);
    });
    if (state.hasError) {
      showFirebaseErrorStack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignUpVM, void>(
  () => SignUpVM(),
);
