import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../notifiers/task_notifier.dart';

// Task State Provider
final taskStateProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier(ref);
});

// Tasks List Provider
final tasksProvider = Provider<List<Task>>((ref) {
  return ref.watch(taskStateProvider).tasks;
});

// Task Loading Provider
final taskLoadingProvider = Provider<bool>((ref) {
  return ref.watch(taskStateProvider).isLoading;
});

// Task Error Provider
final taskErrorProvider = Provider<String?>((ref) {
  return ref.watch(taskStateProvider).error;
});

// Task State
class TaskState {
  final List<Task> tasks;
  final bool isLoading;
  final String? error;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.error,
  });

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    String? error,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskState &&
        other.tasks == tasks &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => tasks.hashCode ^ isLoading.hashCode ^ error.hashCode;

  @override
  String toString() => 'TaskState(tasks: ${tasks.length}, isLoading: $isLoading, error: $error)';
}
