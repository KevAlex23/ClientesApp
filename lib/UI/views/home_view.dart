import 'package:customers_phones_kev/UI/views/customer_data_view.dart';
import 'package:customers_phones_kev/UI/views/logs_view.dart';
import 'package:customers_phones_kev/UI/views/sign_in_view.dart';
import 'package:customers_phones_kev/UI/widgets/custom_alert_dialog.dart';
import 'package:customers_phones_kev/const/const.dart';
import 'package:customers_phones_kev/controllers/home_controller.dart';
import 'package:customers_phones_kev/controllers/log_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController =
      Get.put<HomeController>(HomeController(Get.find(), Get.find()));
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "homeView",
        builder: (controller) {
          return Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              title: const Text("Clientes App"),
              centerTitle: true,
              leading: IconButton(onPressed: (){
                Get.put(LogController());
                Get.to(()=> const LogsView())!.whenComplete(() => Get.delete<LogController>());
              }, icon: const Icon(Icons.history_edu_rounded)),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return CustomAlertDialog(
                              buttonColor: Colors.blue,
                                title: "Cerrar sesión",
                                description: "Esta seguro que desea\n",
                                icon: const Icon(Icons.exit_to_app_rounded),
                                onTap: () {
                                  controller.signOut().then((value) => value ==
                                          "Sesión cerrada"
                                      ? Get.offAll(() => const SignIn(
                                            isRelogin: true,
                                          ))
                                      : Get.snackbar("Cerrar sesión", value));
                                });
                          });
                    },
                    icon: const Icon(Icons.logout_rounded))
              ],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: BottomNavigationBar(
                  onTap: (_) {
                    if(_==0){
                      controller.views[1] =CustomerDataView();
                    }
                    controller.currrentIndex = _;
                    controller.update(["homeView"]);
                  },
                  currentIndex: controller.currrentIndex,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.list_alt_rounded,
                        ),
                        label: "Clientes"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_rounded), label: "Cliente")
                  ]),
            ),
            body: controller.views[controller.currrentIndex],
          );
        });
  }
}
