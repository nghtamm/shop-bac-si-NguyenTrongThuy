import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract class NewFirebaseService {
  Future<Either> getNews();
}

class NewFirebaseServiceImpl implements NewFirebaseService {
  @override
  Future<Either> getNews() async {
    try {
      var newsData = await FirebaseFirestore.instance.collection('News').get();
      return Right(newsData.docs.map((e) => e.data()).toList());
    } catch (err) {
      return Left(err);
    }
  }
}
