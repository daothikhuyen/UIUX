import 'package:finaluxui/message/chat_info.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String name;
  final String avatar;

  const ChatPage({super.key, required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(avatar)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Active",
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatInfoPage(name: name)),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // ⬇️ Message list (from bottom)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              reverse: true, // ⬅⬅⬅ Tin nhắn từ dưới lên
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xff3686FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "You have concern anything?",
                      maxLines: null,
                      softWrap: true,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/d1.jpg"),
                    ),
                    const SizedBox(width: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text("Hi", maxLines: null, softWrap: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Input bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: const EdgeInsets.only(bottom: 16),
            color: Colors.white,
            child: Row(
              children: [
                _circleBtn(Icons.add, onTap: () {}),
                const SizedBox(width: 6),
                _circleBtn(Icons.camera_alt_outlined, onTap: () {}),
                const SizedBox(width: 6),
                _circleBtn(Icons.image_outlined, onTap: () {}),
                const SizedBox(width: 6),
                _circleBtn(Icons.mic_none, onTap: () {}),

                const SizedBox(width: 8),

                // Ô nhập
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'abs...',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.emoji_emotions_outlined),
                          onPressed: () {},
                          splashRadius: 18,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Nút tim
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
