enum AuthStatus {
  success,      // 0: 正常
  firstLogin,   // 1: 首次註冊流程
  suspended,    // 9: 停權
  unknown       // 其他未知狀態
}

AuthStatus handleAuthStatus(int status) {
  switch (status) {
    case 0:
      return AuthStatus.success;
    case 1:
      return AuthStatus.firstLogin;
    case 9:
      return AuthStatus.suspended;
    default:
      return AuthStatus.unknown;
  }
}