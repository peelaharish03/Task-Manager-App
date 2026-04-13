import '../repositories/task_repository.dart';
import '../entities/task.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';
import 'package:uuid/uuid.dart';

class CreateTaskUseCase {
  final TaskRepository _repository;

  CreateTaskUseCase(this._repository);

  Future<Result<Task>> call(String title, String description, String userId) async {
    if (title.trim().isEmpty) {
      return Result.failure(const ValidationFailure('Task title cannot be empty'));
    }

    if (title.length > 100) {
      return Result.failure(const ValidationFailure('Task title must be less than 100 characters'));
    }

    if (description.length > 500) {
      return Result.failure(const ValidationFailure('Task description must be less than 500 characters'));
    }

    final task = Task(
      id: const Uuid().v4(),
      title: title.trim(),
      description: description.trim(),
      isCompleted: false,
      userId: userId,
      createdAt: DateTime.now(),
    );

    return await _repository.createTask(task);
  }
}
