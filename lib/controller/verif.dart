import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller3 extends GetxController {
  final password = TextEditingController().obs;

  RxBool pressedBool = true.obs;
  void changeStatus() {
    pressedBool.toggle();
  }
}
