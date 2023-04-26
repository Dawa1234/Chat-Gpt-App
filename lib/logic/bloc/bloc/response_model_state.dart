part of 'response_model_bloc.dart';

class ResponseModelState extends Equatable {
  final ResponseModel? responseModel;
  const ResponseModelState({required this.responseModel});

  @override
  List<Object> get props => [responseModel!];
}

class ResponseModelInitial extends ResponseModelState {
  const ResponseModelInitial() : super(responseModel: null);
}
