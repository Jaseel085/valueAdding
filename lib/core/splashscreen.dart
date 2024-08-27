import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_incriment/core/pallet/colorpage.dart';
import 'package:value_incriment/feature/auth_servies/controllor/auth_controller.dart';
import 'package:value_incriment/main.dart';

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {
  @override
  checkUser() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    ref.watch(authControllerProvider.notifier).keepLogin(context, preferences);
  }

  void initState() {
     checkUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: height*1,
        width: width*1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Container(
                height: height*1,
                width: width*1,
                color: ColorPage.secondoryColor,
                child:
            Center(
              child: Text("WELCOME",
                style: TextStyle(
                  fontWeight:FontWeight.w800,
                  fontSize: width*0.17,
                  color: ColorPage.primaryColor,
                ),
              ),
            ),
            )]
        )



          ,
        ),
      );
  }
}
