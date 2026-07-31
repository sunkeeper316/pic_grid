
enum MeetupReviewEmoji {
  none('', 0),
  angry('👍', 1),
  thinking('❤️', 2),
  melting('😫', 3),
  heart('🤔', 4),
  thumbsUp('😡', 5);

  final String emoji;
  final int value;
  const MeetupReviewEmoji(this.emoji, this.value);
}
