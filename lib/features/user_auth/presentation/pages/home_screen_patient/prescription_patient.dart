import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/HomeScreenAdmin.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/HomeScreenPatient.dart';
import 'checkid_patient.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'global_name.dart'; // Mengimpor file globals.dart
// import '/../../../../global/common/toast.dart';

class PrescriptionPatient extends StatefulWidget {
  const PrescriptionPatient({super.key});

  @override
  State<PrescriptionPatient> createState() => _PrescriptionPatientState();
}

class _PrescriptionPatientState extends State<PrescriptionPatient> {
  String idBaru = globalid;
  String nama = '';

  String prescription = '';

  bool showProgress = false;
  bool visible = false;
  String uid = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final _formkey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  final TextEditingController patientprescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("prescription")
                .where('uid', isEqualTo: currentUser.currentUser!.uid)
                .where('checkid', isEqualTo: idBaru)
                .limit(1) // Memuat hanya satu dokumen (data terakhir)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    prescription = complaintHistory['prescription'];
                    nama = complaintHistory['nama'];

                    // Tambahkan widget ke dalam list clientWidgets
                    clientWidgets.add(Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1),
                          // ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 8),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/prescription.png",
                                  width: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "PRESCRIPTION",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 18, right: 18, top: 25),
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PATIENT PRESCRIPTION",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: 200,
                                  // <-- TextField height
                                  child: TextFormField(
                                    enabled: false,
                                    maxLines: null,
                                    expands: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      fillColor: biru,
                                      filled: true,
                                      hintText: '$prescription',
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      height: 40,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Back",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      color: Color(0xff5AACA2),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
        ],
      ),
    ));
  }
}
