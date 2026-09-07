import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(currentIndex: 0));
  void changeTab(int index) {
    if (index == state.currentIndex) return;
    emit(state.copyWith(currentIndex: index));
  }
}