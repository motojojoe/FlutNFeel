// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutnfeel/main.dart';

void main() {
  testWidgets('App shows homepage with cached images', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar title is shown
    expect(find.text('Today'), findsOneWidget);

    // Verify that some of the item categories are shown
    expect(find.text('ENTERTAINMENT'), findsOneWidget);
    expect(find.text('HEALTH & FITNESS'), findsOneWidget);

    // Verify that item titles are shown
    expect(find.text('Music Player'), findsOneWidget);
    expect(find.text('Fitness Plus'), findsOneWidget);
  });
}
