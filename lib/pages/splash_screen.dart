import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:siraat/Themes/app_colors.dart';
import 'auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          children: [
            SizedBox(height: 100,),
            Image.asset("assets/images/logo.png"),
            SizedBox(height: 350,),
            LoadingAnimationWidget.staggeredDotsWave(color: AppColors.darkgreen, size: 50),
            SizedBox(height: 10,),
            Text("All rights reserved"),
            Text("\u00A9 Saad Waseem",style: TextStyle(fontSize: 20),)


          ]
        ),
      ),
    );
  }
}
