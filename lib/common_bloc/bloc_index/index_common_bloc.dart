import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'index_common_event.dart';
part 'index_common_state.dart';

class IndexCommonBloc extends Bloc<IndexCommonEvent, IndexCommonState> {
  IndexCommonBloc() : super(const IndexCommonInitial(0)) {
    on<ScrollPageView>(_changePageView);
  }
  _changePageView(ScrollPageView event, Emitter<IndexCommonState> emit) {
    emit(IndexCommonState(
      event.index,
    ));
  }
}
