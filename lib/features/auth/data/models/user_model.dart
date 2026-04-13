import '../../domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromFirebaseUser(fb.User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      createdAt: user.metadata.creationTime,
      updatedAt: user.metadata.lastSignInTime,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['user_metadata']?['display_name'] as String?,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  factory UserModel.fromSupabaseUser(Map<String, dynamic> user) {
    return UserModel(
      id: user['id'] as String,
      email: user['email'] as String,
      displayName: user['user_metadata']?['display_name'] as String?,
      createdAt: user['created_at'] != null
          ? DateTime.parse(user['created_at'] as String)
          : null,
      updatedAt: user['updated_at'] != null
          ? DateTime.parse(user['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
