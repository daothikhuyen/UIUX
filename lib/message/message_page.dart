import 'package:finaluxui/message/chat_page.dart';
import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  // Dữ liệu ảo
  final List<Map<String, String>> recentMessages = [
    {
      "name": "Group Chat",
      "avatar": "assets/images/cute.jpg",
      "message": "Hello!",
      "time": "09:40",
      "status": "active",
    },
    {
      "name": "Alice",
      "avatar": "assets/images/d1.jpg",
      "message": "Good morning 🌞",
      "time": "08:30",
      "status": "active",
    },
    {
      "name": "Bob",
      "avatar": "assets/images/cute.jpg",
      "message": "Let's catch up!",
      "time": "Yesterday",
      "status": "inactive",
    },
  ];

  final List<Map<String, String>> stories = const [
    {"name": "you", "avatar": "assets/images/d1.jpg", "status": "active"},
    {"name": "Bob", "avatar": "assets/images/d1.jpg", "status": "active"},
    {
      "name": "Charlie",
      "avatar": "assets/images/cute.jpg",
      "status": "inactive",
    },
    {"name": "Daisy", "avatar": "assets/images/cute.jpg", "status": "active"},
    {"name": "Eve", "avatar": "assets/images/cute.jpg", "status": "inactive"},
    {"name": "Frank", "avatar": "assets/images/d1.jpg", "status": "active"},
    {"name": "Grace", "avatar": "assets/images/d1.jpg", "status": "inactive"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Message",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),

            // Story avatars
            SizedBox(
              height: 95,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: stories.length,
                itemBuilder: (_, index) {
                  final story = stories[index];
                  final isYou = story["name"]!.toLowerCase() == "you";
                  final status = story["status"];

                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Avatar gốc
                            CircleAvatar(
                              radius: 36,
                              backgroundImage: AssetImage(story["avatar"]!),
                            ),
                            // Lớp màn đen mờ nếu là You
                            if (isYou)
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                    0.4,
                                  ), // ⬅ lớp màn đen mờ
                                  shape: BoxShape.circle,
                                ),
                              ),
                            // Icon trái tim
                            if (isYou)
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset(
                                  'assets/icons/Vector.svg',
                                ),
                              ),

                            if (!isYou)
                              // Icon trạng thái ở góc dưới phải
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 10,
                                    color:
                                        status == "active"
                                            ? Colors.red
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          story["name"]!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isYou ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Recently",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // Recent messages list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentMessages.length,
              itemBuilder: (_, index) {
                final msg = recentMessages[index];
                final status =
                    msg["status"] ?? "inactive"; // Ensure status is available

                return ListTile(
                  leading: Stack(
                    children: [
                      // Profile image
                      CircleAvatar(
                        backgroundImage: AssetImage(msg["avatar"]!),
                        radius: 26,
                      ),

                      // Positioning the status icon (heart) at the bottom-right corner
                      Positioned(
                        top: -2,
                        right: -4,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 10,
                            color:
                                status == "active" ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text(msg["name"]!),
                  subtitle: Text(msg["message"]!),
                  trailing: Text(msg["time"]!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ChatPage(
                              name: msg["name"]!,
                              avatar: msg["avatar"]!,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
