class EmptyException implements Exception, IEmptyException {
  final String? message;

  EmptyException([this.message]);

  @override
  String toString() {
    return 'Data is empty: $message';
  }
}

abstract class IEmptyException {}