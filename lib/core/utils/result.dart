import '../errors/failures.dart';

abstract class Result<T> {
  const Result();
  
  bool get isSuccess;
  bool get isFailure;
  
  T get data;
  Failure get failure;
  
  factory Result.success(T data) = Success<T>;
  factory Result.failure(Failure failure) = FailureResult<T>;
  
  R fold<R>(R Function(T data) onSuccess, R Function(Failure failure) onFailure);
}

class Success<T> extends Result<T> {
  final T _data;
  
  const Success(this._data);
  
  @override
  bool get isSuccess => true;
  
  @override
  bool get isFailure => false;
  
  @override
  T get data => _data;
  
  @override
  Failure get failure => throw UnimplementedError();
  
  @override
  R fold<R>(R Function(T data) onSuccess, R Function(Failure failure) onFailure) {
    return onSuccess(_data);
  }
}

class FailureResult<T> extends Result<T> {
  final Failure _failure;
  
  const FailureResult(this._failure);
  
  @override
  bool get isSuccess => false;
  
  @override
  bool get isFailure => true;
  
  @override
  T get data => throw UnimplementedError();
  
  @override
  Failure get failure => _failure;
  
  @override
  R fold<R>(R Function(T data) onSuccess, R Function(Failure failure) onFailure) {
    return onFailure(_failure);
  }
}
