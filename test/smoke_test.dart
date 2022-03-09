import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_1/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
  });
}
