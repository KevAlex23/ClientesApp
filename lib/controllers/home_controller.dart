import 'package:customers_phones_kev/UI/views/customer_data_view.dart';
import 'package:customers_phones_kev/UI/views/customer_list_view.dart';
import 'package:customers_phones_kev/domain/models/customer.dart';
import 'package:customers_phones_kev/domain/models/customer_phones.dart';
import 'package:customers_phones_kev/domain/models/log.dart';
import 'package:customers_phones_kev/domain/models/user.dart';
import 'package:customers_phones_kev/domain/repository/local_repository.dart';
import 'package:customers_phones_kev/domain/repository/user_sign_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface _localRepository;
  final MainUserSignInterface _mainUserSign;
  HomeController(this._localRepository, this._mainUserSign);

  //propiedades de la vista
  int currrentIndex = 0;
  List<Widget> views = [CustomerListView(), CustomerDataView(editCustomer: null,)];

  MainUser? mainUser;
  RxList<Customer> myCustomers = <Customer>[].obs;

  @override
  onInit() async {
    mainUser = _localRepository.loadMainUser(MainUser(email: _mainUserSign.isLogged(), name: ""));
    super.onInit();
    
  }

  @override
  void onReady() {
    super.onReady();
    loadMyCustomers();
  }

  //Customer controller
  String saveCustomer(Customer customer){
    String result = "";
    Customer? customerAux;
    customerAux = myCustomers.firstWhere((element) => element.document==customer.document, orElse: ()=>Customer(document: -1, name: 'null', secondName: 'null', lastName: 'null', secondLastName: 'null'));
    if(customerAux.document>0){
      result = "Ya existe un cliente con ese documento";
    }else{
      result = _localRepository.saveCustomer(customer, mainUser!);
      saveLog(result);
    }
    
    loadMyCustomers();
    return result;
  }

  String editCustomer(Customer customer){
    String result = "";
    result = _localRepository.editCustomer(customer);
    loadMyCustomers();
    saveLog(result);
    return result;
  }

  String saveCustomerPhone(Customer customer, CustomerPhone customerPhone){
    String result = "";
    Customer? customerAux = myCustomers.firstWhere((element) => element.id==customer.id, orElse: ()=>Customer(document: -1, name: 'null', secondName: 'null', lastName: 'null', secondLastName: 'null'));
    if(customerAux.document>0){
      result = _localRepository.saveCustomerPhone(mainUser!, customerAux, customerPhone);
      saveLog(result);
    }else{
      result = "Cliente no encontrado";
    }
    loadMyCustomers();
    return result;
  }

  List<Customer> loadMyCustomers(){
    myCustomers.clear();
    myCustomers.value = _localRepository.loadMyCustomers(mainUser!);
    return _localRepository.loadMyCustomers(mainUser!);
  }

  void saveLog(String description){
    Log log = Log(logDate: DateTime.now().toString(), logDescription: description);
    _localRepository.saveLog(log);
  }

  String deleteCustomer(Customer customer){
    String result = _localRepository.deleteCustomer(customer);
    saveLog(result);
    loadMyCustomers();
    return result;
  }

  Future<String> signOut() async {
    String result = await _mainUserSign.signOut();
    return result;
  }

  @override
  void onClose() {
    super.onClose();
  }
}