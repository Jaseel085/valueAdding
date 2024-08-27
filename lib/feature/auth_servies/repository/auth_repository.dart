import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_incriment/core/commen/failour.dart';

import 'package:value_incriment/model/user_model.dart';

import '../../../core/commen/firbase_constants.dart';
import '../../../core/commen/type_def.dart';
import '../../../core/providers/firbase_providers.dart';
import '../../../home_page.dart';
import '../../../main.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      firestore: ref.watch(fireStoreProvider),
      auth: ref.watch(authProvider));
});

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
}):_firestore=firestore,_auth=auth;

  Future<dynamic> signUpData(UserModel userModel) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
          email: userModel.email.toString(),
          password: userModel.password.toString())
          .then((value) async {
        _users
            .add(userModel.toMap())
            .then((value) => value.update({"uid": value.id}));
      });
      return right(null);
    } catch (e) {
      return left(e.toString());
   }
   }

  Future<dynamic> loginData(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
}
}
  Future<Either<Failure, String>> keepLogin(SharedPreferences prefs) async {
    try {
      if (prefs.containsKey('email')) {
        id = prefs.getString('email')!;
        print("userId found");
        return right(id);
      } else {
        id = "";
        print("userId not found");
        return left(Failure(''));
      }
    } catch (e) {
      print("Error: $e");
      return Left(Failure("SharedPreferences error: $e"));
    }
 }

logOUt(SharedPreferences pref,) async {
    pref.clear();
    await FirebaseAuth.instance.signOut();
}

  Stream<UserModel> getUserData(String email,String password) {
    return _users.where("email",isEqualTo:email ).where("password",isEqualTo: password).snapshots().map((event) {
      return UserModel.fromMap(event.docs.first.data() as Map<String, dynamic>);
    });
  }

  increasValue(UserModel userModel){
    _users.doc(userModel.uid).update(userModel.toMap());
  }

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
}