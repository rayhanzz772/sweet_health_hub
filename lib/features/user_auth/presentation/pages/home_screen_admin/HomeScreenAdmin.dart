import 'package:flutter/material.dart';
import 'package:flutter_firebase/constants.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/complaint.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/global_name.dart';

class HomeScreenAdmin extends StatelessWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          content: Text(
              'Dalam 2 minggu terakhir, seberapa sering Anda terganggu oleh masalah-masalah berikut?'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Keterangan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
                                                        'Halo, Admin',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            color:
                                                                Color.fromARGB(
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
                                              GlobalName()), // Ganti DetailPage() dengan halaman tujuan Anda
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
}
