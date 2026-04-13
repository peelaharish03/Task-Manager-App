import '../repositories/auth_repository.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Result<void>> call(String email, String password) async {
    if (!_isValidEmail(email)) {
      return Result.failure(const ValidationFailure('Invalid email format'));
    }
    
    if (password.isEmpty) {
      return Result.failure(const ValidationFailure('Password cannot be empty'));
    }

    final result = await _repository.signIn(email, password);
    return result.fold(
      (user) => Result.success(null),
      (failure) => Result.failure(failure),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
