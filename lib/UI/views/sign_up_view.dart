// ignore_for_file: body_might_complete_normally_nullable

import 'package:customers_phones_kev/UI/views/home_view.dart';
import 'package:customers_phones_kev/const/const.dart';
import 'package:customers_phones_kev/controllers/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rePass = TextEditingController();
  bool seePass = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical:  20),
            decoration: BoxDecoration(
                color: primaryWhiteColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(40))),
            child: Form(
            key: _formKey,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: Get.height * 0.1,
                    width: Get.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue.shade400),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: Get.height * 0.15,
                    width: Get.height * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue.shade100),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 150),
                    height: Get.height * 0.07,
                    width: Get.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue.shade300),
                  ),
                ),
                    ],
                  ),
                  
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    //shrinkWrap: true,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: 10,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: primaryWhiteColor,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                child: TextFormField(
                                  controller: name,
                                  validator: (_) {
                                    if (_ == null || _.isEmpty) {
                                      return "Por favor ingrese este campo";
                                    }
                                  },
                                  decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), ),
                              hintText: "Nombre completo",
                              suffixIcon: const Icon(Icons.person_rounded)),
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                child: TextFormField(
                                  controller: email,
                                  validator: (_) {
                                    if (_ == null || _.isEmpty) {
                                      return "Por favor ingrese este campo";
                                    } else {
                                      if (!GetUtils.isEmail(email.text)) {
                                        return "Correo no valido";
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), ),
                              hintText: "E-mail",
                              suffixIcon: const Icon(Icons.alternate_email_rounded)),
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                child: TextFormField(
                                  obscureText: seePass,
                                    controller: pass,
                                    validator: (_) {
                                      if (_ == null || _.isEmpty) {
                                        return "Por favor ingrese este campo";
                                      } else {
                                        if (_.length < 6) {
                                          return "La contraseña debe tener un mínimo de 6 caracteres";
                                        }
                                      }
                                    },
                                    decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), ),
                              hintText: "Contraseña",
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        seePass = !seePass;
                                        setState(() {
                                        });
                                      },
                                      child: Icon(seePass
                                          ? Icons.visibility_off
                                          : Icons.visibility),),
                                    // prefixIcon: Icon(Icons.alternate_email_rounded,
                                    ))),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                child: TextFormField(
                                  obscureText: seePass,
                                    // labelText: "",
                                    controller: rePass,
                                    validator: (_) {
                                      if (_ == null || _.isEmpty) {
                                        return "Por favor ingrese este campo";
                                      } else {
                                        if (_.length < 6) {
                                          return "La contraseña debe tener un mínimo de 6 caracteres";
                                        }
                                        if (_ != pass.text) {
                                          return "Las contraseñas no coinciden";
                                        }
                                      }
                                    },
                                    decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), ),
                              hintText: "Contraseña",
                              // suffixIcon: Icon(Icons.alternate_email_rounded)),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        seePass = !seePass;
                                        setState(() {
                                        });
                                      },
                                      child: Icon(seePass
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    )))),
                            Container(
                                width: Get.width,
                                height: Get.height * 0.07,
                                margin: const EdgeInsets.all(40),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12))),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        controller.signUp(
                                            email.text, pass.text, name.text).then((value) => value=="Registro exitoso"? Get.offAll(()=>const HomeView()):Get.snackbar("Registro", value));
                                      }
                                    },
                                    child: const Text("Registrarme"))),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
