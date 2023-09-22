part of 'index_common_bloc.dart';

sealed class IndexCommonEvent extends Equatable {
  const IndexCommonEvent();

  @override
  List<Object> get props => [];
}

class ScrollPageView extends IndexCommonEvent {
  final int index;
  const ScrollPageView(this.index);
}
