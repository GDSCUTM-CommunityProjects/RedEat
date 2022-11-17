import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:src/BackendConnection/BackendURL.dart';
import 'package:src/Pages/login.dart';
import 'package:http/http.dart' as http;

import '../BackendConnection/User.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool validUsername = true;
  bool validEmail = true;
  bool validPassword = true;
  bool validConfirmPassword = true;
  bool validFirstName = true;
  bool validLastName = true;
  bool badData = false;
  Future<int>? _signupUser;

  Future<int> signupUser(String username, String password, String email,
      String first_name, String last_name) async {
    final response = await http.post(
      Uri.parse("${BackendURL.BACKEND_URL}/api/account"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'first_name': first_name,
        'last_name': last_name,
        'email': email
      }),
    );

    // Created user successfully
    if (response.statusCode == 200) {
      return 0;
    // User alredy exists 
    } else if (response.statusCode == 403) {
      return 1;
    // Malformed data or Bad request
    } else {
      return 2;
    }
  }

  FutureBuilder<int> buildFutureBuilder() {
    return FutureBuilder<int>(
      future: _signupUser,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Text("Account created successfully");
        }
        return const CircularProgressIndicator();
      }),
    );
  }

  void handleRegistration() {
    if (validFirstName &&
        validLastName &&
        validUsername &&
        validEmail &&
        validPassword &&
        validConfirmPassword) {
      setState(() {
        _signupUser = signupUser(
            usernameController.text,
            passwordController.text,
            emailController.text,
            firstNameController.text,
            lastNameController.text);
      });
      if (_signupUser != null) {
        _signupUser?.then((value) {
          if (value == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          } else if (value == 1) {
            setState(() => validUsername = false);
          } else {
            setState(() => badData = true);
          }
        });
      }
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
            child: (_signupUser == null)
                ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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

                          // First name input field
                          inputFieldTemplate("First Name", firstNameController,
                              validFirstName),
                          SizedBox(
                            height: 10,
                          ),
                          inputFieldTemplate(
                              "Last Name", lastNameController, validLastName),
                          SizedBox(
                            height: 10,
                          ),
                          inputFieldTemplate(
                              "Username", usernameController, validUsername),
                          SizedBox(
                            height: 10,
                          ),
                          inputFieldTemplate(
                              "Email", emailController, validEmail),
                          SizedBox(
                            height: 10,
                          ),
                          inputFieldTemplate(
                              "Password", passwordController, validPassword),
                          SizedBox(
                            height: 10,
                          ),
                          inputFieldTemplate("Confirm Password",
                              confirmPasswordController, validConfirmPassword),
                          SizedBox(
                            height: 10,
                          ),

                          (validFirstName &&
                                  validLastName &&
                                  validUsername &&
                                  validEmail &&
                                  validPassword &&
                                  validConfirmPassword)
                              ? SizedBox(height: 0)
                              : SizedBox(height: 5),

                          // Error messages
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!validFirstName)
                                    errorMessageTemplate(
                                        "First Name cannot be empty"),
                                  if (!validLastName)
                                    errorMessageTemplate(
                                        "Last Name cannot be empty"),
                                  if (!validUsername)
                                    errorMessageTemplate(
                                        "Username already exists"),
                                  if (!validEmail)
                                    errorMessageTemplate(
                                        "Email already exists"),
                                  if (!validPassword)
                                    errorMessageTemplate(
                                        "Password must be at least 8 characters long"),
                                  if (!validConfirmPassword)
                                    errorMessageTemplate(
                                        "Passwords must be identical"),
                                  if (badData)
                                    errorMessageTemplate(
                                        "Error creating account. Please try again"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Login Button
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                onPressed: () {
                                  (firstNameController.text.isNotEmpty)
                                      ? setState(() => validFirstName = true)
                                      : setState(() => validFirstName = false);
                                  (lastNameController.text.isNotEmpty)
                                      ? setState(() => validLastName = true)
                                      : setState(() => validLastName = false);
                                  (usernameController.text.length >
                                          8) // changed this for the time being. Should really be RegEx or something
                                      ? setState(() => validUsername = true)
                                      : setState(() => validUsername = false);
                                  (emailController.text.length >
                                          8) // Once again, this is only for testing API calls, it should be updated to verify whether the email is real
                                      ? setState(() => validEmail = true)
                                      : setState(() => validEmail = false);
                                  (passwordController.text.length >= 8)
                                      ? setState(() => validPassword = true)
                                      : setState(() => validPassword = false);
                                  (confirmPasswordController.text ==
                                          passwordController.text)
                                      ? setState(
                                          () => validConfirmPassword = true)
                                      : setState(
                                          () => validConfirmPassword = false);

                                  // if all fields are valid, register successful and redirect to login page
                                  handleRegistration();
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 24),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  )
                : buildFutureBuilder()));
  }

  Widget inputFieldTemplate(
      String fieldName, TextEditingController controller, bool valid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: (valid) ? Colors.grey : Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              obscureText:
                  (fieldName == "Password" || fieldName == "Confirm Password"),
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: fieldName,
              ),
            )),
      ),
    );
  }

  Widget errorMessageTemplate(String message) {
    return Row(
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
          size: 14.0,
        ),
        Text(
          ' ' + message,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
