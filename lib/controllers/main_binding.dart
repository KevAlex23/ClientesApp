import 'package:customers_phones_kev/controllers/splash_controller.dart';
import 'package:customers_phones_kev/data/local_repository_impl.dart';
import 'package:customers_phones_kev/data/user_sign_impl.dart';
import 'package:customers_phones_kev/domain/repository/local_repository.dart';
import 'package:customers_phones_kev/domain/repository/user_sign_repository.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LocalRepositoryInterface>(() => LocalRepositoryImpl());
    Get.lazyPut<MainUserSignInterface>(() => MainUserSignImpl());
  }
}