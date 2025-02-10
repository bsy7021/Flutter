import 'package:flutter/material.dart';

class Snackbar {

  final String text;
  final IconData icon;
  final int duration;
  final Color backgroundColor;
  final Color color;

  Snackbar({
    required this.text, 
    this.icon = Icons.info, 
    this.duration = 3,
    this.backgroundColor = Colors.blueAccent,
    this.color = Colors.white,
  });


  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
        duration: Duration(seconds: duration),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

}
