import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:redit_clone/features/Auth/view/sign_in_view.dart';
import 'package:redit_clone/features/Auth/view/sign_up_view.dart';
import 'package:redit_clone/features/Auth/view_model/auth_controller.dart';
import 'package:redit_clone/features/Home/view/home_view.dart';
import 'package:redit_clone/features/Community/create_community.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangeProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const SignIn(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: '/community',
        name: 'community',
        builder: (context, state) => const CreateCommunity(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      if (authState.isLoading || authState.hasError) {
        return null;
      }

      final bool isLoggedIn = authState.value != null;

      if (!isLoggedIn) {
        return loggingIn ? null : '/login';
      }

      if (loggingIn) {
        return '/';
      }

      return null;
    },
  );
});
