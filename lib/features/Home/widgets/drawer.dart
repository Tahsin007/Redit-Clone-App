import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(child: Column(
        children: [
          ListTile(title: Text("Create a community"),
          leading: Icon(Icons.add),
          onTap: (){
            context.push('/community');
          },)
        ],
      )),
    );
  }
}