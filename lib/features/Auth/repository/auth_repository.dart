import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redit_clone/core/constants/constants.dart';
import 'package:redit_clone/core/models/user_model.dart';
import 'package:redit_clone/core/providers/firebase_providers.dart';
import 'package:redit_clone/core/utils/failure.dart';
import 'package:redit_clone/core/utils/type_def.dart';

final authRepoProvider = Provider((ref) => AuthRepository(auth:ref.read(authProvider),firestore: ref.read(firestoreProvider)));

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({required FirebaseAuth auth, required FirebaseFirestore firestore}) : _auth = auth,_firestore=firestore;

  FutureEither<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        return left(Failure("User is not valid"));
      }
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        return left(Failure("User data not found in database"));
      }
      final userModel = UserModel.fromMap(userDoc.data()!);
      return right(userModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid signOut() async {
    try{
      await _auth.signOut();
      return right(null);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signUpWithEmailAndPassword(String email, String password, String userName) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        return left(Failure('User creation failed'));
      }
      final userModel = UserModel(
        uid: user.uid,
        userName: userName,
        profilePic: Constants.avatarDefault, 
        banner: Constants.bannerDefault,
        isAuthenticated: true,
        karma: 0,
        awards: const [],
      );
      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
      return right(userModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
