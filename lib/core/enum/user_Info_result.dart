// 定義使用者狀態結果的 enum
enum UserInfoResult {
  success,              // 成功獲取用戶資料
  registration,         // 需要進行註冊流程1
  createFirstPost,      // 需要創建第一篇文章
  suspended,            // 帳號被停權
  deleted,              // 帳號被刪除
  abnormalState,        // 異常狀態
  fetchError,           // 獲取數據時出錯
}

