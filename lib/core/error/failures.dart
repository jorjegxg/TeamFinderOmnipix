abstract class Failure<T> {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class NoDataFetched<T> extends Failure<T> {
  NoDataFetched({required String message}) : super(message);
}

class ServerFailure<T> extends Failure<T> {
  ServerFailure({
    required String message,
    required int statusCode,
  }) : super(message);
}

class FieldFailure<T> extends Failure<T> {
  FieldFailure({required String message}) : super(message);
}

class NetworkFailure<T> extends Failure<T> {
  NetworkFailure({required String message}) : super(message);
}

class EasyFailure<T> extends Failure<T> {
  EasyFailure({required String message}) : super(message);
}

class MediumFailure<T> extends Failure<T> {
  MediumFailure({required String message}) : super(message);
}

class HardFailure<T> extends Failure<T> {
  HardFailure({required String message}) : super(message);
}

class UnexpectedFailure<T> extends Failure<T> {
  UnexpectedFailure({required String message}) : super(message);
}

class CacheFailure<T> extends Failure<T> {
  CacheFailure({required String message}) : super(message);
}
