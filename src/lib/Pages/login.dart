import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:src/Pages/MePage.dart';

import '../BackendConnection/BackendURL.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool hide_error = true;
  String error_message = "";
  Future<String>? _loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hide_error = true;
    error_message = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() {
    if (usernameController.text.length > 0 &&
        passwordController.text.length > 0) {
      setState(() {
        _loggedUser =
            loginUser(usernameController.text, passwordController.text);
      });
      if (_loggedUser != null) {
        _loggedUser?.then((value) {
          if (value == "") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => MePage()));
          } else {
            setState(() {
              error_message = value;
            });
            hide_error = false;
          }
        });
      }
    }
  }

  Future<String> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse("${BackendURL.BACKEND_URL}api/token/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    // Created user successfully
    if (response.statusCode == 200) {
      return "";
      // User alredy exists
    } else {
      Map<String, dynamic> error = jsonDecode(response.body);
      return error['detail'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Red',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Eat',
                  style: TextStyle(
                    fontSize: 48,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            // Username input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (hide_error) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Password input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (hide_error) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    )),
              ),
            ),
            (hide_error) ? SizedBox(height: 0) : SizedBox(height: 5),

            // Error messages
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!hide_error) // Show incorrect Username message if username is incorrect
                      Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 14.0,
                          ),
                          Text(
                            error_message,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {
                    handleLogin();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
            SizedBox(
              height: 20,
            ),

            // Register Now
            Text("Don't have an account yet? Register Now!",
                style: TextStyle(color: Colors.grey)),
          ]),
        )));
  }
}
