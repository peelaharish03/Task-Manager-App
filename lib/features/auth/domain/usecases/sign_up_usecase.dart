import '../repositories/auth_repository.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Result<void>> call(String email, String password) async {
    if (!_isValidEmail(email)) {
      return Result.failure(const ValidationFailure('Invalid email format'));
    }
    
    if (password.length < 6) {
      return Result.failure(const ValidationFailure('Password must be at least 6 characters'));
    }

    final result = await _repository.signUp(email, password);
    return result.fold(
      (user) => Result.success(null),
      (failure) => Result.failure(failure),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
