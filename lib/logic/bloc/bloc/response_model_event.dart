part of 'response_model_bloc.dart';

abstract class ResponseModelEvent extends Equatable {
  const ResponseModelEvent();

  @override
  List<Object> get props => [];
}

class SuccessResponse extends ResponseModelEvent {
  final String userInput;
  const SuccessResponse({required this.userInput});
  @override
  List<Object> get props => [userInput];
}

class FailedResponse extends ResponseModelEvent {}
