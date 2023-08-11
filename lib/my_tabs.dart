import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  const AppTabs({super.key , required this.color , required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:100,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white, fontSize: 17 , fontWeight: FontWeight.w800 ,),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: this.color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
            offset: Offset(0,0),
          ),
        ],
      ),
    );
  }
}
