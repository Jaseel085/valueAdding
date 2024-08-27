import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_incriment/core/pallet/colorpage.dart';
import 'package:value_incriment/feature/auth_servies/controllor/auth_controller.dart';
import 'package:value_incriment/feature/auth_servies/screen/sign_up_screen.dart';
import 'package:value_incriment/home_page.dart';
import 'package:value_incriment/main.dart';
import 'package:value_incriment/model/user_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key,});


  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  bool tap=false;

  RegExp password_validator= RegExp(r"(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$");
  RegExp email_validator=   RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.secondoryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: height*0.25,),
              Text("Welcome Back",style: TextStyle(
                fontSize: width*0.1,
                fontWeight: FontWeight.w700,
          
              ),),
              Text("Please login to your account",
              style: TextStyle(
                color: ColorPage.text_color,
                fontWeight: FontWeight.w500,
                fontSize: width*0.05
              ),),
              SizedBox(height: height*0.1,),
              TextFormField(
                controller: emailController,
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
    obscureText: tap?true:false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (!password_validator.hasMatch(value!)) {
        return "Enter A Strong Password";
      };
    }
    ),
              SizedBox(height: height*0.08,),
              InkWell(
                onTap: () {
                  ref.watch(authControllerProvider.notifier).loginData(
                      emailController.text.trim(), passwordController.text.trim(), context);
                  emailController.clear();
                  passwordController.clear();

                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: ColorPage.primaryColor,
                      borderRadius: BorderRadius.circular(width * 0.05)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.05),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "don't have an account?",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                    },
                    child: Text(
                      "Sign up",
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
    );
  }
}
