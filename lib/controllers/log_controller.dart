import 'package:customers_phones_kev/domain/models/log.dart';
import 'package:customers_phones_kev/domain/repository/local_repository.dart';
import 'package:get/get.dart';

class LogController extends GetxController {
  final _localRepository = Get.find<LocalRepositoryInterface>();

  @override
  void onInit() {
    super.onInit();
  }

  List<Log> getLogs(){
    return _localRepository.getLogs();
  }

 
}