import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class WatchTasksUseCase {
  final TaskRepository _repository;

  WatchTasksUseCase(this._repository);

  Stream<List<Task>> call(String userId) {
    return _repository.watchTasks(userId);
  }
}
