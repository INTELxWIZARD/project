import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:appf/main.dart';

void main() {
  testWidgets('Add vehicle page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AddVehicleApp());

    // Verify that the app has the correct title.
    expect(find.text('Add a vehicle'), findsOneWidget);

    // Verify the presence of vehicle details section.
    expect(find.text('vehicle details'), findsOneWidget);
    expect(find.text('add your vehicle details below'), findsOneWidget);

    // Verify the presence of text fields.
    expect(find.byType(TextField), findsNWidgets(3)); // 3 input fields

    // Verify that the "Continue" button exists.
    expect(find.text('Continue'), findsOneWidget);

    // Simulate entering text into the input fields.
    await tester.enterText(find.byType(TextField).at(0), 'Car');
    await tester.enterText(find.byType(TextField).at(1), 'KA-01-1234');
    await tester.enterText(find.byType(TextField).at(2), 'SUV');

    // Verify the input values.
    expect(find.text('Car'), findsOneWidget);
    expect(find.text('KA-01-1234'), findsOneWidget);
    expect(find.text('SUV'), findsOneWidget);

    // Tap the "Continue" button and trigger a frame.
    await tester.tap(find.text('Continue'));
    await tester.pump();

    // Optionally, verify any behavior upon tapping "Continue" (e.g., navigation, API call).
    // Currently, no navigation or additional behavior is defined, so there's nothing further to test here.
  });
}
