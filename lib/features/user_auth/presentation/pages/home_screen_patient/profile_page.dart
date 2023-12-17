import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/HomeScreenAdmin.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/HomeScreenPatient.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'global_name.dart'; // Mengimpor file globals.dart
// import '/../../../../global/common/toast.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool showProgress = false;
  bool visible = false;
  String uid = '';

  final TextEditingController tinggibadan = new TextEditingController();
  final TextEditingController beratbadan = new TextEditingController();
  final TextEditingController lainlain = new TextEditingController();

  final currentUser = FirebaseAuth.instance;
  String tinggibadan2 = '';
  String beratbadan2 = '';
  String lainlain2 = '';
  String nama = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //
          //
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('uid', isEqualTo: currentUser.currentUser!.uid)
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
                    nama = complaintHistory['username'];
                    email = complaintHistory['email'];
                    // Tambahkan widget ke dalam list clientWidgets
                    clientWidgets.add(Row(
                      children: [],
                    ));
                  }
                }

                return Row(
                  children:
                      clientWidgets, // Tampilkan widget yang telah ditambahkan ke dalam Column
                );
              }
            },
          ),
          //
          //
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("profile")
                .where('uid', isEqualTo: currentUser.currentUser!.uid)
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
                    tinggibadan2 = complaintHistory['tinggibadan'];
                    beratbadan2 = complaintHistory['beratbadan'];
                    lainlain2 = complaintHistory['lainlain'];
                    // Tambahkan widget ke dalam list clientWidgets
                    clientWidgets.add(Row(
                      children: [],
                    ));
                  }
                }

                return Row(
                  children:
                      clientWidgets, // Tampilkan widget yang telah ditambahkan ke dalam Column
                );
              }
            },
          ),
          //
          //
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
              padding: const EdgeInsets.only(left: 25.0, right: 8),
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "PROFILE",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 18, right: 18, top: 25),
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
                    "Nama",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      enabled: false,
                      // controller: tension,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: merah,
                        filled: true,
                        hintText: '$nama',
                      ),
                      // onSaved: (value) {
                      //   tension.text = value!;
                      // },
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //
                  //
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      enabled: false,

                      // controller: pulse,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: biru,
                        filled: true,
                        hintText: '$email',
                      ),
                      // onSaved: (value) {
                      //   pulse.text = value!;
                      // },
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
                  Text(
                    "Tinggi Badan",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      controller: tinggibadan,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: kuning,
                        filled: true,
                        hintText: '$tinggibadan2',
                      ),
                      onSaved: (value) {
                        tinggibadan.text = value!;
                      },
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
                  Text(
                    "Berat badan",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      controller: beratbadan,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: pink,
                        filled: true,
                        hintText: '$beratbadan2',
                      ),
                      onSaved: (value) {
                        beratbadan.text = value!;
                      },
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
                  //
                  //
                  //
                  //
                  //
                  Text(
                    "Lain-lain",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(
                      height: 200, // <-- TextField height
                      child: TextFormField(
                        controller: lainlain,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF4F1DA),
                          filled: true,
                          hintText: '$lainlain2',
                        ),
                        onSaved: (value) {
                          lainlain.text = value!;
                        },
                        onChanged: (value) {},
                      ),
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
                        },
                        child: Text(
                          "Reload",
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
                          addDataToFirestore(nama, currentUser.currentUser!.uid,
                              tinggibadan.text, beratbadan.text, lainlain.text);
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

  void addDataToFirestore(String nama, String uid, String tinggibadan,
      String beratbadan, String lainlain) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFirestore.collection('profile');

    await ref.add({
      'nama': nama,
      'uid': uid,
      'tinggibadan': tinggibadan,
      'beratbadan': beratbadan,
      'lainlain': lainlain,

      // Tambahkan field lain yang ingin Anda tambahkan di sini
    }).then((value) {
      print('Data added successfully!');
    }).catchError((error) {
      print('Failed to add data: $error');
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreenPatient()));
  }
}
