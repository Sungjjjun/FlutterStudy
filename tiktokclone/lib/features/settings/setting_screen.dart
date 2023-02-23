import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/common/widgets/video_config/video_config.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notification = false;

  void _onNotificationChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              value: _notification,
              onChanged: (value) {
                VideoConfigData.of(context).toggleMuted();
              },
              title: const Text(
                "Auto Mute",
              ),
              subtitle: const Text(
                "Videos will be muted by default",
              ),
            ),
            SwitchListTile.adaptive(
              value: _notification,
              onChanged: _onNotificationChanged,
              title: const Text(
                "Enable Notification",
              ),
              subtitle: const Text(
                "They will be cute",
              ),
            ),
            CheckboxListTile(
              activeColor: Colors.black,
              value: _notification,
              onChanged: _onNotificationChanged,
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
                if (!mounted) return;
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
