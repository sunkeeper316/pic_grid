import 'package:flutter_test/flutter_test.dart';
import 'package:pic_grid/services/review_prompt_service.dart';
import 'package:pic_grid/sharedpreference/sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ReviewPromptService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('requests a review only after saves 1, 5, and 10', () async {
      final requestedAt = <int>[];

      for (var save = 1; save <= 12; save++) {
        await ReviewPromptService.recordSuccessfulOperation(
          isReviewAvailable: () async => true,
          requestReview: () async => requestedAt.add(save),
        );
      }

      expect(requestedAt, [1, 5, 10]);
      expect(await SharedPreference.loadReviewCompletedOperationCount(), 10);
    });

    test('still records a save when native review is unavailable', () async {
      await ReviewPromptService.recordSuccessfulOperation(
        isReviewAvailable: () async => false,
        requestReview: () async => fail('requestReview should not be called'),
      );

      expect(await SharedPreference.loadReviewCompletedOperationCount(), 1);
    });
  });
}
