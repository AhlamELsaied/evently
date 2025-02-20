import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_theme/app_asstes.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDown(
        onFinish: (direction) {
          Future.delayed(const Duration(seconds: 2), () {
            if(FirebaseAuth.instance.currentUser!=null){
              Navigator.pushReplacementNamed(context, RoutesName.layout);
            }else{
              Navigator.pushReplacementNamed(context, RoutesName.firstScreen);
            }
          });
        },
        child: Column(
          children: [
            const Spacer(),
            FadeInRightBig(child: Center(child: Image.asset(AppAssets.logo))),
            const Spacer(),
            FadeInUp(child: Image.asset(AppAssets.logoRoute))
          ],
        ),
      ),
    );
  }
}
