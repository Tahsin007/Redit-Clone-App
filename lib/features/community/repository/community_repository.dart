import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redit_clone/core/constants/firebase_constants.dart';
import 'package:redit_clone/core/providers/firebase_providers.dart';
import 'package:redit_clone/core/utils/failure.dart';
import 'package:redit_clone/core/utils/type_def.dart';
import 'package:redit_clone/features/Community/community_model.dart';

final communityRepoProvider = Provider((ref) {
  return CommunityRepository(firebaseFirestore: ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firebaseFirestore;
  CommunityRepository({required FirebaseFirestore firebaseFirestore})
    : _firebaseFirestore = firebaseFirestore;

  FutureVoid createCommunity(Community community) async {
    try {
      var communityDoc = await _firebaseFirestore
          .collection(FirebaseConstants.communitiesCollection)
          .doc(community.name)
          .get();

      if (communityDoc.exists) {
        throw 'Community with the same name exists!';
      }

      return right(
        _firebaseFirestore
            .collection(FirebaseConstants.communitiesCollection)
            .doc(community.name)
            .set(community.toMap()),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Community>> getCommunity(String uid) {
    return _firebaseFirestore
        .collection(FirebaseConstants.communitiesCollection)
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
          List<Community> communities = [];
          for (var doc in event.docs) {
            communities.add(
              Community.fromMap(doc.data() as Map<String, dynamic>),
            );
          }
          return communities;
        });
  }
}
