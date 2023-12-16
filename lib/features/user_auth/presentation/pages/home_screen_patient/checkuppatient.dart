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

class CheckUpPatient extends StatefulWidget {
  const CheckUpPatient({super.key});

  @override
  State<CheckUpPatient> createState() => _CheckUpPatientState();
}

class _CheckUpPatientState extends State<CheckUpPatient> {
  String idBaru = globalid;
  String nama = '';

  String tension = '';
  String pulse = '';
  String respirasi = '';
  String temperature = '';
  String pemeriksaan = '';

  bool showProgress = false;
  bool visible = false;
  String uid = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final _formkey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  final TextEditingController patienttension = new TextEditingController();
  final TextEditingController patientpulse = new TextEditingController();
  final TextEditingController patientrespirasi = new TextEditingController();
  final TextEditingController patienttemperature = new TextEditingController();
  final TextEditingController patientpemeriksaan = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("checkup")
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
                    tension = complaintHistory['tension'];
                    pulse = complaintHistory['pulse'];
                    respirasi = complaintHistory['respirasi'];
                    temperature = complaintHistory['temperature'];
                    pemeriksaan = complaintHistory['pemeriksaan'];

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
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                Text(
                                  "Tension",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  // <-- TextField height
                                  child: TextFormField(
                                    enabled: false,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      fillColor: merah,
                                      filled: true,
                                      hintText: '$tension',
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //
                                //
                                //
                                //
                                //
                                //
                                Text(
                                  "Pulse",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  // <-- TextField height
                                  child: TextFormField(
                                    enabled: false,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      fillColor: merah,
                                      filled: true,
                                      hintText: '$pulse',
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //
                                //
                                //
                                //
                                //
                                //
                                Text(
                                  "Respirasi",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  // <-- TextField height
                                  child: TextFormField(
                                    enabled: false,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      fillColor: merah,
                                      filled: true,
                                      hintText: '$respirasi',
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //
                                //
                                //
                                //
                                //
                                //
                                Text(
                                  "Temperature",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  // <-- TextField height
                                  child: TextFormField(
                                    enabled: false,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      fillColor: merah,
                                      filled: true,
                                      hintText: '$temperature',
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //
                                //
                                //
                                //
                                //
                                //

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
                                      maxLines: null,
                                      expands: true,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: Color(0xffF4F1DA),
                                        filled: true,
                                        hintText: '$pemeriksaan',
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),

                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                //
                                //

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
