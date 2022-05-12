import 'package:customers_phones_kev/domain/models/customer.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MainUser {
  int id = 0;
  String email;
  String name;

  final customers = ToMany<Customer>();

  MainUser({
    required this.email,
    required this.name,
  });
}
