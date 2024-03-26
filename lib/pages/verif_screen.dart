import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamus_kebidanan/controller/verif.dart';
import 'package:kamus_kebidanan/routes/route_name.dart';

class VerifPage extends StatefulWidget {
  const VerifPage({super.key});

  @override
  State<VerifPage> createState() => _VerifPageState();
}

final myController = Get.put(Controller3());

class _VerifPageState extends State<VerifPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text(
            'MY BIDANPEDIA',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ],
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('password')
                  .doc('pw')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Obx(() => TextField(
                          controller: myController.password.value,
                          obscureText: myController.pressedBool.isTrue,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                myController.changeStatus();
                              },
                              icon: myController.pressedBool.isTrue
                                  ? const Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      size: 20,
                                    ),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          onSubmitted: (value) {
                            if (value == snapshot.data!['pw']) {
                              Get.toNamed(RouteName.inputPage);
                              myController.password.value.clear();
                            } else {
                              Get.snackbar(
                                'Error',
                                'Wrong Password',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                        ));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
