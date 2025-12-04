import 'package:flutter/material.dart';

class SocialDevider extends StatelessWidget {
  const SocialDevider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.2,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(
          0.25,
        ), // Set the color inside BoxDecoration
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
