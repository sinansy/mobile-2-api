import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class RegisterResponse {
  String id;
  String name;
  String job;
  String createdAt;

  RegisterResponse(
      {required this.id,
      required this.name,
      required this.job,
      required this.createdAt});

  factory RegisterResponse.createRegisterResponse(Map<String, dynamic> object) {
    return RegisterResponse(
        id: object['id'],
        name: object['name'],
        job: object['job'],
        createdAt: object['createdAt']);
  }

  static Future<RegisterResponse> connectToAPI(String name, String job) async {
    var apiUrl = Uri.parse("https://reqres.in/api/users");
    var apiResult = await http.post(apiUrl, body: {"name": name, "job": job});

    var jsonObject = json.decode(apiResult.body);

    return RegisterResponse.createRegisterResponse(jsonObject);
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterResponse? registerResponse = null;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

// @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Screen',
          // style: TextStyle(color: Color.fromARGB(255, 61, 15, 0)),
        ),
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 130, 3, 173),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Enter your name',
                        labelText: 'Name',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: jobController,
                    decoration: InputDecoration(
                      hintText: 'Enter your job',
                      labelText: 'Job',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 233, 233, 233),
                        ),
                        onPressed: () {
                          RegisterResponse.connectToAPI(
                                  nameController.text, jobController.text)
                              .then((value) {
                            registerResponse = value;
                            setState(() {});
                          });
                        },
                        child: Text('Submit',
                            style: TextStyle(
                              color: Color.fromARGB(255, 6, 6, 0),
                              fontWeight: FontWeight.w200,
                            ))),
                  ),
                  SizedBox(height: 10),
                  Text(registerResponse == null
                      ? 'No Data'
                      : registerResponse!.id +
                          ' | Nama saya ' +
                          registerResponse!.name +
                          ' | Pekerjaan Saya ' +
                          registerResponse!.job +
                          ' | ' +
                          registerResponse!.createdAt)
                ],
              ))
        ],
      ),
    );
  }
}



 


  //   with SingleTickerProviderStateMixin {
      
  // late AnimationController _controller;

  