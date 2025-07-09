import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:redit_clone/features/Auth/view_model/auth_controller.dart';
import 'package:redit_clone/features/community/controller/community_controller.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(communityControllerProvider.notifier).getCommunity(ref.read(userProvider)!.uid);
    return Drawer(
      child: SafeArea(child: Column(
        children: [
          ListTile(title: Text("Create a community"),
          leading: Icon(Icons.add),
          onTap: (){
            context.push('/community');
          },),
          SizedBox(height: 15,),
          ref.watch(getCommunityProvider).when(
            data: (data) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final community = data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(community.avatar),
                    ),
                    title: Text(community.name),
                  );
                },
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => CircularProgressIndicator(),
          )
        ],
      )),
    );
  }
}