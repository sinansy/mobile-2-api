import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserResponse {
  String id;
  String email;
  String name;
  String avatar;

  UserResponse(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatar});

  factory UserResponse.createUserrResponse(Map<String, dynamic> object) {
    return UserResponse(
        id: object['id'].toString(),
        email: object['email'],
        name: object['first_name'] + " " + object['last_name'],
        avatar: object['avatar']);
  }

  static Future<List<UserResponse>> getUserList(String page) async {
    var apiUrl = Uri.parse("https://reqres.in/api/users?page=" + page);
    var apiResult = await http.get(apiUrl);

    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

    List<UserResponse> users = [];
    for (int i = 0; i < listUser.length; i++) {
      users.add(UserResponse.createUserrResponse(listUser[i]));
    }

    return users;
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserResponse? userResponse = null;
  List<UserResponse> userList = [];

  @override
  void initState() {
    print("init state");
    UserResponse.getUserList("1").then((value) {
      userList = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar User'),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 3, 122, 173),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Card(
                  child: Row(
                children: [
                  Image(
                      width: 100,
                      height: 100,
                      image: NetworkImage(userList[index].avatar)),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userList[index].name),
                          Text(userList[index].email)
                        ],
                      ))
                ],
              )),
            );
          }),
    );
  }
}
    
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(vsync: this);
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

 
