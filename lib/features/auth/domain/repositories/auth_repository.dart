import '../entities/user.dart';
import '../../../../core/utils/result.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  
  Future<Result<User>> signUp(String email, String password);
  
  Future<Result<User>> signIn(String email, String password);
  
  Future<Result<void>> signOut();
  
  Future<Result<User>> getCurrentUser();
  
  Future<Result<void>> resetPassword(String email);
}
