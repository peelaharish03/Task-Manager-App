import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/tasks/data/datasources/firestore_tasks_datasource.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/get_tasks_usecase.dart';
import '../../features/tasks/domain/usecases/create_task_usecase.dart';
import '../../features/tasks/domain/usecases/update_task_usecase.dart';
import '../../features/tasks/domain/usecases/delete_task_usecase.dart';
import '../../features/tasks/domain/usecases/watch_tasks_usecase.dart';
import '../constants/app_constants.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseAuthDataSourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return FirebaseAuthDataSource(auth);
});

final firestoreTasksDataSourceProvider = Provider<FirestoreTasksDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FirestoreTasksDataSource(
    firestore,
    collectionPath: AppConstants.tasksCollection,
  );
});

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(firebaseAuthDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

// Auth Use Cases Providers
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInUseCase(authRepository);
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(authRepository);
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(authRepository);
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(authRepository);
});

// Task Repository Provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dataSource = ref.watch(firestoreTasksDataSourceProvider);
  return TaskRepositoryImpl(dataSource);
});

// Task Use Cases Providers
final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return GetTasksUseCase(taskRepository);
});

final createTaskUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return CreateTaskUseCase(taskRepository);
});

final updateTaskUseCaseProvider = Provider<UpdateTaskUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return UpdateTaskUseCase(taskRepository);
});

final deleteTaskUseCaseProvider = Provider<DeleteTaskUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return DeleteTaskUseCase(taskRepository);
});

final watchTasksUseCaseProvider = Provider<WatchTasksUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return WatchTasksUseCase(taskRepository);
});
