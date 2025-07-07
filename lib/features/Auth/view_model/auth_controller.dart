
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/features/Auth/repository/auth_repository.dart';

final authControllerProvider = ChangeNotifierProvider((ref) => AuthController(auth_repository: ref.read(authRepoProvider)));

class AuthController extends ChangeNotifier {
  final AuthRepository _authRepository;
  AuthController({required AuthRepository auth_repository}):_authRepository=auth_repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signInWithEmailPassword( String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
    } catch (e) {
      // Handle error
    }
    _isLoading = false;
    notifyListeners();
  }
}
