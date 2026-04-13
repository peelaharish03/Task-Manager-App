import '../repositories/auth_repository.dart';
import '../../../../core/utils/result.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Result<void>> call() async {
    return await _repository.signOut();
  }
}
