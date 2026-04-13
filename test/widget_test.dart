// This is a basic Flutter widget test for the Task Manager app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/features/auth/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('Task Manager app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: TaskManagerApp(),
      ),
    );

    // Wait for the splash screen to load
    await tester.pumpAndSettle();

    // Verify that the splash screen is displayed
    expect(find.text('Task Manager'), findsOneWidget);
    expect(find.text('Organize your tasks efficiently'), findsOneWidget);
    expect(find.byIcon(Icons.task_alt), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Splash screen UI elements test', (WidgetTester tester) async {
    // Build just the splash screen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    // Verify splash screen elements
    expect(find.byIcon(Icons.task_alt), findsOneWidget);
    expect(find.text('Task Manager'), findsOneWidget);
    expect(find.text('Organize your tasks efficiently'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
