import 'package:customers_phones_kev/domain/models/customer.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CustomerPhone {
  int id = 0;
  int phone;

  final customer = ToOne<Customer>();

  CustomerPhone({
    required this.phone,
  });
}
