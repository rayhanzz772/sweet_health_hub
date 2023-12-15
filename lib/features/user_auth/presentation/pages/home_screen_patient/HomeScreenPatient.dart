import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/complaint.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/global_name.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_patient/complaint_patient.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';

String globalid = '';

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
  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xff5aaca2),
      title: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text("Sweet Health Hub"),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Icon(
                Icons.notifications_none,
                size: 30,
                color: Colors.grey, // Change to LightColor.grey if needed
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
                      Container(
                        padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                        child: Column(
                          children: [
                            TextField(
                              controller: checkidcontroller,
                              decoration: InputDecoration(
                                fillColor: Color(0xffF4F1DA),
                                filled: true,
                                hintText: 'Masukan Check id',
                              ),
                            ),
                            SizedBox(height: 20),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  globalid = checkidcontroller.text;
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Cek ID Tersimpan"),
                                      content: Text("ID telah tersimpan."),
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
                              },
                              color: Colors.blue[900],
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 10), // Spasi sebelum pesan "tersimpan"
                          ],
                        ),
                      ),

                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: kWidth2,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         color: Colors.green, width: 1),),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [],
                              ),
                            ),
                          ],
                        ),
                      ),

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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ComplaintPatient()), // Ganti DetailPage() dengan halaman tujuan Anda
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Complaint()), // Ganti DetailPage() dengan halaman tujuan Anda
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Complaint()), // Ganti DetailPage() dengan halaman tujuan Anda
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Complaint()), // Ganti DetailPage() dengan halaman tujuan Anda
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
                      IconButton(
                        onPressed: () {
                          logout(context);
                        },
                        icon: Icon(
                          Icons.logout,
                        ),
                      )

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