import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;              // 버튼 텍스트
  final VoidCallback onPressed;   // 버튼 클릭 시 호출할 함수
  final isFullWidth;              // 버튼을 꽉 채울지 여부
  final color;                    // 버튼 색상
  final backgroundColor;          // 버튼 배경 색상

  const CustomButton({
    super.key, 
    required this.text, 
    required this.onPressed, 
    this.isFullWidth,
    this.color = Colors.white,
    this.backgroundColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth == true ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: Text(text),
      ),
    );
  }
}

