import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';
import '../models/user_model.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<User?> get authStateChanges {
    return _dataSource.authStateChanges().map((fbUser) {
      if (fbUser == null) return null;
      return UserModel.fromFirebaseUser(fbUser);
    });
  }

  @override
  Future<Result<User>> signUp(String email, String password) async {
    try {
      final credential = await _dataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser == null) {
        return Result.failure(const AuthenticationFailure('Failed to sign up'));
      }

      return Result.success(UserModel.fromFirebaseUser(fbUser));
    } on fb.FirebaseAuthException catch (e) {
      final message = e.message ?? 'Authentication error';
      return Result.failure(AuthenticationFailure('${e.code}: $message'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<User>> signIn(String email, String password) async {
    try {
      final credential = await _dataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser == null) {
        return Result.failure(const AuthenticationFailure('Failed to sign in'));
      }

      return Result.success(UserModel.fromFirebaseUser(fbUser));
    } on fb.FirebaseAuthException catch (e) {
      final message = e.message ?? 'Authentication error';
      return Result.failure(AuthenticationFailure('${e.code}: $message'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _dataSource.signOut();
      return Result.success(null);
    } on fb.FirebaseAuthException catch (e) {
      final message = e.message ?? 'Authentication error';
      return Result.failure(AuthenticationFailure('${e.code}: $message'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final currentUser = _dataSource.currentUser;
      if (currentUser == null) {
        return Result.failure(const AuthenticationFailure('No user logged in'));
      }
      return Result.success(UserModel.fromFirebaseUser(currentUser));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> resetPassword(String email) async {
    try {
      await _dataSource.sendPasswordResetEmail(email);
      return Result.success(null);
    } on fb.FirebaseAuthException catch (e) {
      final message = e.message ?? 'Authentication error';
      return Result.failure(AuthenticationFailure('${e.code}: $message'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
