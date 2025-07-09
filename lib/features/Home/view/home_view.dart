import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/common/error.dart';
import 'package:redit_clone/core/common/loader.dart';
import 'package:redit_clone/features/Auth/view_model/auth_controller.dart';
import 'package:redit_clone/features/Home/widgets/drawer.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  void _signOut(WidgetRef ref) async {
    ref.read(authControllerProvider.notifier).signOutUser();
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangeProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const SizedBox();
        }
        final userData = ref.watch(getUserDataProvider(user.uid));
        return userData.when(
          data: (userModel) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                centerTitle: false,
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        displayDrawer(context);
                      },
                      icon: const Icon(Icons.menu),
                    );
                  },
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage(userModel.profilePic),
                    ),
                  ),
                ],
              ),
              drawer: AppDrawer(),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hello ${userModel.userName}"),
                    TextButton(
                      onPressed: () => _signOut(ref),
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const AppLoader(),
          error: (error, stackTrace) => AppErrorWidget(message: error.toString()),
        );
      },
      loading: () => const AppLoader(),
      error: (error, stackTrace) => AppErrorWidget(message: error.toString()),
    );
  }
}
