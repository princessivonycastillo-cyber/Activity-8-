import 'package:flutter_test/flutter_test.dart';
import 'package:semester_project/app.dart';

void main() {
  testWidgets('Home screen shows BrewHaven buttons', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Open Login'), findsOneWidget);
    expect(find.text('Report an Issue'), findsOneWidget);
  });
}
