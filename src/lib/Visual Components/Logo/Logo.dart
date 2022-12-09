import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: const [
        Text(
          'Red',
          style: TextStyle(
            fontSize: 60,
            
            color: Colors.red,
          ),
        ),
        Text(
          'Eat',
          style: TextStyle(
            fontSize: 60,
            
          ),
        )
      ],
    );
  }
}

