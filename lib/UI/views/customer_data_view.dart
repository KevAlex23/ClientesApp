// ignore_for_file: body_might_complete_normally_nullable

import 'package:customers_phones_kev/UI/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:customers_phones_kev/UI/widgets/custom_input.dart';
import 'package:customers_phones_kev/UI/widgets/custom_card.dart';
import 'package:customers_phones_kev/const/const.dart';
import 'package:customers_phones_kev/controllers/home_controller.dart';
import 'package:customers_phones_kev/domain/models/customer.dart';
import 'package:customers_phones_kev/domain/models/customer_phones.dart';

class CustomerDataView extends GetView<HomeController> {
  final _globalKey = GlobalKey<FormState>();

  TextEditingController document = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController secondName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController secondLastName = TextEditingController();

  List<CustomerPhone> customerPhonesAux = [];

  Customer? editCustomer;
  CustomerDataView({Key? key, this.editCustomer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editCustomer != null) {
      document = TextEditingController(text: editCustomer!.document.toString());
      name = TextEditingController(text: editCustomer!.name.toString());
      secondName =
          TextEditingController(text: editCustomer!.secondName.toString());
      lastName = TextEditingController(text: editCustomer!.lastName.toString());
      secondLastName =
          TextEditingController(text: editCustomer!.secondLastName.toString());
      customerPhonesAux.assignAll(editCustomer!.customerPhones);
    }
    return GetBuilder<HomeController>(
        id: "customerDetailsView",
        builder: (controller) {
          return Scaffold(
            backgroundColor: bgColor,
            floatingActionButton: editCustomer == null
                ? ElevatedButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: EdgeInsets.zero, // and this
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.save),
                          FittedBox(child: Text("Guardar"))
                        ],
                      ),
                    ),
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        String result = controller.saveCustomer(Customer(
                            document: int.parse(document.text),
                            name: name.text,
                            secondName: secondName.text,
                            lastName: lastName.text,
                            secondLastName: secondLastName.text));
                        Get.snackbar("Guardando Cliente", result,
                            borderColor: result ==
                                    "Cliente con el documento " +
                                        document.text +
                                        " creado correctamente"
                                ? doneColor
                                : alertColor,
                            borderWidth: 2.0);
                        controller.views[1] = CustomerDataView();
                        controller.currrentIndex = 0;
                        controller.update(["homeView"]);
                      }
                    })
                : Column(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: alertColor,
                            primary: primaryWhiteColor,
                            minimumSize: Size.zero, // Set this
                            padding: EdgeInsets.zero, // and this
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.delete_sweep_rounded),
                                FittedBox(child: Text("Borrar"))
                              ],
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return CustomAlertDialog(
                                    onTap: () {
                                      Get.snackbar(
                                          "Borrando cliente",
                                          controller
                                              .deleteCustomer(editCustomer!),
                                          borderColor: alertColor,
                                          borderWidth: 2.0);
                                    },
                                    info: editCustomer!.name,
                                    buttonColor: alertColor,
                                    title: "Borrar cliente",
                                    description: "¿Esta seguro que desea\n",
                                    icon: const Icon(
                                        Icons.delete_forever_rounded),
                                  );
                                }).whenComplete(() {
                              controller.views[1] = CustomerDataView();
                              controller.currrentIndex = 0;
                              controller.update(["homeView"]);
                            });
                          }),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero, // Set this
                            padding: EdgeInsets.zero, // and this
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.save_as_rounded),
                                FittedBox(child: Text("Editar"))
                              ],
                            ),
                          ),
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              editCustomer!.name = name.text;
                              editCustomer!.secondName = secondName.text;
                              editCustomer!.lastName = lastName.text;
                              editCustomer!.secondLastName =
                                  secondLastName.text;
                              Get.snackbar("Editando datos del cliente",
                                  controller.editCustomer(editCustomer!), borderColor: doneColor, borderWidth: 2.0);
                            }
                          })
                    ],
                  ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                CustomCardWidget(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        // Text(editCustomer!.id.toString()),
                        const Text("Datos básicos", style: subTitleStyle),
                        Row(
                          children: [
                            CustomInputField(
                                isActive: editCustomer == null ? true : false,
                                title: "Documento",
                                controller: document,
                                isRequired: true,
                                inputType: TextInputType.phone),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            CustomInputField(
                                title: "Primer nombre",
                                controller: name,
                                isRequired: true,
                                inputType: TextInputType.text),
                            CustomInputField(
                                title: "Segundo nombre",
                                controller: secondName,
                                inputType: TextInputType.text)
                          ],
                        ),
                        Row(
                          children: [
                            CustomInputField(
                                title: "Primer apellido",
                                controller: lastName,
                                isRequired: true,
                                inputType: TextInputType.text),
                            CustomInputField(
                                title: "Segundo apellido",
                                controller: secondLastName,
                                inputType: TextInputType.text)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CustomCardWidget(
                    child: Column(
                  children: [
                    const Text(
                      "Teléfonos",
                      style: subTitleStyle,
                    ),
                    for (var item in customerPhonesAux)
                      (Container(
                        margin: const EdgeInsets.all(5),
                        width: double.maxFinite,
                        child: Text(
                          item.phone.toString(),
                        ),
                      )),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: customerPhonesAux.length>4?bgColor: context.theme.primaryColor,
                          minimumSize: Size.zero, // Set this
                          padding: EdgeInsets.zero, // and this
                        ),
                        onPressed: customerPhonesAux.length > 4
                            ? () {
                                Get.snackbar("Guardar teléfonos",
                                    "No se pueden agregar mas de 5 números de telefono al cliente con documento ${document.text}",
                                    borderColor: Colors.amber,
                                    borderWidth: 2.0);
                              }
                            : () {
                               FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                if (_globalKey.currentState!.validate()) {
                                  Customer customerAux = Customer(
                                      document: int.parse(document.text),
                                      name: name.text,
                                      secondName: secondName.text,
                                      lastName: lastName.text,
                                      secondLastName: secondLastName.text);
                                  if (editCustomer == null) {
                                    controller.saveCustomer(customerAux);
                                  }
                                  final _formKeyNewPhone =
                                      GlobalKey<FormState>();
                                  showDialog(
                                          context: context,
                                          builder: (_) {
                                            TextEditingController newPhone =
                                                TextEditingController();

                                            return Scaffold(
                                              backgroundColor:
                                                  Colors.transparent,
                                              body: Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          primaryWhiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  width: Get.width * 0.7,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Text(
                                                        "Agregar número telefónico",
                                                        style: titleStyle,
                                                      ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Row(
                                                            children: [
                                                              Form(
                                                                key:
                                                                    _formKeyNewPhone,
                                                                child: Expanded(
                                                                    child:
                                                                        TextFormField(
                                                                          autofocus: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                  decoration: InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10)),
                                                                      labelText:
                                                                          "Número telefónico"),
                                                                  validator:
                                                                      (_) {
                                                                    if (_!.length <
                                                                            7 ||
                                                                        _.length >
                                                                            13) {
                                                                      return "Por favor digite un número valido";
                                                                    }
                                                                    if (_
                                                                        .isNotEmpty) {
                                                                      if (int.tryParse(
                                                                              _) ==
                                                                          null) {
                                                                        return "Por favor digite un número valido";
                                                                      }
                                                                    }
                                                                  },
                                                                  controller:
                                                                      newPhone,
                                                                )),
                                                              ),
                                                            ],
                                                          )),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            if (_formKeyNewPhone
                                                                .currentState!
                                                                .validate()) {
                                                              Get.snackbar(
                                                                  editCustomer ==
                                                                          null
                                                                      ? "Guardando cliente y número"
                                                                      : "Guardando número",
                                                                  controller.saveCustomerPhone(
                                                                      editCustomer ??
                                                                          customerAux,
                                                                      CustomerPhone(
                                                                          phone: int.parse(newPhone
                                                                              .text))),
                                                                  borderColor:
                                                                      Colors
                                                                          .greenAccent,
                                                                  borderWidth:
                                                                      2.0);
                                                              customerPhonesAux.add(
                                                                  CustomerPhone(
                                                                      phone: int.parse(
                                                                          newPhone
                                                                              .text)));
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                              Navigator.pop(
                                                                  context);
                                                                  controller.update(["customerDetailsView"]);
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Agregar"))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                      .whenComplete(() => controller
                                          .update(["customerDetailsView"]));
                                }
                              },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.add_ic_call_rounded),
                              Text("  Agregar teléfono")
                            ],
                          ),
                        )),
                  ],
                )),
              ],
            ),
          );
        });
  }
}
