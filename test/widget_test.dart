import 'package:flutter_test/flutter_test.dart';

import 'package:datadraft/main.dart';

void main() {
  testWidgets('App renders first section', (WidgetTester tester) async {
    await tester.pumpWidget(const DataDraftApp());

    expect(find.text('DataDraft'), findsOneWidget);
    expect(find.text('Personal Details'), findsWidgets);
    expect(find.text('Step 1 of 10 · Personal Details'), findsWidgets);
  });
}
