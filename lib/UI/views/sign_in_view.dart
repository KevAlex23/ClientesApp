// ignore_for_file: body_might_complete_normally_nullable

import 'package:customers_phones_kev/UI/views/home_view.dart';
import 'package:customers_phones_kev/UI/views/sign_up_view.dart';
import 'package:customers_phones_kev/const/const.dart';
import 'package:customers_phones_kev/controllers/sign_controller.dart';
import 'package:customers_phones_kev/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.isRelogin}) : super(key: key);
  final bool isRelogin;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  bool seePass = true;

  @override
  void initState() {
    super.initState();
    final splashController =
        widget.isRelogin ? null : Get.find<SplashController>();
    if (splashController != null) {
      splashController.dispose();
    }
    Get.put(SignController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(50))),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SizedBox(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height,
                            child: SafeArea(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                      color: bgColor,
                                    ),
                                    height: 10,
                                    width: 70,
                                  ),
                                  const Expanded(child: SignUp()),
                                ],
                              ),
                            ));
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: RichText(
                      text:
                          TextSpan(text: "¿Aún no tienes cuenta? ", children: [
                        TextSpan(
                            text: "Regístrate",
                            style: TextStyle(
                                color: Colors.indigo.shade600,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ))),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.shade400),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 400),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.shade100),
                ),
              ),
              Form(
                key: form,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Text(
                        "Test\nON OFF SOLUCIONES EN LINEA\npor Kevin\n",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                        color: primaryWhiteColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: TextFormField(
                          //style: TextStyle(color: primaryWhiteColor),
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (_) {
                            if (_ == null || _.isEmpty) {
                              return "Por favor ingrese este campo";
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "E-mail",
                              suffixIcon:
                                  const Icon(Icons.alternate_email_rounded)),
                        )),
                    Container(
                        color: primaryWhiteColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: TextFormField(
                            // labelText: "C",
                            controller: pass,
                            obscureText: seePass,
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Contraseña",
                                suffixIcon: InkWell(
                                  onTap: () {
                                    seePass = !seePass;
                                    setState(() {
                                      setState;
                                    });
                                  },
                                  child: Icon(seePass
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                )))),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        margin: const EdgeInsets.all(40),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                controller.signIn(email.text, pass.text).then(
                                    (res) => res == "Acceso exitoso"
                                        ? Get.offAll(() => const HomeView())
                                        : Get.snackbar("Ingreso", res));
                              }
                            },
                            child: const Text("Ingresar"))),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
