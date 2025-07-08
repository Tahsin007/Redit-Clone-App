
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/common/error.dart';
import 'package:redit_clone/core/common/loader.dart';
import 'package:redit_clone/core/models/user_model.dart';
import 'package:redit_clone/features/Auth/view/sign_in_view.dart';
import 'package:redit_clone/features/Auth/view/sign_up_view.dart';
import 'package:redit_clone/features/Auth/view_model/auth_controller.dart';
import 'package:redit_clone/features/Home/view/home_view.dart';

// Add this provider for user data
final userDataProvider = FutureProvider.family<UserModel?, String>((ref, uid) async {
  return await ref.watch(authControllerProvider.notifier).getUserData(uid).first;
});

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  UserModel? userModel;

  void getUserData(WidgetRef ref, User data) async {
    userModel = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
    ref.read(userProvider.notifier).update((state)=> userModel);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
      data: (data) {
        if (data != null) {
          getUserData(ref, data);
            if (userModel != null) {
              return HomeView();
            }
          }
        return SignIn();
      },
      error: (error, stackTrace) {
        return AppErrorWidget(message: error.toString());
      },
      loading: () => AppLoader(),
    );
    // return StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return const HomeView();
    //     } else {
    //       return const SignIn();
    //     }
    //   },
    // );
  }
}

