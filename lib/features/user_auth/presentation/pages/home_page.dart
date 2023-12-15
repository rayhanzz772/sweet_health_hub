import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nama = '';
  String complaint = '';
  String history = '';
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("complaint_history")
                  .orderBy("uid")
                  .where('uid', isEqualTo: currentUser.currentUser!.uid)
                  .limit(1) // Memuat hanya satu dokumen (data terakhir)
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
                      complaint = complaintHistory['complaint'];
                      history = complaintHistory['history'];
                      nama = complaintHistory['nama'];

                      // Tambahkan widget ke dalam list clientWidgets
                      clientWidgets.add(Column(
                        children: [
                          Text(complaint),
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
            ),
            Center(
                child: Text(
              "Welcome Home $nama",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            )),
            SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(
                Icons.logout,
              ),
            )
          ],
        ));
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
