import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool usernameCorrect = true;
  bool passwordCorrect = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameCorrect = true;
    passwordCorrect = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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

              // Username input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: (usernameCorrect) ? Colors.grey : Colors.red),
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

              // Password input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: (passwordCorrect) ? Colors.grey : Colors.red),
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
              (usernameCorrect && passwordCorrect) ? SizedBox(height: 0) : SizedBox(height: 5),

              // Error messages
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!usernameCorrect)   // Show incorrect Username message if username is incorrect
                        Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 14.0,
                            ),
                            Text(
                              ' Incorrect Username',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      if (!passwordCorrect)   // Show incorrect Password message if password is incorrect
                        Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 14.0,
                            ),
                            Text(
                              ' Incorrect Password',
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
                    (usernameController.text == 'username') ? setState(() => usernameCorrect = true ) : setState(() => usernameCorrect = false );
                    (passwordController.text == 'password') ? setState(() => passwordCorrect = true ) : setState(() => passwordCorrect = false );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 24),
                  )),
              ),
              SizedBox(height: 20,),

              // Register Now
              Text(
                "Don't have an account yet? Register Now!",
                style: TextStyle(
                  color: Colors.grey
                )
              ),

            ]
          ),
        )
      )
    );
  }
}
