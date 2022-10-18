import 'package:flutter/material.dart';
import 'package:src/Pages/login.dart';

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
                    SizedBox(height: 30,),

                    // First name input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: (validFirstName) ? Colors.grey : Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'First Name',
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    // Last Name input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: (validLastName) ? Colors.grey : Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'LastName',
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    // Username input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: (validUsername) ? Colors.grey : Colors.red),
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
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    // Email input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: (validEmail) ? Colors.grey : Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    // Password input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: (validPassword) ? Colors.grey : Colors.red),
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
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    // Confirm Password input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: (validConfirmPassword) ? Colors.grey : Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                              ),
                              obscureText: true,
                            )
                        ),
                      ),
                    ),
                    (validFirstName && validLastName && validUsername && validEmail && validPassword && validConfirmPassword) ? SizedBox(height: 0) : SizedBox(height: 5),

                    // Error messages
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!validFirstName)   // Show invalid first name message if first name is empty
                              Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 14.0,
                                  ),
                                  Text(
                                    ' First Name cannot be empty',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            if (!validLastName)   // Show invalid last name message if last name is empty
                              Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 14.0,
                                  ),
                                  Text(
                                    ' Last Name cannot be empty',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            if (!validUsername)   // Show invalid Username message if username is invalid
                              Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 14.0,
                                  ),
                                  Text(
                                    ' Username already exists',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            if (!validEmail)   // Show invalid email message if email is invalid
                              Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 14.0,
                                  ),
                                  Text(
                                    ' Email already exists',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            if (!validPassword)   // Show invalid Password message if password is invalid
                              Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 14.0,
                                  ),
                                  Text(
                                    ' Password must be at least 8 characters long',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            if (!validConfirmPassword)   // Show invalid confirm password message if confirm password is not identical to Password
                              Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 14.0,
                                  ),
                                  Text(
                                    ' Passwords must be identical',
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
                    SizedBox(height: 20,),

                    // Login Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )
                          ),
                          onPressed: () {
                            (firstNameController.text.isNotEmpty) ? setState(() => validFirstName = true ) : setState(() => validFirstName = false );
                            (lastNameController.text.isNotEmpty) ? setState(() => validLastName = true ) : setState(() => validLastName = false );
                            (usernameController.text == 'username') ? setState(() => validUsername = true ) : setState(() => validUsername = false );
                            (emailController.text == 'email') ? setState(() => validEmail = true ) : setState(() => validEmail = false );
                            (passwordController.text.length >= 8) ? setState(() => validPassword = true ) : setState(() => validPassword = false );
                            (confirmPasswordController.text == passwordController.text) ? setState(() => validConfirmPassword = true ) : setState(() => validConfirmPassword = false );

                            // if all fields are valid, register successful and redirect to login page
                            if (validFirstName && validLastName && validUsername && validEmail && validPassword && validConfirmPassword) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 24),
                          )),
                    ),
                    SizedBox(height: 20,),



                  ]
              ),
            )
        )
    );
  }
}
