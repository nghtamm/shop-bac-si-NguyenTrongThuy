import 'package:flutter_bloc/flutter_bloc.dart';

class TogglePasswordCubit extends Cubit<bool> {
  TogglePasswordCubit() : super(false);

  void toggleVisibility() => emit(!state);
}