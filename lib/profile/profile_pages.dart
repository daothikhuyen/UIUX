import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:finaluxui/profile/app_color.dart';
import 'package:flutter/material.dart';
import 'settings_pages.dart'; // Để chuyển sang trang Settings

// ================== MÀN HÌNH CHÍNH: PROFILE ==================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      bottomNavigationBar: const BottomNavBar(selectedIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image & Avatar
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/800/400?nature'), // Thay ảnh bìa
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://picsum.photos/200?cat'), // Thay avatar
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // Name & Bio
            const Text("Trịnh Trần Phương Tuấn", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text("Bio Here", style: TextStyle(color: AppColors.textGrey)),

            const SizedBox(height: 20),

            // Buttons: Edit & Settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("Edit Profile", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsHubScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.settings, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tabs Content
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: AppColors.primaryBlue,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: AppColors.primaryBlue,
                    tabs: [Tab(text: "Post"), Tab(text: "Media")],
                  ),
                  SizedBox(
                    height: 400, // Chiều cao cố định demo
                    child: TabBarView(
                      children: [
                        _buildPostList(),
                        const Center(child: Text("Media Empty")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/200?cat'), radius: 20),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Trịnh Trần Phương Tuấn", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("2 hours ago", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Daily routine of introvert person."),
                const Text("#liveyourlife", style: TextStyle(color: AppColors.primaryBlue)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network('https://picsum.photos/400/250?coffee', fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// ================== MÀN HÌNH PHỤ: EDIT PROFILE ==================
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Edit
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const NetworkImage('https://picsum.photos/800/400?nature'),
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.darken),
                        ),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                    ),
                    const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 40),
                  ],
                ),
                Positioned(
                  bottom: -50,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://picsum.photos/200?cat')),
                      ),
                      Positioned(
                        bottom: 0, right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
                          child: const Icon(Icons.edit, color: Colors.white, size: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const Text("Trịnh Trần Phương Tuấn", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Bio Here", style: TextStyle(color: AppColors.textGrey)),
            const Divider(height: 40, indent: 20, endIndent: 20),

            // Form Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  _buildOutlineBtn("Change name"),
                  const SizedBox(height: 15),
                  _buildOutlineBtn("Change bio"),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            Image.network('https://picsum.photos/800/400?nature', height: 150),
            
            // Footer Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel", style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: const Text("Save Edit", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineBtn(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(child: Text(text, style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600))),
    );
  }
}