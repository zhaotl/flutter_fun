class ViewState<T> {
  T? data;
  int? errorCode;
  String? errorMessage;

  ViewState({this.data, this.errorCode, this.errorMessage});

  bool isLoading() => this is ViewStateLoading;

  bool isEmpty() => this is ViewStateEmpty;

  bool isError() => this is ViewStateError;

  bool isFail() => this is ViewStateFailed;

  bool isSuccess() => this is ViewStateSuccess;
}

class ViewStateLoading extends ViewState {}

class ViewStateEmpty extends ViewState {}

class ViewStateError extends ViewState {
  ViewStateError({required super.errorCode, required super.errorMessage});
}

class ViewStateFailed extends ViewState {
  ViewStateFailed({required super.errorCode, required super.errorMessage});
}

class ViewStateSuccess<T> extends ViewState {
  ViewStateSuccess(T data) : super(data: data);
}
