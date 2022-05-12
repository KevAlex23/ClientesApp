import 'package:customers_phones_kev/domain/models/customer.dart';
import 'package:customers_phones_kev/domain/models/customer_phones.dart';
import 'package:customers_phones_kev/domain/models/log.dart';
import 'package:customers_phones_kev/domain/models/user.dart';

abstract class LocalRepositoryInterface {
  Future<List> loadStore();
  MainUser loadMainUser(MainUser mainUser);
  String saveCustomer(Customer customer, MainUser mainUser);
  String editCustomer(Customer customer);
  List<Customer> loadMyCustomers(MainUser mainUser);
  String saveCustomerPhone(MainUser mainUser, Customer customer, CustomerPhone customerPhone);
  String deleteCustomer(Customer customer);
  void saveLog(Log log);
  List<Log> getLogs();
}