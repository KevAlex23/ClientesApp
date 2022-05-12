import 'package:customers_phones_kev/const/const.dart';
import 'package:customers_phones_kev/controllers/log_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogsView extends GetView<LogController> {
  const LogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clientes App\nLog", style: titleStyle, textAlign: TextAlign.center,),
        shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: controller.getLogs().isEmpty?const Center(child: Text("No hay logs actualmente"),) : ListView.builder(
          itemCount: controller.getLogs().length,
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                tileColor: primaryWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(controller.getLogs()[index].logDescription),
                subtitle: Text(controller.getLogs()[index].logDate),
              ),
            );
          }),
    );
  }
}
