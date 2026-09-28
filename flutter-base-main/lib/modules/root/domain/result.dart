class Result<T> {
  final Exception? error;
  final T? data;

  Result({this.data, this.error});
}

class ResultSuccess<T> extends Result<T> {
  ResultSuccess({super.data});
}

class ResultError<T> extends Result<T> {
  ResultError({super.error});
}