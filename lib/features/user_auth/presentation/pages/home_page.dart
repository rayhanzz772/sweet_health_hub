import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Mendapatkan pengguna saat ini
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("HomePage"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Welcome Home Patient!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            )),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('complaint_history')
                  .where('uid', isEqualTo: currentUser.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Menampilkan indikator loading jika data masih dimuat
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Menampilkan pesan error jika terjadi kesalahan
                } else {
                  List<Widget> clientWidgets =
                      []; // List untuk menampung widget yang akan ditampilkan
                  final clients = snapshot.data?.docs.toList();

                  if (clients != null) {
                    for (var complaintHistory in clients) {
                      // Ubah bagian ini sesuai dengan struktur data di Firestore Anda
                      String complaint = complaintHistory['complaint'];
                      String history = complaintHistory['history'];
                      String nama = complaintHistory['nama'];

                      // Tambahkan widget ke dalam list clientWidgets
                      clientWidgets.add(Column(
                        children: [
                          Text(complaint),
                          Text(history),
                          Text(nama),
                        ],
                      ));
                    }
                  }

                  return Column(
                    children:
                        clientWidgets, // Tampilkan widget yang telah ditambahkan ke dalam Column
                  );
                }
              },
            )
          ],
        ));
  }
}
