import 'package:dio/dio.dart';

class ErrorResponse {
  // From API
  bool isSuccess;
  // For local handel
  int errorCode;

  ErrorResponse({
    this.isSuccess,
    this.errorCode,
  });

  factory ErrorResponse.fromException(ex) {

    int errorCode = 500;

    if (ex is DioError) {

      switch (ex.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          errorCode = 408;
          break;
        case DioErrorType.RESPONSE:
          if (ex.response != null)
            errorCode = ex.response.statusCode;
          else
            errorCode = 500;
          break;
        case DioErrorType.CANCEL:
          errorCode = 499;
          break;
        case DioErrorType.DEFAULT:
          errorCode = 500;
          break;
        case DioErrorType.RESPONSE:
          errorCode = 401;
          break;
      }
    }

    return ErrorResponse(    );
  }
}
