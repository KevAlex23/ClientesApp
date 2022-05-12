import 'package:objectbox/objectbox.dart';

@Entity()
class Log {
  int id = 0;
  String logDate;
  String logDescription;
  Log({
    required this.logDate,
    required this.logDescription,
  });
}
