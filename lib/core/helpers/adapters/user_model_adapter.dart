import 'package:hive/hive.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      id: reader.readString(),
      email: reader.readString(),
      displayName: reader.readString(),
      userNicename: reader.readString(),
      userLogin: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.id ?? '');
    writer.writeString(obj.email ?? '');
    writer.writeString(obj.displayName ?? '');
    writer.writeString(obj.userNicename ?? '');
    writer.writeString(obj.userLogin ?? '');
  }
}
