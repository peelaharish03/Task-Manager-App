import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/firestore_tasks_datasource.dart';
import '../models/task_model.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';

class TaskRepositoryImpl implements TaskRepository {
  final FirestoreTasksDataSource _dataSource;

  TaskRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<Task>>> getTasks(String userId) async {
    try {
      final snapshot = await _dataSource.getTasksForUser(userId);

      final tasks = snapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc.id, doc.data()).toEntity())
          .toList();

      return Result.success(tasks);
    } on FirebaseException catch (e) {
      return Result.failure(DatabaseFailure(e.message ?? 'Database error'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<Task>> createTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);

      await _dataSource.setTask(task.id, taskModel.toFirestore());

      return Result.success(task);
    } on FirebaseException catch (e) {
      return Result.failure(DatabaseFailure(e.message ?? 'Database error'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<Task>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);

      await _dataSource.updateTask(task.id, taskModel.toFirestore());

      return Result.success(task);
    } on FirebaseException catch (e) {
      return Result.failure(DatabaseFailure(e.message ?? 'Database error'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteTask(String taskId) async {
    try {
      await _dataSource.deleteTask(taskId);
      return Result.success(null);
    } on FirebaseException catch (e) {
      return Result.failure(DatabaseFailure(e.message ?? 'Database error'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<Task>> getTaskById(String taskId) async {
    try {
      final doc = await _dataSource.getTaskById(taskId);
      if (!doc.exists || doc.data() == null) {
        return Result.failure(const DatabaseFailure('Task not found'));
      }

      final task = TaskModel.fromFirestore(doc.id, doc.data()!);
      return Result.success(task.toEntity());
    } on FirebaseException catch (e) {
      return Result.failure(DatabaseFailure(e.message ?? 'Database error'));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<List<Task>> watchTasks(String userId) {
    return _dataSource.watchTasksForUser(userId)
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TaskModel.fromFirestore(doc.id, doc.data()).toEntity())
              .toList();
        });
  }
}
