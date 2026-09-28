import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/exception_messages.dart';
import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/list_exception.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_exception.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/paging_exception.dart';
import 'package:myeshop/modules/root/data/model/base_response.dart';
import 'package:myeshop/modules/root/data/model/paging.dart';

extension BaseResponseExt<T> on Future<BaseResponse<T>?> {
  Future<Result<T>> getBaseResponseData() async {
    try {
      BaseResponse? resp = await this;
      final data = resp?.data;
      if (data != null) {
        if (data is List<dynamic>) {
          final dataList = data;
          if (dataList.isEmpty) {
            return ResultError(error: EmptyListException("Data list is empty"));
          } else {
            return ResultSuccess(data: data as T);
          }
        } else if (data is Paging) {
          final total = data.total;
          if (total > 0) {
            return ResultSuccess(data: data.data);
          } else {
            return ResultError(
                error: EmptyPagingException("Data paging is empty"));
          }
        } else {
          debugPrint("Base Repository onResponse success: $data");
          return ResultSuccess(data: data);
        }
      } else {
        return ResultError(
            error: NetworkException(
          resp?.message,
        ));
      }
    } on DioException catch (ex) {
      debugPrint("Base Response getBaseResponseData DioException: $ex");
      var networkEx = _getErrorFromDio(ex);
      return ResultError(error: networkEx);
    } catch (ex) {
      debugPrint("Base Response getBaseResponseData ex: $ex");
      return ResultError(error: ex is Exception ? ex : Exception(ex));
    }
  }

  Future<Result<U>> getBaseResponseDataTransform<U>(
      {required U Function(T resp) onTransform,
      U? Function()? onResultNull}) async {
    try {
      BaseResponse<T>? resp = await this;
      final data = resp?.data;
      if (data != null) {
        if (data is List<dynamic>) {
          final dataList = data;
          if (dataList.isEmpty) {
            return ResultError(error: EmptyListException("Data list is empty"));
          } else {
            return ResultSuccess(data: onTransform(data));
          }
        } else if (data is Paging) {
          final total = data.total;
          if (total > 0) {
            return ResultSuccess(data: onTransform(data));
          } else {
            return ResultError(
                error: EmptyPagingException("Data paging is empty"));
          }
        } else {
          return ResultSuccess(data: onTransform(data));
        }
      } else {
        if (onResultNull != null) {
          if (resp?.code == 200) {
            return ResultSuccess(data: onResultNull());
          }
        }
        return ResultError(error: NetworkException(resp?.message));
      }
    } on DioException catch (ex) {
      debugPrint("Base Repository DioException Error: $ex");
      var networkEx = _getErrorFromDio(ex);
      return ResultError(error: networkEx);
    } catch (ex) {
      debugPrint("Base Repository Error: $ex");
      return ResultError(error: ex is Exception ? ex : Exception(ex));
    }
  }

  Future<Result<U>> getPagingResponseData<U>(
      Future<BaseResponse<Paging<T>>?> api,
      {required U Function(T resp) onTransform}) async {
    try {
      BaseResponse<Paging<T>>? resp = await api;
      final data = resp?.data;
      if (data != null) {
        final total = data.total;
        final dataPage = data.data;
        if (total > 0 && dataPage != null) {
          return ResultSuccess(data: onTransform(dataPage));
        } else {
          debugPrint("Masuk empty");
          return ResultError(error: EmptyPagingException("Paging is empty"));
        }
      } else {
        return ResultError(error: NetworkException(resp?.message));
      }
    } on DioException catch (ex) {
      debugPrint("Base Repository DioException catch $ex");
      var networkEx = _getErrorFromDio(ex);
      return ResultError(error: networkEx);
    } on Exception catch (ex) {
      debugPrint("Base Repository Exception catch $ex");
      return ResultError(error: ex);
    } catch (ex) {
      debugPrint(
          "Base Repository getPagingResponseData exception: ${ex.toString()}");
      return ResultError(error: Exception(ex));
    }
  }

  NetworkException _getErrorFromDio(DioException dio) {
    final code = dio.response?.statusCode;
    if (code != null && code.toString().startsWith("4") ||
        code.toString().startsWith("5")) {
      String? message = dio.getErrorMessage();
      debugPrint("Base Response Error _getErrorFromDio[$code]: $message");
      return NetworkException(message, code: code);
    }
    return NetworkException(null);
  }
}

extension ExDataIsEmpty on BaseResponse {
  void checkDataHasEmpty() {
    if (data == null || (data is List && (data as List).isEmpty)) {
      throw EmptyListException("Data is empty");
    }
  }
}
