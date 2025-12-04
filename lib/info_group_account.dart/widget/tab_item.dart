import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const TabItem(this.title, {super.key, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }
}
