import 'package:customers_phones_kev/domain/models/customer.dart';
import 'package:customers_phones_kev/domain/models/customer_phones.dart';
import 'package:customers_phones_kev/domain/models/log.dart';
import 'package:customers_phones_kev/domain/models/user.dart';
import 'package:customers_phones_kev/domain/repository/local_repository.dart';

import '../objectbox.g.dart';

class LocalRepositoryImpl extends LocalRepositoryInterface{
  late final Store _store;
  late final Box<MainUser> _mainUserBox;

  

  @override
  Future<List> loadStore() async {
    
    _store = await openStore();
    _mainUserBox = _store.box<MainUser>();

    return [];
  }

  @override
  MainUser loadMainUser(MainUser mainUser){
    MainUser? userAux;
    final mainUsers = <MainUser>[];
    mainUsers.addAll(_mainUserBox.getAll());
    try {
      userAux = mainUsers.firstWhere((element) => element.email==mainUser.email);
      mainUser = userAux;
    }on StateError catch (e) {
      _mainUserBox.put(mainUser);
    }
    return userAux!;
  }

  saveMainUser(MainUser mainUser){
    _mainUserBox.put(mainUser);
  }

  @override
  String saveCustomer(Customer customer, MainUser mainUser){
    String result= "";
    
    try {
      customer.mainUser.target = mainUser;
      _store.box<Customer>().put(customer);
      result = "Cliente con el documento "+customer.document.toString()+" creado correctamente";
      
    } catch (e) {
      result = e.toString();
    }
   return result;
  }

  @override
  List<Customer> loadMyCustomers(MainUser mainUser) {
    List<Customer> customersAux = [];
    QueryBuilder<Customer> builder = _store.box<Customer>().query();
    builder.link(Customer_.mainUser, MainUser_.id.equals(mainUser.id));
    Query<Customer> query = builder.build();
    List<Customer> tasksResult = query.find();
    customersAux.addAll(tasksResult);
    query.close();
    return customersAux;
  }
  
  @override
  String editCustomer(Customer customer) {
    String result = "";
    try {
      _store.box<Customer>().put(customer);
      result = "Cliente con el documento "+customer.document.toString()+" editado correctamente";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  @override
  String saveCustomerPhone(MainUser mainUser, Customer customer, CustomerPhone customerPhone) {
    String result = "";

    try {
      customer.mainUser.target = mainUser;
      customerPhone.customer.target = customer;
      _store.box<CustomerPhone>().put(customerPhone);
      result = "Número de teléfono "+customerPhone.phone.toString()+" agegado correctamente cliente con el documento "+customer.document.toString();
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  @override
  String deleteCustomer(Customer customer) {
    bool result = _store.box<Customer>().remove(customer.id);
    return result?"Cliente con el número de documento ${customer.document} eliminado correctamente":"Ocurrio un error al eliminar al cliente";
  }

  @override
  void saveLog(Log log) {
    _store.box<Log>().put(log);
  }

  @override
  List<Log> getLogs() {
    return _store.box<Log>().getAll();
  }

  

  
  
}