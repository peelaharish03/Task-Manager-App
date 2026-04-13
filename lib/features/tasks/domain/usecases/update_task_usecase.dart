import '../repositories/task_repository.dart';
import '../entities/task.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<Result<Task>> call(Task task) async {
    if (task.title.trim().isEmpty) {
      return Result.failure(const ValidationFailure('Task title cannot be empty'));
    }

    if (task.title.length > 100) {
      return Result.failure(const ValidationFailure('Task title must be less than 100 characters'));
    }

    if (task.description.length > 500) {
      return Result.failure(const ValidationFailure('Task description must be less than 500 characters'));
    }

    final updatedTask = task.copyWith(
      updatedAt: DateTime.now(),
    );

    return await _repository.updateTask(updatedTask);
  }
}
