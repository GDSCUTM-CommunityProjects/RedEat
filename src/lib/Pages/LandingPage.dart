import 'package:flutter/material.dart';

import '../Visual Components/Buttons/MenuButton.dart';
import '../Visual Components/Logo/Logo.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      color: Color.fromARGB(255, 227, 227, 227),
      child: Column(children: <Widget>[
        Container(
          color: Color.fromARGB(255, 191, 188, 188),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                SizedBox(height: 30),
                Logo(),
                SizedBox(
                  height: 20,
                ),
                DefaultTextStyle(
                  style: TextStyle(),
                  child: const Text(
                    "Find your healthy foods",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 167, 89, 89),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 1.7,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: MenuButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/login', // Defer to the login route defined in main.dart
                        );
                      },
                      buttonTitle: 'Login'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: MenuButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/signup', // need a register page
                      );
                    },
                    buttonTitle: 'Sign Up',
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
