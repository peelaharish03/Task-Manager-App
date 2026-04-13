import '../repositories/task_repository.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<Result<void>> call(String taskId) async {
    if (taskId.isEmpty) {
      return Result.failure(const ValidationFailure('Task ID cannot be empty'));
    }

    return await _repository.deleteTask(taskId);
  }
}
