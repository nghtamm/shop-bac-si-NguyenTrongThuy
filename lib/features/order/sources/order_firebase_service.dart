import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';

abstract class OrderFirebaseService {
  Future<Either<String, String>> addtoCart(AddToCartReq addToCartReq);
}

class OrderFirebaseServiceImpl extends OrderFirebaseService {
  @override
  Future<Either<String, String>> addtoCart(AddToCartReq addToCartReq) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('Cart')
          .add(addToCartReq.toMap());
      return const Right('Thêm vào giỏ thành công');
    } catch (e) {
      return const Left('Lỗi khi thêm vào giỏ');
    }
  }
}
