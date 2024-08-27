import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_incriment/core/commen/error.dart';
import 'package:value_incriment/core/commen/loader.dart';
import 'package:value_incriment/core/pallet/colorpage.dart';
import 'package:value_incriment/feature/auth_servies/controllor/auth_controller.dart';
import 'package:value_incriment/main.dart';

import 'model/user_model.dart';
UserModel? currentUserModel;
class HomeScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;
  const HomeScreen({super.key,required this.email,required this.password});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  logOut()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    ref.read(authControllerProvider.notifier).logOut(context,preferences);
  }
  increasValue(UserModel userModel, BuildContext context) {
    ref.watch(authControllerProvider.notifier).increasValue(userModel, context);
  }

  int count = 0;
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
      child: Scaffold(
        backgroundColor: ColorPage.secondoryColor,
        appBar: AppBar(
          actions: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  logOut();
                },
                child: Icon(Icons.logout,color: ColorPage.white,)),
          )],
          elevation: 0,
          backgroundColor: ColorPage.primaryColor,
          title: Text("Incriment value".toUpperCase(),style: TextStyle(
            color: ColorPage.white,
            fontSize: width*0.06,
              fontWeight: FontWeight.w700
          ),),
          centerTitle: true,
        ),
        body: Container(
          width: width*1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ref.watch(getUserProvider(jsonEncode({"email":widget.email,"password":widget.password}))) .when(data: (data) {
               return  Container(
                  height: height*0.5,
                  width: width*0.9,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 4)
                      ],
                      color: ColorPage.white,
                      borderRadius: BorderRadius.circular(width*0.03)
                  ),
                  child:  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: height*0.1,),
                      Text(data.name,style: TextStyle(
                          color: ColorPage.text_color,
                          fontWeight: FontWeight.w600,
                          fontSize: width*0.08
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Your Value Is ",style: TextStyle(
                              color: ColorPage.text_color,
                              fontWeight: FontWeight.w600,
                              fontSize: width*0.08
                          ),),
                          Text(data.value.toString(),style: TextStyle(
                              color: ColorPage.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: width*0.09
                          ),)
                        ],
                      ),
                      SizedBox(height: height*0.03,),
                      SizedBox(height: height*0.1,),
                      InkWell(
                        onTap: () {
                          data.value++;
                          increasValue(data, context);
                          setState(() {

                          });
                        },
                          child: Container(
                            height: height*0.1,
                            width: width*0.21,
                              decoration: BoxDecoration(
                                color: ColorPage.primaryColor,
                                borderRadius: BorderRadius.circular(width*0.05)
                              ),
                              child: Icon(CupertinoIcons.add_circled,size: width*0.15,)))
                    ],
                  ),
                );
              }, error:  (error, stackTrace) => ErrorText(error: error.toString()), loading: () => Loader(),)

            ],
          ),
        ),
      ),
    );
  }
}
