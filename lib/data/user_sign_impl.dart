import 'package:customers_phones_kev/domain/models/user.dart';
import 'package:customers_phones_kev/domain/repository/user_sign_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainUserSignImpl extends MainUserSignInterface{
  final firebaseAuth = FirebaseAuth.instance;

  @override
  String isLogged(){
    var user = firebaseAuth.currentUser;
    return user==null?"":user.email!;
  }

  @override
  Future<MainUser> signIn(String email, String pass) async {
    late MainUser _mainUser;
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      _mainUser = MainUser(email: email, name: "unkName");
    } on FirebaseAuthException catch (e) {
      _mainUser = MainUser(email: e.message!, name: e.message!);
    }
    return _mainUser;
  }

  @override
  Future<MainUser> signUp(String email, String pass, String name) async {
    late MainUser _mainUser;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      _mainUser = MainUser(email: email, name: name);
    } on FirebaseAuthException catch (e) {
      _mainUser = MainUser(email: e.message!, name: e.message!);
    }
    return _mainUser;
  }

  @override
  Future<String> signOut() async {
    String result;
    try {
      await firebaseAuth.signOut();
      result = "Sesión cerrada";
    }on FirebaseAuthException catch (e) {
      result = e.message!;
    }
    return result;
  }

  


  
  
}