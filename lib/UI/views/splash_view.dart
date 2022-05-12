import 'package:customers_phones_kev/UI/views/home_view.dart';
import 'package:customers_phones_kev/UI/views/sign_in_view.dart';
import 'package:customers_phones_kev/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        controller.isLogged().then((value) => value? Get.offAll(()=>const HomeView()):Get.offAll(()=>const SignIn(isRelogin: false,)));
        return const Scaffold(
          body: SafeArea(child: Center(child: Icon(Icons.groups_rounded, size: 48,),)),
        );
      }
    );
  }
}
