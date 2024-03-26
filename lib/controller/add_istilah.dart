import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final istilah = TextEditingController().obs;
  final deskripsi = TextEditingController().obs;
  final kategori = TextEditingController().obs;

  Future addIstilah(String istilah, String deskripsi, String kategori) async {
    await FirebaseFirestore.instance.collection('istilah').add({
      'istilah': istilah,
      'deskripsi': deskripsi,
      'kategori': kategori,
    });
  }
}
