import 'package:customers_phones_kev/domain/repository/local_repository.dart';
import 'package:customers_phones_kev/domain/repository/user_sign_repository.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final user = Get.find<MainUserSignInterface>();
  final store = Get.find<LocalRepositoryInterface>();
  @override
  void onInit() {
    super.onInit();
  }

  Future loadStore() async {
    await store.loadStore();
  }
  
  Future<bool> isLogged() async {
    var verifyLogin =  user.isLogged()==""?false:true;
    await loadStore();
    return verifyLogin;
  }

  @override
  void onReady() {
    super.onReady();
  }
}