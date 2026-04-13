import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../domain/entities/user.dart';
import '../providers/auth_providers.dart';
import '../../../../core/di/injection_container.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  StreamSubscription<User?>? _authSubscription;

  AuthNotifier(this._ref) : super(const AuthState()) {
    _initializeAuth();
  }

  void _initializeAuth() {
    _authSubscription?.cancel();
    final repo = _ref.read(authRepositoryProvider);

    _authSubscription = repo.authStateChanges.listen((user) {
      state = state.copyWith(user: user, isLoading: false);
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _ref.read(signInUseCaseProvider).call(email, password);
    
    result.fold(
      (_) => state = state.copyWith(isLoading: false),
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
    );
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _ref.read(signUpUseCaseProvider).call(email, password);
    
    result.fold(
      (_) => state = state.copyWith(isLoading: false),
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
    );
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _ref.read(signOutUseCaseProvider).call();
    
    result.fold(
      (_) => state = const AuthState(),
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void updateUser(User? user) {
    state = state.copyWith(user: user);
  }
}
