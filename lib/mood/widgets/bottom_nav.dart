import 'package:finaluxui/home/home_page_screen.dart';
import 'package:finaluxui/message/message_page.dart';
import 'package:finaluxui/mood/dashboard_mood.dart';
import 'package:finaluxui/mood/mood_home.dart';
import 'package:finaluxui/profile/profile_pages.dart';
import 'package:finaluxui/social/social_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  // Danh sách pages
  final List<Widget> pages = [
    HomePage(),
    MessagePage(),
    SocialPage(),
    MoodScreen(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    if (index == selectedIndex) return;
    setState(() {
      selectedIndex = index;
    });
    // Chuyển sang page tương ứng
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isSelected: selectedIndex == 0,
            onTap: () => onTabTapped(0),
          ),
          NavBarItem(
            icon: Icons.chat_bubble_outline,
            label: 'Message',
            isSelected: selectedIndex == 1,
            onTap: () => onTabTapped(1),
          ),
          NavBarItem(
            icon: Icons.group_outlined,
            label: 'Social',
            isSelected: selectedIndex == 2,
            onTap: () => onTabTapped(2),
          ),
          NavBarItem(
            icon: Icons.sentiment_satisfied_alt,
            label: 'Mood',
            isSelected: selectedIndex == 3,
            onTap: () => onTabTapped(3),
          ),
          NavBarItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isSelected: selectedIndex == 4,
            onTap: () => onTabTapped(4),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
