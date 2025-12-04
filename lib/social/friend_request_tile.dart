import 'package:flutter/material.dart';

class FriendRequestTile extends StatelessWidget {
  final String name;
  final int followers;
  final String imageUrl;
  final VoidCallback? onTap;


  const FriendRequestTile({
    super.key,
    required this.name,
    required this.followers,
    required this.imageUrl, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(radius: 25, backgroundImage: NetworkImage(imageUrl)),
            SizedBox(width: 10), // Add space between image and text
            // Text and Follow Count
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
      
            // Accept Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF0865FE),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                backgroundColor: Colors.white,
                side: BorderSide(color: Color(0xFF0865FE)), // Outline color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Accept",
                style: TextStyle(fontSize: 14, color: Color(0xFF0865FE)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}