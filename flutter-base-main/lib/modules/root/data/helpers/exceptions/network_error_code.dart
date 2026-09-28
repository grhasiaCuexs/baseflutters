class NetworkErrorCode {
  static const int internalServerError = 500;
  static const int requestTimeOut = 408;
  static const int unauthorized = 401;
  static const int preconditionFailed = 412;
  static const int badRequest = 400;
  static const int pageNotFound = 404;

  static List<int> listCode() => [internalServerError, requestTimeOut, unauthorized, preconditionFailed, pageNotFound, badRequest];
}
