import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/common/loader.dart';
import 'package:redit_clone/core/theme/app_pallete.dart';
import 'package:redit_clone/features/Auth/view/widgets/app_button.dart';
import 'package:redit_clone/features/Auth/view/widgets/text_field.dart';
import 'package:redit_clone/features/community/controller/community_controller.dart';

class CreateCommunity extends ConsumerStatefulWidget {
  const CreateCommunity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityState();
}

class _CreateCommunityState extends ConsumerState<CreateCommunity> {
  final communityNameController = TextEditingController();

  void createCommunity() {
    ref
        .watch(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Create a community")),
      body: isLoading ? AppLoader(): Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Community Name"),
            ),
            SizedBox(height: 15),
            AppTextField(
              controller: communityNameController,
              labelText: "r/Community_Name",
            ),
            SizedBox(height: 15),
            AppButton(
              label: "Create Community",
              onPressed: () { createCommunity();},
              backgroundColor: AppPallete.primaryColor,
              foregroundColor: AppPallete.white,
            ),
          ],
        ),
      ),
    );
  }
}
