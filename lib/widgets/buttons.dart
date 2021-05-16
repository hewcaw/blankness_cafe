import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  MyBackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xff121212),
        // border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: IconButton(icon: Icon(Icons.arrow_back, size: 16), onPressed: this.onPressed),
    );
  }
}
