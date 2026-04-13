import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../domain/entities/task.dart';
import '../providers/task_providers.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../core/di/injection_container.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final Ref _ref;
  StreamSubscription<List<Task>>? _tasksSubscription;

  TaskNotifier(this._ref) : super(const TaskState()) {
    _initialize();
  }

  void _initialize() {
    _tasksSubscription?.cancel();

    _ref.listen<User?>(currentUserProvider, (previous, next) {
      if (next == null) {
        _tasksSubscription?.cancel();
        state = const TaskState();
        return;
      }

      _subscribeToTasks(next.id);
    });

    final currentUser = _ref.read(currentUserProvider);
    if (currentUser != null) {
      _subscribeToTasks(currentUser.id);
    }
  }

  void _subscribeToTasks(String userId) {
    _tasksSubscription?.cancel();
    state = state.copyWith(isLoading: true, error: null);

    _tasksSubscription = _ref
        .read(watchTasksUseCaseProvider)
        .call(userId)
        .listen(
          (tasks) => state = state.copyWith(isLoading: false, tasks: tasks),
          onError: (e) => state = state.copyWith(isLoading: false, error: e.toString()),
        );
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    final currentUser = _ref.read(currentUserProvider);
    if (currentUser == null) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _ref.read(getTasksUseCaseProvider).call(currentUser.id);

    result.fold(
      (tasks) => state = state.copyWith(isLoading: false, tasks: tasks),
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
    );
  }

  Future<void> createTask(String title, String description) async {
    final currentUser = _ref.read(currentUserProvider);
    if (currentUser == null) return;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _ref.read(createTaskUseCaseProvider).call(
      title,
      description,
      currentUser.id,
    );

    result.fold(
      (task) {
        final updatedTasks = [task, ...state.tasks];
        state = state.copyWith(isLoading: false, tasks: updatedTasks);
      },
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
    );
  }

  Future<void> updateTask(Task task) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _ref.read(updateTaskUseCaseProvider).call(task);

    result.fold(
      (updatedTask) {
        final updatedTasks = state.tasks.map((t) => 
          t.id == updatedTask.id ? updatedTask : t
        ).toList();
        state = state.copyWith(isLoading: false, tasks: updatedTasks);
      },
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
    );
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updatedTask);
  }

  Future<void> deleteTask(String taskId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _ref.read(deleteTaskUseCaseProvider).call(taskId);

    result.fold(
      (_) {
        final updatedTasks = state.tasks.where((task) => task.id != taskId).toList();
        state = state.copyWith(isLoading: false, tasks: updatedTasks);
      },
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
    );
  }

  Future<void> refreshTasks() async {
    await _loadTasks();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
