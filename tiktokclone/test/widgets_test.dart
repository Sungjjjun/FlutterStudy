import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktokclone/features/authentication/widgets/form_button.dart';

void main() {
  group("Form Button Test", () {
    testWidgets("Enabled State", (WidgetTester tester) async {
      await tester.pumpWidget(const Directionality(
        textDirection: TextDirection.ltr,
        child: FormButton(diabled: false),
      ));
    });
  });
}
