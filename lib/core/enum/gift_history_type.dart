enum GiftHistoryType {
  received,
  sent,
}
extension GiftHistoryTypeExtension on GiftHistoryType {
  String get value {
    switch (this) {
      case GiftHistoryType.received:
        return 'received';
      case GiftHistoryType.sent:
        return 'sent';
    }
  }
}
