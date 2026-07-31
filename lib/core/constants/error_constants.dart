/// 預定義的錯誤碼常量
class ErrorConstants {
  // 通用錯誤 (1000-1999)
  static const int errInvalidRequest = 1000; // 無效的請求
  static const int errInternalServer = 1001; // 內部服務器錯誤
  static const int errNotFound = 1002; // 資源未找到
  static const int errDuplicateEntry = 1003; // 重複數據
  static const int errValidationFailed = 1004; // 數據驗證失敗

  // 認證相關錯誤 (2000-2999)
  static const int errUnauthorized = 2000; // 未授權訪問
  static const int errTokenMissing = 2001; // 缺少令牌
  static const int errTokenInvalid = 2002; // 無效的令牌
  static const int errTokenExpired = 2003; // 令牌已過期
  static const int errUserNotFound = 2004; // 用戶不存在
  static const int errPermissionDenied = 2005; // 權限不足

  // 數據庫相關錯誤 (3000-3999)
  static const int errDatabaseConnection = 3000; // 數據庫連接錯誤
  static const int errDatabaseQuery = 3001; // 數據庫查詢錯誤
  static const int errDatabaseInsert = 3002; // 數據庫插入錯誤
  static const int errDatabaseUpdate = 3003; // 數據庫更新錯誤
  static const int errDatabaseDelete = 3004; // 數據庫刪除錯誤

  // 文件相關錯誤 (4000-4999)
  static const int errFileUpload = 4000; // 文件上傳錯誤
  static const int errFileSize = 4001; // 文件大小超限
  static const int errFileFormat = 4002; // 文件格式不支持

  // 消息相關錯誤 (5000-5999)
  static const int errMessageSend = 5000; // 消息發送失敗
  static const int errMessageRead = 5001; // 消息讀取失敗
  static const int errMessageDelete = 5002; // 消息刪除失敗

  // 外部服務相關錯誤 (6000-6999)
  static const int errFirebaseAuth = 6000; // Firebase認證錯誤
  static const int errThirdPartyAPI = 6001; // 第三方API調用錯誤

  static const int errInsufficientBalance = 7000; // T幣餘額不足

  static const int errAppVersionOutdated = 9000; // App 版本過舊

  static const int errServerUnavailable = 9999; // 伺服器目前無法使用

}

/// 獲取標準錯誤消息
String getErrorMessage(int code) {
  switch (code) {
// 通用錯誤
    case ErrorConstants.errInvalidRequest:
      return "無效的請求";
    case ErrorConstants.errInternalServer:
      return "內部服務器錯誤";
    case ErrorConstants.errNotFound:
      return "資源未找到";
    case ErrorConstants.errDuplicateEntry:
      return "數據已存在";
    case ErrorConstants.errValidationFailed:
      return "數據驗證失敗";

// 認證相關錯誤
    case ErrorConstants.errUnauthorized:
      return "未授權訪問";
    case ErrorConstants.errTokenMissing:
      return "缺少認證令牌";
    case ErrorConstants.errTokenInvalid:
      return "無效的認證令牌";
    case ErrorConstants.errTokenExpired:
      return "認證令牌已過期";
    case ErrorConstants.errUserNotFound:
      return "用戶不存在";
    case ErrorConstants.errPermissionDenied:
      return "權限不足";

// 數據庫相關錯誤
    case ErrorConstants.errDatabaseConnection:
      return "數據庫連接錯誤";
    case ErrorConstants.errDatabaseQuery:
      return "數據庫查詢錯誤";
    case ErrorConstants.errDatabaseInsert:
      return "數據庫插入錯誤";
    case ErrorConstants.errDatabaseUpdate:
      return "數據庫更新錯誤";
    case ErrorConstants.errDatabaseDelete:
      return "數據庫刪除錯誤";

// 文件相關錯誤
    case ErrorConstants.errFileUpload:
      return "文件上傳錯誤";
    case ErrorConstants.errFileSize:
      return "文件大小超限";
    case ErrorConstants.errFileFormat:
      return "文件格式不支持";

// 消息相關錯誤
    case ErrorConstants.errMessageSend:
      return "消息發送失敗";
    case ErrorConstants.errMessageRead:
      return "消息讀取失敗";
    case ErrorConstants.errMessageDelete:
      return "消息刪除失敗";

// 外部服務相關錯誤
    case ErrorConstants.errFirebaseAuth:
      return "Firebase認證錯誤";
    case ErrorConstants.errThirdPartyAPI:
      return "第三方服務調用錯誤";
    case ErrorConstants.errAppVersionOutdated:
      return "App 版本過舊";

// 默認錯誤消息
    default:
      return "未知錯誤";
  }
}
