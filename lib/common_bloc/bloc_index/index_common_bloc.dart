import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'index_common_event.dart';
part 'index_common_state.dart';

class IndexCommonBloc extends Bloc<IndexCommonEvent, IndexCommonState> {
  IndexCommonBloc() : super(const IndexCommonInitial(0, false)) {
    on<ScrollPageView>(_changePageView);
    on<Validate>(_setValidate);
  }
  void _setValidate(Validate event, Emitter<IndexCommonState> emit) {
    emit(IndexCommonState(state.index, event.validate));
  }

  _changePageView(ScrollPageView event, Emitter<IndexCommonState> emit) {
    emit(IndexCommonState(event.index, state.validate));
  }
}
