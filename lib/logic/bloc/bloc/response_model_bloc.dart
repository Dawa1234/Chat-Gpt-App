import 'package:chatgpt/data/models/response.dart';
import 'package:chatgpt/data/repository/gptRepo.dart';
import 'package:chatgpt/logic/bloc_exports.dart';

part 'response_model_event.dart';
part 'response_model_state.dart';

class ResponseModelBloc extends Bloc<ResponseModelEvent, ResponseModelState> {
  ResponseModelBloc() : super(const ResponseModelInitial()) {
    on<SuccessResponse>(_onSuccess);
    on<GettingResponseEvent>((event, emit) {
      emit(const GettingResponseState());
    });
    on<FailedResponse>(_onFailed);
  }

  void _onSuccess(
      SuccessResponse event, Emitter<ResponseModelState> emit) async {
    try {
      ResponseModel? responseModel =
          await GptRepository().getResponse(event.userInput);
      if (responseModel != null) {
        emit(ResponseModelState(responseModel: responseModel));
        return;
      }
      emit(const ResponseModelState(responseModel: null));
    } catch (e) {
      emit(const ResponseModelState(responseModel: null));
    }
  }

  void _onFailed(FailedResponse event, Emitter<ResponseModelState> emit) {
    emit(const ResponseModelState(responseModel: null));
  }
}
