
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/models/user_model.dart';
import 'package:redit_clone/features/Auth/repository/auth_repository.dart';

final authControllerProvider = ChangeNotifierProvider((ref) => AuthController(auth_repository: ref.read(authRepoProvider)));

final userProvider = StateProvider<UserModel?>((ref) => null);

final authStateChangeProvider = StreamProvider((ref){
  final authController = ref.watch(authControllerProvider);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref,String uid){
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData(uid);
});

class AuthController extends ChangeNotifier {
  final AuthRepository _authRepository;
  AuthController({required AuthRepository auth_repository}) : _authRepository = auth_repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signInWithEmailPassword( String email, String password) async {
    _isLoading = true;
    notifyListeners();
    var user = await _authRepository.signInWithEmailAndPassword(email, password);
    user.fold(
      (l) {
        // Handle error, e.g., show a message or log
        _isLoading = false;
        notifyListeners();
        print(l.message);
      },
      (r) {
        // Handle success, e.g., navigate or update state
        _isLoading = false;
        notifyListeners();
        print(r.toString());
      },
    );
  }

  Future<void> signUpWithEmailPassword(String email, String password, String userName) async {
    _isLoading = true;
    notifyListeners();
    var user = await _authRepository.signUpWithEmailAndPassword(email, password, userName);
    user.fold(
      (l) {
        // Handle error
        _isLoading = false;
        notifyListeners();
        print(l.message);
      },
      (r) {
        // Handle success
        _isLoading = false;
        notifyListeners();
        print(r.toString());
      },
    );
  }

  Future<void> signOutUser() async{
    var user = await _authRepository.signOut();
    user.fold((onLeft){
      print(onLeft.message);
    }, (onRight){
      print("Sign Out Successful");
    });
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Stream<User?> get authStateChange => _authRepository.authStateChange;
}


