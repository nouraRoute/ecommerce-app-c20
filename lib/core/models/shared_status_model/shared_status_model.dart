import 'package:equatable/equatable.dart';

sealed class SharedStatusModel<T> extends Equatable {
  const SharedStatusModel();
}

class LoadingState<T> extends SharedStatusModel<T> {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends SharedStatusModel<T> {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ErrorState<T> extends SharedStatusModel<T> {
  final String errorMessage;

  const ErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
