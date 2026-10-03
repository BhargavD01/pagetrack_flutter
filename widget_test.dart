import 'package:flutter_test/flutter_test.dart';
import 'package:pagetrack/main.dart';

void main() {
  testWidgets('PageTrack starts', (tester) async {
    await tester.pumpWidget(const PageTrackApp());
    expect(find.text('PageTrack'), findsOneWidget);
  });
}
