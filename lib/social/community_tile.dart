import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommunityTile extends StatelessWidget {
  final String name;
  final int followers;
  final String imageUrl;

  const CommunityTile({
    super.key,
    required this.name,
    required this.followers,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(radius: 25, backgroundImage: NetworkImage(imageUrl)),
          SizedBox(width: 10), // Space between the image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  "Follow: $followers",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Join Button
          GestureDetector(
            onTap: () {
              // Handle join action
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: SvgPicture.asset('assets/icons/Union.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
