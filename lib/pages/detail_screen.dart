import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var docId = Get.arguments;
    print(docId);
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('istilah')
                  .doc(docId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: size.height * 0.08,
                              decoration: BoxDecoration(
                                color: HexColor('#1BA542'),
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!['istilah'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print('aa');
                                      speak(snapshot.data!['istilah']);
                                    },
                                    icon: const Icon(
                                      Icons.record_voice_over,
                                      color: Colors.white,
                                    ),
                                    hoverColor: HexColor('#1BA542'),
                                    splashColor: HexColor('#1BA542'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Kategori : ${snapshot.data!['kategori']}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: size.height * 0.30,
                          width: size.width * 0.9,
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Text(
                                snapshot.data!['deskripsi'],
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
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
              }),
        ),
      ),
    );
  }
}
