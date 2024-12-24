import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_doctor_choice_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class ProductDisplayCubit extends Cubit<ProductDisplayState> {
  ProductDisplayCubit() : super(ProductInitialState());

  void displayProducts({dynamic params}) async {
    var productData = await serviceLocator<GetDoctorChoiceUseCase>().call();
    productData.fold(
      (left) {
        emit(ProductLoadFailed());
      },
      (right) {
        emit(ProductLoaded(products: right));
      },
    );
  }
}
