// ignore_for_file: invalid_use_of_protected_member

import 'package:customers_phones_kev/UI/views/customer_data_view.dart';
import 'package:customers_phones_kev/UI/widgets/custom_alert_dialog.dart';
import 'package:customers_phones_kev/const/const.dart';
import 'package:customers_phones_kev/controllers/home_controller.dart';
import 'package:customers_phones_kev/domain/models/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerListView extends GetView<HomeController> {
  CustomerListView({Key? key}) : super(key: key);
  
  RxList<Customer> auxSearchCustomers = <Customer>[].obs;
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      backgroundColor: bgColor,
      body: Obx(
        () {
          if(auxSearchCustomers.isEmpty && search.text.isEmpty)auxSearchCustomers.value = controller.myCustomers.value;
          return controller.myCustomers.isEmpty
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            controller.currrentIndex = 1;
                            controller.update(["homeView"]);
                          },
                          child: const Icon(
                            CupertinoIcons.person_add_solid,
                            size: 40,
                          )),
                      const Text(
                        "Aun no tiene clientes guardados, diríjase al tab de cliente para agregar uno nuevo.",
                        style: subTitleStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            auxSearchCustomers.value =
                                controller.myCustomers.value;
                          } else {
                            auxSearchCustomers.value = controller.myCustomers
                                .where(
                                    (element) => 
                                    element.name.contains(value))
                                .toList();
                          }
                        },
                        controller: search,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            label: const Text("Buscar cliente")),
                      ),
                    ),
                    Expanded(
                      child: auxSearchCustomers.isEmpty && search.text.isNotEmpty? Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            controller.currrentIndex = 1;
                            controller.update(["homeView"]);
                          },
                          child: const Icon(
                            CupertinoIcons.doc_text_search,
                            size: 40,
                          )),
                      const Text(
                        "No se encontró un cliente con ese nombre, diríjase al tab de cliente para agregar uno nuevo.",
                        style: subTitleStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )):ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: auxSearchCustomers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                onTap: () {
                                  controller.views[1] = CustomerDataView(
                                    editCustomer: auxSearchCustomers[index],
                                  );
                                  controller.currrentIndex = 1;
                                  controller.update(["homeView"]);
                                },
                                tileColor: primaryWhiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: CircleAvatar(
                                  child: Text(auxSearchCustomers[index]
                                      .name[0]
                                      .toUpperCase()),
                                ),
                                title: Text(
                                  auxSearchCustomers[index].name +
                                      " " +
                                      auxSearchCustomers[index].secondName +
                                      " " +
                                      auxSearchCustomers[index].lastName +
                                      " " +
                                      auxSearchCustomers[index].secondLastName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                    "Números telefónicos: ${auxSearchCustomers[index].customerPhones.length}"),
                                trailing: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      elevation: 0.0,
                                      primary: alertColor,
                                      backgroundColor: Colors.transparent,
                                      minimumSize: Size.zero, // Set this
                                      padding: EdgeInsets.zero, // and this
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return CustomAlertDialog(
                                              buttonColor: alertColor,
                                              title: "Borrar cliente",
                                              description:
                                                  "¿Esta seguro que desea\n",
                                              icon: const Icon(
                                                  Icons.delete_forever_rounded),
                                              onTap: () {
                                                Get.snackbar(
                                                    "Cliente eliminado",
                                                    controller.deleteCustomer(
                                                        auxSearchCustomers[
                                                            index]),
                                                    borderColor: alertColor,
                                                    borderWidth: 2.0);
                                              },
                                              info: auxSearchCustomers[index]
                                                  .name,
                                            );
                                          });
                                    },
                                    child: const Icon(Icons.delete_forever_rounded)),
                              ),
                            );
                          }),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
