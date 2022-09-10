import 'package:core/core.dart' show aboutDescriptionText;
import 'package:ditonton_apps/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Description app text should display',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(const AboutPage()));

    expect(find.text(aboutDescriptionText), findsOneWidget);
  });
}
