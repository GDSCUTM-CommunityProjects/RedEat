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
  bool hide_error = true; // Boolean to record whether an error has occured
  String error_message =
      ""; // If hide_error is false show this error message to
  // the user
  Future<String>? _loggedUser; // Used to keep track of whether a request is
  // awaiting a response or if it has received a response

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

  // Function used to either display an error message if there was a problem
  // logging in or redirect to ME page if login is successful
  void handleLogin() {
    // Check whether there is input in both the username or password field
    if (usernameController.text.length > 0 &&
        passwordController.text.length > 0) {
      setState(() {
        // The attribute will no longer be NULL. While the response is being awaited
        // and processes, _loggedUser will be some async data but won't be null.
        // as such, the page will switch to a loading bar
        _loggedUser =
            loginUser(usernameController.text, passwordController.text);
      });
      if (_loggedUser != null) {
        // Once a response is received and loginUser returns an error message, use
        // .then to work with the returned value
        _loggedUser?.then((value) {
          // If there is no error message returned we have a successful login.
          // Navigate to the ME page
          if (value == "") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => MePage()));
          } else {
            // Otherwise record the error message
            setState(() {
              error_message = value;
            });
            // Show the error message to the user
            hide_error = false;
          }
        });
      }
    }
  }

  Future<String> loginUser(String username, String password) async {
    // Send a POST request to the backend
    final response = await http.post(
      Uri.parse("${BackendURL.BACKEND_URL}api/token/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // Send the correct JSON body for the request
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    // Get response and check the status code (See README.md for background
    // on the status codes)
    // Created user successfully
    if (response.statusCode == 200) {
      return "";
      // User alredy exists
    } else {
      // Decode the response to JSON
      Map<String, dynamic> error = jsonDecode(response.body);
      // Access the error message in th JSON object
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
                    // Send request to the backend
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account yet?",
                    style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Register Now!',
                      style: TextStyle(
                        color: Colors.red,
                      )),
                ),
              ],
            ),
          ]),
        )));
  }
}
