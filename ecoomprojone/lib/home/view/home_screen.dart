import 'package:ecoomprojone/home/view/Widget/home_web_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'Widget/home_phone_view.dart';
import 'Widget/home_tablet_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      
      body: LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth < 600
            ? HomePhoneView(
                controller: controller,
              )
            : constraints.maxWidth < 1024
                ? HomeTabletView(
                    controller: controller,
                  )
                : HomeWebView(controller: controller);
      }),
    );
  }
}
