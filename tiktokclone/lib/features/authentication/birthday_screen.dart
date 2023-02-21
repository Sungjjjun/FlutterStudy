import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../onboarding/interests_screen.dart';
import 'widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTab() {
    context.pushReplacementNamed(InterestsScreen.routeName);
  }

  void _setTextFieldDate(DateTime date) {
    final textdate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textdate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "When's your birthday?",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "Your birthday won't be shown publicly",
                style: TextStyle(
                  fontSize: Sizes.size14,
                ),
              ),
              Gaps.v14,
              TextField(
                enabled: false,
                controller: _birthdayController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v14,
              GestureDetector(
                onTap: _onNextTab,
                child: const FormButton(
                  diabled: false,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              maximumDate: initialDate,
              initialDateTime: initialDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: _setTextFieldDate,
            ),
          ),
        ),
      ),
    );
  }
}
