// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kamus_kebidanan/routes/route_name.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var searchLog = "";
  var docId = '';
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
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
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
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchLog = value.capitalize!;
                        });
                        print(searchLog);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        border: OutlineInputBorder(),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('istilah')
                    .orderBy('istilah')
                    .startAt([searchLog]).endAt(
                        ["$searchLog\uf8ff"]).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(
                                snapshot.data!.docs[index]['istilah'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                docId = snapshot.data!.docs[index].reference.id;
                                print(docId);
                                Get.toNamed(RouteName.detailPage,
                                    arguments: docId);
                              },
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  docId =
                                      snapshot.data!.docs[index].reference.id;
                                  print(docId);
                                  Get.toNamed(RouteName.detailPage,
                                      arguments: docId);
                                },
                                color: HexColor('#1BA542'),
                                hoverColor: HexColor('#1BA542'),
                                splashColor: HexColor('#1BA542'),
                              ),
                              tileColor: Colors.white,
                              textColor: Colors.black,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.hasError.toString()),
                      );
                    } else {
                      return const Center(
                          child: Text(
                        "Tidak Ada Antrian",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ));
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
