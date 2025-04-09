import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOptionCubit extends Cubit<int> {
  final int optionsCount;

  ProductOptionCubit({
    required int initialIndex,
    required this.optionsCount,
  }) : super(initialIndex);

  void selectOption(int index) {
    if (index >= 0 && index < optionsCount) {
      emit(index);
    }
  }
}
