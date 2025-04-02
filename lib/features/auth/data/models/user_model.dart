import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String super.id,
    required String super.email,
    required String super.displayName,
    required String super.userNicename,
    required String super.userLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['ID'] ?? '',
      email: json['user_email'] ?? '',
      displayName: json['display_name'] ?? '',
      userLogin: json['user_login'] ?? '',
      userNicename: json['user_nicename'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'user_email': email,
      'display_name': displayName,
      'user_login': userLogin,
      'user_nicename': userNicename,
    };
  }
}
