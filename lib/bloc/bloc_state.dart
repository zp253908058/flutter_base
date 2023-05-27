import 'package:equatable/equatable.dart';

abstract class DataState<T> extends Equatable {
  final T? data;
  final Object? error;

  const DataState({this.data, this.error});

  bool get hasData => data != null;

  bool get hasError => error != null;

  @override
  List<Object?> get props => [data, error];

  @override
  bool get stringify => true;
}
