import 'package:customers_phones_kev/domain/models/customer_phones.dart';
import 'package:customers_phones_kev/domain/models/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Customer {
  int id = 0;
  int document;
  String name;
  String secondName;
  String lastName;
  String secondLastName;

  final mainUser = ToOne<MainUser>();

  @Backlink()
  final customerPhones = ToMany<CustomerPhone>();

  Customer({
    required this.document,
    required this.name,
    required this.secondName,
    required this.lastName,
    required this.secondLastName,
  });
}
