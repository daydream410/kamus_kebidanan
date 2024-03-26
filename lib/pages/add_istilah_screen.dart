import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kamus_kebidanan/controller/add_istilah.dart';
import 'package:kamus_kebidanan/routes/route_name.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddIstilah extends StatefulWidget {
  const AddIstilah({super.key});

  @override
  State<AddIstilah> createState() => _AddIstilahState();
}

class _AddIstilahState extends State<AddIstilah> {
  final List<String> kategoriItems = [
    'Kehamilan',
    'Persalinan',
    'Nifas',
    'Lainnya',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var myController = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Tambah Istilah',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: myController.istilah.value,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter()
                  ],
                  decoration: InputDecoration(
                    labelText: "Istilah Kebidanan",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: HexColor('#1BA542'),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: myController.deskripsi.value,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter()
                  ],
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: HexColor('#1BA542'),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              // TextFormField(
              //     controller: myController.kategori.value,
              //     inputFormatters: <TextInputFormatter>[
              //       UpperCaseTextFormatter()
              //     ],
              //     decoration: InputDecoration(
              //       labelText: "Kategori",
              //       fillColor: Colors.white,
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //         borderSide: BorderSide(
              //           color: HexColor('#1BA542'),
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(25.0),
              //         borderSide: const BorderSide(
              //           color: Colors.red,
              //           width: 2.0,
              //         ),
              //       ),
              //     )),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                hint: const Text(
                  'Pilih Kategori',
                  style: TextStyle(fontSize: 14),
                ),
                items: kategoriItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Pilih kategori.';
                  }
                  return null;
                },
                onChanged: (value) {
                  myController.kategori.value.text = value.toString();
                  print(myController.kategori.value.text);
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#1BA542'),
        tooltip: 'Simpan Istilah',
        onPressed: () async {
          Get.defaultDialog(
            title: 'Simpan Istilah?',
            middleText: 'Apakah Kamu Yakin?',
            textConfirm: 'Iya',
            textCancel: 'Tidak',
            confirmTextColor: Colors.white,
            onCancel: () {
              Get.back();
            },
            onConfirm: () {
              myController.addIstilah(
                myController.istilah.value.text,
                myController.deskripsi.value.text,
                myController.kategori.value.text,
              );
              Get.back();
              Get.offAllNamed(RouteName.navbarPage);
            },
          );
        },
        child: const Icon(Icons.check, color: Colors.white, size: 28),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
