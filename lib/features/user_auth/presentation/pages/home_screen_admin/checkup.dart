import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/HomeScreenAdmin.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'global_name.dart'; // Mengimpor file globals.dart
// import '/../../../../global/common/toast.dart';

class CheckUp extends StatefulWidget {
  const CheckUp({super.key});

  @override
  State<CheckUp> createState() => _CheckUpState();
}

class _CheckUpState extends State<CheckUp> {
  String namaBaru = globalName;
  bool showProgress = false;
  bool visible = false;
  String uid = '';

  // final _formkey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  final TextEditingController nama = new TextEditingController();
  final TextEditingController tension = new TextEditingController();
  final TextEditingController pulse = new TextEditingController();
  final TextEditingController respirasi = new TextEditingController();
  final TextEditingController temperature = new TextEditingController();
  final TextEditingController pemeriksaan = new TextEditingController();

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
                    "assets/images/checkup.png",
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "CHECKUP",
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
                    "Tension",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      controller: tension,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: merah,
                        filled: true,
                        hintText: 'Masukan Tensi',
                      ),
                      onSaved: (value) {
                        tension.text = value!;
                      },
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //
                  //
                  Text(
                    "Pulse",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      controller: pulse,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: biru,
                        filled: true,
                        hintText: 'Masukan Pulse',
                      ),
                      onSaved: (value) {
                        pulse.text = value!;
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
                    "Respirasi",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      controller: respirasi,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: kuning,
                        filled: true,
                        hintText: 'Masukan Respirasi',
                      ),
                      onSaved: (value) {
                        respirasi.text = value!;
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
                    "Temperature",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    // <-- TextField height
                    child: TextFormField(
                      controller: temperature,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: pink,
                        filled: true,
                        hintText: 'Masukan Temperature',
                      ),
                      onSaved: (value) {
                        temperature.text = value!;
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
                    "Pemeriksaan",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(
                      height: 200, // <-- TextField height
                      child: TextFormField(
                        controller: pemeriksaan,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF4F1DA),
                          filled: true,
                          hintText: 'Hasil Pemeriksaan',
                        ),
                        onSaved: (value) {
                          pemeriksaan.text = value!;
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
                          addDataToFirestore(
                              namaBaru,
                              tension.text,
                              pulse.text,
                              respirasi.text,
                              temperature.text,
                              pemeriksaan.text,
                              checkid,
                              uid);
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
      String username,
      String tension,
      String pulse,
      String respirasi,
      String temperature,
      String pemeriksaan,
      String checkid,
      String uid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFirestore.collection('checkup');

    await ref.add({
      'nama': username,
      'tension': tension,
      'pulse': pulse,
      'respirasi': respirasi,
      'temperature': temperature,
      'pemeriksaan': pemeriksaan,
      'checkid': checkid,
      'uid': uid
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
