import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:redit_clone/core/common/snackbar.dart';
import 'package:redit_clone/core/constants/constants.dart';
import 'package:redit_clone/features/Auth/view_model/auth_controller.dart';
import 'package:redit_clone/features/Community/community_model.dart';
import 'package:redit_clone/features/Community/repository/community_repository.dart';

final communityControllerProvider = StateNotifierProvider<CommunityController,bool>((ref) {
  final communityRepository = ref.watch(communityRepoProvider);
  return CommunityController(communityRepository: communityRepository, ref: ref) ;
});

final getCommunityProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getCommunity();
});

class CommunityController extends StateNotifier<bool>{
  final CommunityRepository _communityRepository;
  final Ref _ref;

  CommunityController({required CommunityRepository communityRepository, required Ref ref})
    : _communityRepository = communityRepository,_ref=ref,super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final user = _ref.read(userProvider);

    if (user == null) {
      appSnackbar(context, 'User not logged in!');
      state = false;
      return;
    }

    final uid = user.uid;
    Community community = Community(
      id: uid,
      name: name,
      banner: Constants.bannerDefault,
      avatar: Constants.avatarDefault,
      members: [uid],
      mods: [uid],
    );
    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold((onLeft) {
      appSnackbar(context, onLeft.message);
    }, (onRight) {
      appSnackbar(context, 'You have successfully created the community');
      context.pop();
    });
  }

  Stream<List<Community>> getCommunity() {
    final uid = _ref.read(userProvider)!.uid;
    print("User id : $uid");
    return _communityRepository.getCommunity(uid);
  }
}
