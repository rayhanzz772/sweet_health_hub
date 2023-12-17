import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/HomeScreenAdmin.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/complaint.dart';

// Variabel global untuk menyimpan nama
String globalName = '';
String checkid = '';

void main() {
  runApp(GlobalName());
}

class GlobalName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Masukan nama pasien'),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool showProgress = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController checkidcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Masukan nama pasien',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: checkidcontroller,
            decoration: InputDecoration(
              hintText: 'Masukan Check id',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                globalName = nameController.text;
                checkid = checkidcontroller.text;
              });
              setState(() {
                showProgress = true;
              });
              addDataToFirestore(globalName, checkid);
              // Navigasi ke halaman selanjutnya di sini
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreenAdmin(),
                ),
              );
            },
            child: Text('Save'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void addDataToFirestore(String username, String checkid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFirestore.collection('checkid');
    DateTime currentTime = DateTime.now();

    // Mengonversi waktu ke tipe data Timestamp
    Timestamp timestamp = Timestamp.fromDate(currentTime);

    await ref.add({
      'nama': username,
      'checkid': checkid,
      'waktu': timestamp,
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
