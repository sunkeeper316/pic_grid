import 'package:in_app_review/in_app_review.dart';
import 'package:pic_grid/sharedpreference/sharedpreferences.dart';

/// Records successful photo saves and requests a native store review after
/// saves 1, 5, and 10. No more saves are counted after the final milestone.
class ReviewPromptService {
  static const Set<int> _reviewMilestones = {1, 5, 10};

  static bool _isRecording = false;

  static Future<void> recordSuccessfulOperation({
    Future<bool> Function()? isReviewAvailable,
    Future<void> Function()? requestReview,
  }) async {
    if (_isRecording) return;
    _isRecording = true;

    try {
      final currentCount =
          await SharedPreference.loadReviewCompletedOperationCount();
      if (currentCount >= 10) return;

      final nextCount = currentCount + 1;
      await SharedPreference.saveReviewCompletedOperationCount(nextCount);

      if (!_reviewMilestones.contains(nextCount)) return;

      final review = InAppReview.instance;
      final available = await (isReviewAvailable ?? review.isAvailable)();
      if (available) {
        await (requestReview ?? review.requestReview)();
      }
    } catch (_) {
      // Review prompting is optional and must never turn a successful save
      // into an error shown to the user.
    } finally {
      _isRecording = false;
    }
  }
}
