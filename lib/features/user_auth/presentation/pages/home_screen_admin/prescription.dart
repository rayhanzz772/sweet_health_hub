import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/HomeScreenAdmin.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'global_name.dart'; // Mengimpor file globals.dart
// import '/../../../../global/common/toast.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  String namaBaru = globalName;
  bool showProgress = false;
  bool visible = false;
  String uid = '';

  // final _formkey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  final TextEditingController nama = new TextEditingController();
  final TextEditingController prescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('username', isEqualTo: namaBaru)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Menampilkan indikator loading jika data masih dimuat
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Menampilkan pesan error jika terjadi kesalahan
              } else {
                final users = snapshot.data?.docs.toList();

                if (users != null) {
                  for (var complaintHistory in users) {
                    // Ubah bagian ini sesuai dengan struktur data di Firestore Anda
                    uid = complaintHistory['uid'];
                  }
                }

                // Kembalikan widget kosong jika tidak perlu menampilkan sesuatu
                return SizedBox.shrink();
              }
            },
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(0),
            // decoration: BoxDecoration(
            //   border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1),
            // ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 8),
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 18, right: 18, top: 65),
            // decoration: BoxDecoration(
            //   border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PATIENT COMPLAINT
                  //
                  //

                  Text(
                    "Patient prescription",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    // <-- TextField height
                    child: TextFormField(
                      controller: prescription,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        fillColor: biru,
                        filled: true,
                        hintText: 'Enter a message',
                      ),
                      onSaved: (value) {
                        prescription.text = value!;
                      },
                      onChanged: (value) {},
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
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
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 40,
                        onPressed: () {
                          setState(() {
                            showProgress = true;
                          });
                          addDataToFirestore(
                              namaBaru, prescription.text, uid, checkid);
                        },
                        child: Text(
                          "Save",
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
      ),
    ));
  }

  void addDataToFirestore(
      String username, String prescription, String uid, String checkid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFirestore.collection('prescription');

    await ref.add({
      'nama': username,
      'prescription': prescription,
      'uid': uid,
      'checkid': checkid
      // Tambahkan field lain yang ingin Anda tambahkan di sini
    }).then((value) {
      print('Data added successfully!');
    }).catchError((error) {
      print('Failed to add data: $error');
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreenAdmin()));
  }
}
