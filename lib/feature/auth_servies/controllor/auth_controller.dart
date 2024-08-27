import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_incriment/feature/auth_servies/repository/auth_repository.dart';
import 'package:value_incriment/feature/auth_servies/screen/login_screen.dart';
import 'package:value_incriment/home_page.dart';

import '../../../core/commen/type_def.dart';
import '../../../core/commen/utils.dart';
import '../../../model/user_model.dart';
final userProvider=StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController,bool >((ref) {
  return AuthController(
      repository: ref.watch(authRepositoryProvider),
      ref: ref);
});
final getUserProvider = StreamProvider.autoDispose.family((ref,String data)  {
  Map a=jsonDecode(data);
  return ref.read(authControllerProvider.notifier).getUserData(a["email"],a["password"]);

});
class AuthController extends StateNotifier<bool>{
  final AuthRepository _repository;
  final Ref _ref;
  AuthController({
    required AuthRepository repository,
    required Ref ref
}):_repository=repository,_ref=ref,super(false);

  // FutureVoid SignUpWithCredential(UserModel userModel)async {
  //  return await _repository.SignUpWithCredential(userModel);
  // }
  signData(
      UserModel userModel, BuildContext context) async {
    var result = await _repository.signUpData(userModel);
    result.fold(
            (l) async {
          userModel.name == ""
              ? negetiveshowSnackBar(context, "Enter the name")
              : userModel.password == ""
              ? negetiveshowSnackBar(context, "Enter the password")
              : negetiveshowSnackBar(context, "Enter the email");
        },
            (r)  {
              // null;
       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomeScreen(email: userModel.email,password: userModel.password,),
          ),
              (route) => false);
     });
   }

  loginData(String email, String password, BuildContext context) async {
    var result = await _repository.loginData(email, password);
    result.fold(
            (l) async => negetiveshowSnackBar(
                context, "Invalid email or password",),
            (r) async {
          final SharedPreferences preferences =
          await SharedPreferences.getInstance();
          preferences.setString("email", email);
          preferences.setString("password", password);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>  HomeScreen(password: password,email:email ,),
              ),
                  (route) => false);
   });
   }
  Future<void> keepLogin(BuildContext context, SharedPreferences prefs) async {
    final data = await _repository.keepLogin(prefs);
    data.fold((l) async {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
              (route) => false);
    }, (r) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? email=pref.getString("email");
    String? password=pref.getString("password");
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomeScreen( password: password??"",email: email??"",),
          ),
              (route) => false);
      });
    }
    logOut(BuildContext context,SharedPreferences pref) async {
    _repository.logOUt(pref,);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),),
        (route) => false,);
    }
  Stream<UserModel>getUserData(String email,String password){
    return _repository.getUserData(email,password);
  }
increasValue(UserModel userModel, BuildContext context){
    return _repository.increasValue(userModel);
}

}