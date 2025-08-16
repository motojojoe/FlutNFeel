import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutnfeel/widgets/app_header.dart';
import 'package:flutnfeel/pages/search_page.dart';
import 'package:flutnfeel/pages/chat_page.dart';

void main() {
  group('AppHeader Widget Tests', () {
    testWidgets('renders header with logo, search bar, and chat button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppHeader(),
          ),
        ),
      );

      // Check if the header elements are present
      expect(find.text('FlutNFeel'), findsOneWidget);
      expect(find.text('Search for apps...'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
      expect(find.byIcon(Icons.flutter_dash), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('header elements have proper accessibility labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppHeader(),
          ),
        ),
      );

      // Check accessibility semantics
      expect(find.bySemanticsLabel('Logo'), findsOneWidget);
      expect(find.bySemanticsLabel('Search Bar'), findsOneWidget);
      expect(find.bySemanticsLabel('Chat'), findsOneWidget);
    });

    testWidgets('tapping search bar navigates to search page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: AppHeader(),
          ),
          routes: {
            '/search': (context) => const SearchPage(),
          },
        ),
      );

      // Tap on the search bar
      await tester.tap(find.bySemanticsLabel('Search Bar'));
      await tester.pumpAndSettle();

      // Verify navigation to search page
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Search for apps...'), findsAtLeastNWidgets(1));
    });

    testWidgets('tapping chat button navigates to chat page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: AppHeader(),
          ),
          routes: {
            '/chat': (context) => const ChatPage(),
          },
        ),
      );

      // Tap on the chat button
      await tester.tap(find.bySemanticsLabel('Chat'));
      await tester.pumpAndSettle();

      // Verify navigation to chat page
      expect(find.text('Chat'), findsOneWidget);
      expect(find.text('Chat Feature'), findsOneWidget);
    });

    testWidgets('header elements have minimum tap target size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppHeader(),
          ),
        ),
      );

      // Check minimum tap target sizes (44x44 as per accessibility guidelines)
      final logoWidget = tester.widget<Container>(
        find.descendant(
          of: find.bySemanticsLabel('Logo'),
          matching: find.byType(Container),
        ).first,
      );
      expect(logoWidget.constraints?.minWidth, greaterThanOrEqualTo(44));
      expect(logoWidget.constraints?.minHeight, greaterThanOrEqualTo(44));

      final searchWidget = tester.widget<Container>(
        find.descendant(
          of: find.bySemanticsLabel('Search Bar'),
          matching: find.byType(Container),
        ).first,
      );
      expect(searchWidget.constraints?.minHeight, greaterThanOrEqualTo(44));

      final chatWidget = tester.widget<Container>(
        find.descendant(
          of: find.bySemanticsLabel('Chat'),
          matching: find.byType(Container),
        ).first,
      );
      expect(chatWidget.constraints?.minWidth, greaterThanOrEqualTo(44));
      expect(chatWidget.constraints?.minHeight, greaterThanOrEqualTo(44));
    });

    testWidgets('header is responsive and does not overflow on narrow screens', (WidgetTester tester) async {
      // Test with narrow screen size
      await tester.binding.setSurfaceSize(const Size(320, 568)); // iPhone SE size
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppHeader(),
          ),
        ),
      );

      // Check that all elements are still visible and no overflow occurs
      expect(find.text('FlutNFeel'), findsOneWidget);
      expect(find.text('Search for apps...'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
      
      // Verify no overflow by checking if all widgets are rendered
      expect(tester.takeException(), isNull);
      
      // Reset to default size
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('logo tap shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppHeader(),
          ),
        ),
      );

      // Tap on the logo
      await tester.tap(find.bySemanticsLabel('Logo'));
      await tester.pump();

      // Verify snackbar appears
      expect(find.text('FlutNFeel Store'), findsOneWidget);
    });
  });
}