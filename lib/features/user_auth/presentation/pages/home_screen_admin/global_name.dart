import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/HomeScreenAdmin.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_screen_admin/complaint.dart';

// Variabel global untuk menyimpan nama
String globalName = '';

void main() {
  runApp(GlobalName());
}

class GlobalName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Global Variable & Form Example'),
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
  TextEditingController nameController = TextEditingController();

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
              hintText: 'Enter your name',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                globalName =
                    nameController.text; // Memasukkan nilai ke variabel global
              });
              print('Value saved to global variable: $globalName');

              // Navigasi ke halaman selanjutnya di sini
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreenAdmin(),
                ),
              );
            },
            child: Text('Save to Global Variable and Go to Next Page'),
          ),
          SizedBox(height: 20),
          Text(
            'Global Variable Value: $globalName',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
