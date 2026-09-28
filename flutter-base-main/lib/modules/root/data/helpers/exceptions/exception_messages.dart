import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:myeshop/helpers/localization_extension.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/empty_exception.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_error_code.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_exception.dart';
import 'package:myeshop/modules/root/data/model/base_response.dart';

extension ExceptionMessageExt on Exception? {
  String getMessage(BuildContext context) {
    if (this is IEmptyException) {
      return context.getAppLocalizations().empty_data;
    } else if (this is NetworkException) {
      final networkException = (this as NetworkException);
      if (networkException.message != null) {
        switch (networkException.code) {
          case NetworkErrorCode.internalServerError:
            return context.getAppLocalizations().server_error_message;
          case NetworkErrorCode.requestTimeOut:
            return context.getAppLocalizations().network_error_message;
          case NetworkErrorCode.unauthorized:
            return context.getAppLocalizations().unauthorized_error_message;
          case NetworkErrorCode.badRequest:
            return networkException.message ??
                context.getAppLocalizations().bad_request_message;
          case NetworkErrorCode.pageNotFound:
            return networkException.message ??
                context.getAppLocalizations().page_not_found_message;
        }
        return networkException.message ?? toString();
      } else {
        return context.getAppLocalizations().network_error_message;
      }
    }
    return context.getAppLocalizations().base_error_message;
  }
}

extension ErrorCatch on Exception {
  String? getErrorMessage() {
    String? message = toString();
    if (this is DioException) {
      DioException dioException = this as DioException;
      if (dioException.response != null) {
        if (dioException.response?.data is Map<String, dynamic>) {
          BaseResponse<dynamic> baseResponse = BaseResponse.fromJson(
              dioException.response?.data, (json) => null);
          message = baseResponse.message.toString();
        } else {
          message = dioException.response.toString();
        }
      } else {
        message = dioException.message.toString();
      }
    }

    return message;
  }
}
