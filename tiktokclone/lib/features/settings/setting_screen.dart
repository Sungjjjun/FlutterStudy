import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclone/common/widgets/video_config/video_config.dart';
import 'package:tiktokclone/features/videos/view_models/playback_config_vm.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) => {
                ref.read(playbackConfigProvider.notifier).setMuted(value),
              },
              title: const Text(
                "Auto muted",
              ),
              subtitle: const Text(
                "Video is muted",
              ),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoPlay,
              onChanged: (value) => {
                ref.read(playbackConfigProvider.notifier).setAutoplay(value),
              },
              title: const Text(
                "Auto play",
              ),
              subtitle: const Text(
                "Video will be played in auto",
              ),
            ),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: theme,
              builder: (context, value, child) => SwitchListTile.adaptive(
                value: value == ThemeMode.dark,
                onChanged: (value) {
                  if (theme.value == ThemeMode.light) {
                    theme.value = ThemeMode.dark;
                  } else {
                    theme.value = ThemeMode.light;
                  }
                },
                title: const Text(
                  "Dark Mode",
                ),
                subtitle: const Text(
                  "You can set your application in dark mode.",
                ),
              ),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) => {},
              title: const Text(
                "Enable Notification",
              ),
              subtitle: const Text(
                "They will be cute",
              ),
            ),
            CheckboxListTile(
              activeColor: Colors.black,
              value: false,
              onChanged: (value) => {},
              title: const Text(
                "Enable Notification",
              ),
              subtitle: const Text(
                "We won't spam you.",
              ),
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        appBarTheme: const AppBarTheme(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text(
                "What is your birthday",
              ),
              subtitle: const Text(
                "I need to kvow!",
              ),
            ),
            ListTile(
              title: const Text(
                "Log out (ios)",
              ),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text(
                      "Are you sure?",
                    ),
                    content: const Text(
                      "Please don't go",
                    ),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Log out (Android)",
              ),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      "Are you sure?",
                    ),
                    content: const Text(
                      "Please don't go",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Log out (iOS / Bottom)",
              ),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    message: const Text("Pliz Don't go!!"),
                    title: const Text(
                      "Are you sure?",
                    ),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(),
          ],
        ),
      ),
    );
  }
}
