import 'package:myeshop/modules/root/data/helpers/exceptions/empty_exception.dart';

class ListException implements Exception {
  final String? message;

  ListException(this.message);

  @override
  String toString() {
    return 'Data List Exception: $message';
  }
}

class EmptyListException extends ListException implements IEmptyException {
  EmptyListException(super.message);
}