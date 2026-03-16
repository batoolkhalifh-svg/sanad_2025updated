// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. You can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanad_2025/main.dart';

void main() {
  testWidgets('App launches and displays MaterialApp', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const EntryPoint());

    // Verify that MaterialApp is present.
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verify that the app title is correct.
    final titleFinder = find.text('سند');
    expect(titleFinder, findsOneWidget);
  });
}
