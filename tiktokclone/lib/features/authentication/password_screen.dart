import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/features/authentication/birthday_screen.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obsecureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordLengthValid() {
    return _password.length >= 8 && _password.length <= 20;
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _isPasswordLengthValid();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTab() {
    _passwordController.clear();
  }

  void _onObsecureTab() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Sign up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v14,
              TextField(
                onEditingComplete: _onSubmit,
                obscureText: _obsecureText,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTab,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _onObsecureTab,
                        child: FaIcon(
                          _obsecureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: 'Make it strong!',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text(
                'Your password must have:',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    _isPasswordLengthValid()
                        ? FontAwesomeIcons.circleCheck
                        : FontAwesomeIcons.circleXmark,
                    color: _isPasswordLengthValid() ? Colors.green : Colors.red,
                    size: Sizes.size20,
                  ),
                  Gaps.h5,
                  const Text(
                    '8 to 20 characters',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                  )
                ],
              ),
              Gaps.v14,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  diabled: !_isPasswordValid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
