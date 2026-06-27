import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('FinPilot AI renders dashboard and navigation', (tester) async {
    await tester.pumpWidget(const FinPilotApp());

    expect(find.text('Good Morning Ahmed'), findsOneWidget);
    expect(find.text('Total Balance'), findsOneWidget);

    await tester.drag(find.byType(Scrollable).first, const Offset(0, -250));
    await tester.pumpAndSettle();

    expect(find.text('Weekly savings'), findsOneWidget);

    await tester.tap(find.text('Budget'));
    await tester.pumpAndSettle();

    expect(find.text('Plan Every Dollar'), findsOneWidget);
    expect(find.text('Category Budgets'), findsOneWidget);
  });
}
