import 'package:myeshop/modules/root/data/helpers/exceptions/empty_exception.dart';

class PagingException implements Exception {
  final String? message;

  PagingException([this.message]);

  @override
  String toString() {
    return 'Data Paging Exception: $message';
  }
}

class EmptyPagingException extends PagingException implements IEmptyException {
  EmptyPagingException([super.message]);
}
