import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/complaint.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/global_name.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/prescription.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/checkuppatient.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/complaint_patient.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/diagnosis_patient.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/prescription_patient.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';

String globalid = '';
String checkiddatabase = 'none';
bool idEntered = false;

class HomeScreenPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _Patient createState() => _Patient();
}

class _Patient extends State<MyForm> {
  List<String> checkIdList = [];
  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Color.fromRGBO(138, 196, 189, 71),
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 8),
        child: Image.asset(
          'assets/images/logo.png', // Ganti dengan path gambar Anda
          width: 50, // Sesuaikan lebar gambar
          height: 50, // Sesuaikan tinggi gambar
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text("Sweet Health Hub"),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: Icon(
                  Icons.logout,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0), // Add padding here
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController checkidcontroller = TextEditingController();
    String nama = '';
    // String complaint = '';
    // String history = '';
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentUser = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String uid = currentUser.currentUser!.uid;
    double kWidth = MediaQuery.of(context).size.width * 0.44;
    double kWidth2 = MediaQuery.of(context).size.width * 0.95;

    // double kButtonWidth = MediaQuery.of(context).size.width * 0.892;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: _appBar(context),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .orderBy("uid")
                            .where('uid',
                                isEqualTo: currentUser.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                // Tambahkan widget ke dalam list clientWidgets
                                clientWidgets.add(Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Halo, $nama',
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      155,
                                                                      155,
                                                                      155)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                      //
                      //
                      //
                      //
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("checkid")
                            .orderBy("waktu",
                                descending:
                                    true) // Urutkan berdasarkan timestamp descending
                            .where('nama',
                                isEqualTo:
                                    nama) // Filter data berdasarkan field 'nama'
                            .limit(
                                1) // Ambil hanya 1 dokumen (yang memiliki timestamp terbaru)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                checkiddatabase = complaintHistory['checkid'];

                                // Tambahkan widget ke dalam list clientWidgets
                                clientWidgets.add(Column(
                                  children: [],
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
                      //
                      //
                      //
                      //
                      //
                      //
                      // Text('$checkiddatabase'),
                      Container(
                        padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                        child: Container(
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: checkidcontroller,
                                    decoration: InputDecoration(
                                      fillColor: Color(0xffF4F1DA),
                                      filled: true,
                                      hintText: 'Masukan Check id',
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 245, 98)),
                                        borderRadius:
                                            new BorderRadius.circular(10),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: const Color.fromARGB(
                                                255, 186, 186, 186)),
                                        borderRadius:
                                            new BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        10), // Spasi antara TextField dan tombol
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  elevation: 0,
                                  height: 40,
                                  onPressed: () {
                                    setState(() {
                                      globalid = checkidcontroller.text;
                                    });
                                    if (globalid == '$checkiddatabase') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Cek ID Tersimpan"),
                                            content:
                                                Text("ID telah tersimpan."),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      idEntered = true;
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("ERROR"),
                                            content: Text(
                                                "DATA TIDAK ADA ATAU KADALUARSA"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      idEntered = false;
                                    }
                                  },
                                  color: hijau,
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //       color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        // ),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.05,
                            // Responsif: 5% lebar layar sebagai padding kiri
                          ),
                          // 2 Kolom pertama Complaint dan Check-up
                          child: Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: idEntered
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ComplaintPatient()), // Ganti DetailPage() dengan halaman tujuan Anda
                                          );
                                        }
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Pesan'),
                                                content: Text(
                                                    'ISI CHECK ID TERLEBIH DAHULU.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Tutup'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                  child: Row(
                                    children: [
                                      Container(
                                        // hitam
                                        width: kWidth,
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //     color: Colors.red, width: 0.5),
                                          color: Color(0xfff4d4d4),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          // hijau
                                          children: [
                                            Padding(
                                              // hijau 1
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/complaint.png",
                                                    width: 100,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              // hijau 2
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "COMPLAINT",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: idEntered
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckUpPatient()), // Ganti DetailPage() dengan halaman tujuan Anda
                                          );
                                        }
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Pesan'),
                                                content: Text(
                                                    'ISI CHECK ID TERLEBIH DAHULU.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Tutup'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                  child: Row(
                                    children: [
                                      Container(
                                        // hitam
                                        width: kWidth,
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //     color: Colors.red, width: 0.5),
                                          color: Color(0xffC1Daeb),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          // hijau
                                          children: [
                                            Padding(
                                              // hijau 1
                                              padding: const EdgeInsets.only(
                                                  top: 26,
                                                  bottom: 10,
                                                  right: 10,
                                                  left: 5),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/checkup.png",
                                                    width: 130,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              // hijau 2
                                              padding: const EdgeInsets.only(
                                                  top: 0, bottom: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "CHECK UP",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 21),

                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //       color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        // ),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.05,
                            // Responsif: 5% lebar layar sebagai padding kiri
                          ),
                          // 2 Kolom pertama Complaint dan Check-up
                          child: Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: idEntered
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DiagnosisPatient()), // Ganti DetailPage() dengan halaman tujuan Anda
                                          );
                                        }
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Pesan'),
                                                content: Text(
                                                    'ISI CHECK ID TERLEBIH DAHULU.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Tutup'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                  child: Row(
                                    children: [
                                      Container(
                                        // hitam
                                        width: kWidth,
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //     color: Colors.red, width: 0.5),
                                          color: Color(0xfff4f1da),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          // hijau
                                          children: [
                                            Padding(
                                              // hijau 1
                                              padding: const EdgeInsets.only(
                                                  bottom: 13, top: 12),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/diagnosis.png",
                                                    width: 120,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              // hijau 2
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "DIAGNOSIS",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: idEntered
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PrescriptionPatient()), // Ganti DetailPage() dengan halaman tujuan Anda
                                          );
                                        }
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Pesan'),
                                                content: Text(
                                                    'ISI CHECK ID TERLEBIH DAHULU.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Tutup'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                  child: Row(
                                    children: [
                                      Container(
                                        // hitam
                                        width: kWidth,
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //     color: Colors.red, width: 0.5),
                                          color: Color(0xfff4dad0),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          // hijau
                                          children: [
                                            Padding(
                                              // hijau 1
                                              padding: const EdgeInsets.only(
                                                  top: 26,
                                                  bottom: 10,
                                                  right: 10,
                                                  left: 5),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/prescription.png",
                                                    width: 118,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              // hijau 2
                                              padding: const EdgeInsets.only(
                                                  top: 0, bottom: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "PRESCRIPTION",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //
                      ///
                      ///
                      ///
                      ///
                      // Riwayat
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ///
  ///
  //////
  ////
  ////
  ///
  ////

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
