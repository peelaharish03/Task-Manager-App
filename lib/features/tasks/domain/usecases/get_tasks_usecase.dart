import '../repositories/task_repository.dart';
import '../entities/task.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';

class GetTasksUseCase {
  final TaskRepository _repository;

  GetTasksUseCase(this._repository);

  Future<Result<List<Task>>> call(String userId) async {
    if (userId.isEmpty) {
      return Result.failure(const ValidationFailure('User ID cannot be empty'));
    }

    return await _repository.getTasks(userId);
  }
}
