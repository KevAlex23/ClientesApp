import 'package:customers_phones_kev/domain/models/user.dart';

abstract class MainUserSignInterface {
  String isLogged();
  Future<MainUser> signIn(String email, String pass);
  Future<MainUser> signUp(String email, String pass, String name);
  Future<String> signOut();
}