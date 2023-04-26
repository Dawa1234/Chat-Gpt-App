part of 'loading_cubit.dart';

class LoadingState extends Equatable {
  bool isLoading;
  LoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class LoadingInitial extends LoadingState {
  LoadingInitial() : super(isLoading: false);
}

class IsLoading extends LoadingState {
  IsLoading() : super(isLoading: true);
}

class NotLoading extends LoadingState {
  NotLoading() : super(isLoading: false);
}
