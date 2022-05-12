import 'package:customers_phones_kev/domain/models/user.dart';
import 'package:customers_phones_kev/domain/repository/local_repository.dart';
import 'package:customers_phones_kev/domain/repository/user_sign_repository.dart';
import 'package:get/get.dart';

class SignController extends GetxController {
  final signRepository = Get.find<MainUserSignInterface>();
  final _localRepository = Get.find<LocalRepositoryInterface>();
  late MainUser _mainUser;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<String> signIn(String email, String pass) async {
    String result;
    _mainUser = await signRepository.signIn(email, pass);
    _mainUser.email==_mainUser.name?result=_mainUser.name:result="Acceso exitoso";
    return result;
  }

  Future<String> signUp(String email, String pass, String name) async {
    String result;
    _mainUser = await signRepository.signUp(email, pass, name);
    _mainUser.email==_mainUser.name?result=_mainUser.name:result="Registro exitoso";
    if(_mainUser.email!=_mainUser.name){
      _localRepository.loadMainUser(_mainUser);
    }
    return result;
  }

  

  @override
  void onClose() {
    super.onClose();
  }
}