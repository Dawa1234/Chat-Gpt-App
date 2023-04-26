import 'package:chatgpt/logic/bloc_exports.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  void isLoading() => emit(IsLoading());
  void notLoading() => emit(NotLoading());
}
