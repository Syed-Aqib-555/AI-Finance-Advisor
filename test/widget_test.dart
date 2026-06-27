import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('creates account and tracks user cash flow', (tester) async {
    await tester.pumpWidget(const FinPilotApp());

    expect(find.text('FinPilot Finance'), findsOneWidget);
    expect(find.text('Create your account'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('passwordField')), '1234');
    await tester.tap(find.byKey(const Key('createAccountButton')));
    await tester.pumpAndSettle();

    expect(find.text('Good Morning Ahmed'), findsOneWidget);
    expect(find.text('Total Balance'), findsOneWidget);
    expect(find.text('Incoming Cash'), findsOneWidget);
    expect(find.text('Outgoing Cash'), findsOneWidget);

    await tester.tap(find.text('Transactions'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('transactionTitleField')),
      'Groceries',
    );
    await tester.enterText(
      find.byKey(const Key('transactionAmountField')),
      '2500',
    );
    await tester.tap(find.byKey(const Key('saveTransactionButton')));
    await tester.pumpAndSettle();

    expect(find.text('Groceries'), findsOneWidget);

    await tester.tap(find.text('Cash Flow'));
    await tester.pumpAndSettle();

    expect(find.text('Where Money Moves'), findsOneWidget);
    expect(find.text('Where money went'), findsOneWidget);
    expect(find.text('Food'), findsWidgets);
  });
}
