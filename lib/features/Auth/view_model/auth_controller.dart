
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/models/user_model.dart';
import 'package:redit_clone/features/Auth/repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authRepository: ref.watch(authRepoProvider),
    ref: ref,
  );
});

final userProvider = StateProvider<UserModel?>((ref) => null);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithEmailPassword(String email, String password) async {
    state = true;
    final user = await _authRepository.signInWithEmailAndPassword(email, password);
    state = false;
    user.fold(
      (l) => print(l.message),
      (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signUpWithEmailPassword(String email, String password, String userName) async {
    state = true;
    final user = await _authRepository.signUpWithEmailAndPassword(email, password, userName);
    state = false;
    user.fold(
      (l) => print(l.message),
      (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signOut() async {
    _authRepository.signOut();
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}


