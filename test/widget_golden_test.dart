import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_example/main.dart'; // Replace 'myapp' with your actual app name

void main() {
  group('Golden Tests', () {
    testWidgets('MyHomePage golden test', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(const MyApp());
      
      // Wait for any animations to complete
      await tester.pumpAndSettle();
      
      // Compare against golden file
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile('goldens/home_page.png'),
      );
    });

    testWidgets('MyHomePage after tap golden test', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Tap the increment button a few times
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.add));
      
      await tester.pumpAndSettle();
      
      // Test the state after interactions
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile('goldens/home_page_after_taps.png'),
      );
    });
  });
}
