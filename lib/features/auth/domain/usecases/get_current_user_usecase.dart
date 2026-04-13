import '../repositories/auth_repository.dart';
import '../entities/user.dart';
import '../../../../core/utils/result.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<Result<User?>> call() async {
    return await _repository.getCurrentUser();
  }
}
