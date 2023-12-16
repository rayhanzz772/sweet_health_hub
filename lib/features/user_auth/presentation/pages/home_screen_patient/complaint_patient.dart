import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/HomeScreenAdmin.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/global_name.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/HomeScreenPatient.dart';
import 'checkid_patient.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'global_name.dart'; // Mengimpor file globals.dart
// import '/../../../../global/common/toast.dart';

class ComplaintPatient extends StatefulWidget {
  const ComplaintPatient({super.key});

  @override
  State<ComplaintPatient> createState() => _ComplaintPatientState();
}

class _ComplaintPatientState extends State<ComplaintPatient> {
  bool kondisi = false;
  String idBaru = globalid;
  String nama = '';
  String complaint = '';
  String history = '';
  bool showProgress = false;
  bool visible = false;
  String uid = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final _formkey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  final TextEditingController patientcomplaint = new TextEditingController();
  final TextEditingController patienthistory = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (globalid == globalid) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alert Dialog Title'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('This is a demo alert dialog.'),
                    Text('Would you like to approve of this message?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      // Tampilkan AlertDialog pada saat aplikasi dijalankan
    });
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("complaint_history")
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
                    complaint = complaintHistory['complaint'];
                    history = complaintHistory['history'];
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
                                  "assets/images/complaint.png",
                                  width: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "COMPLAINT",
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
                                  "Patient Complaint",
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
                                    controller: patientcomplaint,
                                    maxLines: null,
                                    expands: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      fillColor: Color(0xffF4F1DA),
                                      filled: true,
                                      hintText: '$complaint',
                                    ),
                                    onSaved: (value) {
                                      patientcomplaint.text = value!;
                                    },
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Patient History",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    height: 200, // <-- TextField height
                                    child: TextFormField(
                                      enabled: false,
                                      controller: patienthistory,
                                      maxLines: null,
                                      expands: true,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: Color(0xffF4F1DA),
                                        filled: true,
                                        hintText: '$history',
                                      ),
                                      onSaved: (value) {
                                        patienthistory.text = value!;
                                      },
                                      onChanged: (value) {},
                                    ),
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
