import '../entities/task.dart';
import '../../../../core/utils/result.dart';

abstract class TaskRepository {
  Future<Result<List<Task>>> getTasks(String userId);
  
  Future<Result<Task>> createTask(Task task);
  
  Future<Result<Task>> updateTask(Task task);
  
  Future<Result<void>> deleteTask(String taskId);
  
  Future<Result<Task>> getTaskById(String taskId);
  
  Stream<List<Task>> watchTasks(String userId);
}
