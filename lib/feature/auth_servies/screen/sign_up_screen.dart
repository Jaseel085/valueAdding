import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:value_incriment/core/pallet/colorpage.dart';
import 'package:value_incriment/feature/auth_servies/controllor/auth_controller.dart';
import 'package:value_incriment/feature/auth_servies/screen/login_screen.dart';
import 'package:value_incriment/model/user_model.dart';

import '../../../main.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController=TextEditingController();
  final nameController=TextEditingController();
  final passwordController=TextEditingController();
  bool tap=false;

  RegExp name_validator= RegExp(r"^[a-zA-Z]+$");
  RegExp password_validator= RegExp(r"(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$");
  RegExp email_validator=   RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.secondoryColor,
             body: Form(
               key: formkey,
               child: Container(
                 width: width*1,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SingleChildScrollView(
                     child: Column(
                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       // crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         SizedBox(height: height*0.25,),
                         Text("Welcome ",style: TextStyle(
                           fontSize: width*0.1,
                           fontWeight: FontWeight.w700,
                     
                         ),),
                         SizedBox(height: height*0.1,),
                         TextFormField(
                           controller: nameController,
                           decoration: InputDecoration(
                               fillColor: ColorPage.white.withOpacity(0.6),
                               filled: true,
                               enabledBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(width*0.03),
                                   borderSide: const BorderSide(
                                     color: ColorPage.primaryColor,
                                   )
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(width*0.03),
                                   borderSide: const BorderSide(
                                     color: ColorPage.primaryColor,
                                   )
                               ),
                               hintText: "your name",
                               labelText: "Name"
                           ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: (value) {
                             if(!name_validator.hasMatch(value!)){
                                 return "Return Your Name Properly";
                             }
                             return null;
                           },
                         ),
                         SizedBox(height: height*0.02,),
                         TextFormField(
                           controller: emailController,
                           keyboardType: TextInputType.emailAddress,
                           decoration: InputDecoration(
                               fillColor: ColorPage.white.withOpacity(0.6),
                               filled: true,
                               enabledBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(width*0.03),
                                   borderSide: const BorderSide(
                                     color: ColorPage.primaryColor,
                                   )
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(width*0.03),
                                   borderSide: const BorderSide(
                                     color: ColorPage.primaryColor,
                                   )
                               ),
                               hintText: "youremail@gmail.com",
                               labelText: "Email"
                           ),
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: (value) {
                             if(!email_validator.hasMatch(value!)){
                               return "Enter A Valid Email";
                             }
                             return null;
                           },
                         ),
                         SizedBox(height: height*0.02,),
                         TextFormField(
                           controller: passwordController,
                           decoration: InputDecoration(
                               fillColor: ColorPage.white.withOpacity(0.6),
                               filled: true,
                               enabledBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(width*0.03),
                                   borderSide: BorderSide(
                                     color: ColorPage.primaryColor,
                                   )
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(width*0.03),
                                   borderSide: BorderSide(
                                     color: ColorPage.primaryColor,
                                   )
                               ),
                               hintText: "Enter your password",
                               labelText: "Password",
                             suffixIcon:InkWell(
                               onTap: () {
                                 tap = !tap;
                                 setState(() {});
                               },
                               child: Icon(
                                 tap ? Icons.visibility_off : Icons.visibility,
                                 color:tap? ColorPage.black:ColorPage.primaryColor,
                               ),
                             ),
                           ),
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: (value) {
                             if(!password_validator.hasMatch(value!)){
                               return "Enter A Strong Password";
                             }
                           },
                           obscureText: tap?true:false,
                         ),
                         SizedBox(height: height*0.08,),
                         InkWell(
                           onTap: () {
                             UserModel usermodel=UserModel(
                                 name: nameController.text,
                                 email: emailController.text,
                                 password: passwordController.text,
                                 uid: "",
                                 value: 1,
                             );
                             ref.watch(authControllerProvider.notifier).signData(usermodel,context);
                             emailController.clear();
                             passwordController.clear();
                             nameController.clear();
                           },
                           child: Container(
                             height: height * 0.06,
                             width: width * 0.4,
                             decoration: BoxDecoration(
                                 color: ColorPage.primaryColor,
                                 borderRadius: BorderRadius.circular(width * 0.05)),
                             child: Center(
                               child: Text(
                                 "Sign Up",
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.w600,
                                     fontSize: width * 0.05),
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: height*0.1,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "You have an account?",
                               style: TextStyle(
                                   color: Colors.black.withOpacity(.5),
                                   fontWeight: FontWeight.w400),
                             ),
                             SizedBox(
                               width: width * 0.01,
                             ),
                             InkWell(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                               },
                               child: Text(
                                 "Login",
                                 style: TextStyle(
                                     color: ColorPage.black,
                                     fontWeight: FontWeight.w600,
                                     fontSize: width * 0.04),
                               ),
                             )
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             ),
    );
  }
}
