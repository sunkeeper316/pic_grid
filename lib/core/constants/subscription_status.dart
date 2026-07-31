class SubscriptionStatus {
  static const int active = 1;
  // ✅ 有效訂閱中：用戶訂閱處於活躍狀態，具備完整 VIP 權限。

  static const int canceled = 2;
  // ❗️已取消續訂但尚未到期：用戶手動取消續訂，仍在有效期內，權限不受影響。

  static const int expired = 3;
  // ⛔️已過期：訂閱已到期，未續訂，權限已失效。

  static const int onHold = 4;
  // ⏸ 系統保留：付款失敗或其他問題導致帳戶暫時保留，無權限。

  static const int gracePeriod = 5;
  // 🕒 寬限期中：付款失敗但 Google 提供短暫寬限期，權限仍保留。

  static const int paused = 6;
  // ⏹ 用戶主動暫停訂閱：暫停期間無權限，待恢復續訂。

  static const int pendingVerification = 7;
  // 🕵️ 待驗證狀態：App 已送出訂閱請求，但尚未完成 Google Play 驗證。

  static const int unknown = 8;
  // ❓ 狀態不明：無法判斷目前狀態，通常需打 API 補查確認。

  static const int revoked = 9;
  // ❌ 被撤銷或退款：訂閱遭官方或管理員撤銷，立即失效，無法恢復。

  static const int adminActive = 99;
  // ✅ 後台被手動設定成 VIP。
}

// Status	名稱	說明	權限有無	是否可以按「訂閱」按鈕？
// 1	Active	有效訂閱中	✅ 有VIP權限	❌ 不該出現訂閱按鈕
// 2	Canceled	取消續訂但還沒到期	✅ 仍有VIP權限	❌ 不該出現訂閱按鈕
// 3	Expired	訂閱已過期	❌ 無VIP權限	✅ 可以出現訂閱按鈕
// 5	Grace Period	付款失敗寬限期內	✅ 有VIP權限	❌ 不該出現訂閱按鈕
// 7	Pending Verification	等待驗證中	✅ 視同有效	❌ 不該出現訂閱按鈕
// 8	Unknown	狀態不明	✅ 保守假設有權限	❌ 不該出現訂閱按鈕
// 9	Revoked	被撤銷/退款	❌ 沒有VIP權限	✅ 可以出現訂閱按鈕
// 99	adminActive ✅ 後台被手動設定成 VIP。