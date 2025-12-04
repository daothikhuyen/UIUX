import 'package:flutter/material.dart';

class ChatInfoPage extends StatelessWidget {
  const ChatInfoPage({super.key, required this.name});
  final String name;

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
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Avatar
            const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage("assets/images/cute.jpg"),
            ),
            const SizedBox(height: 12),
            const Text(
              "Tomo❤️row",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _IconButton(icon: Icons.videocam, label: "Video call"),
                _IconButton(icon: Icons.call, label: "Voice call"),
                _IconButton(icon: Icons.photo, label: "Media"),
                _IconButton(icon: Icons.notifications, label: "Notification"),
              ],
            ),

            const SizedBox(height: 20),

            _SectionTitle("Customize"),
            _MenuItem("Topic"),
            _MenuItem("Nickname"),
            _MenuItem("Word effects"),

            const SizedBox(height: 10),
            _SectionTitle("Others"),
            _MenuItem("Create chat group"),
            _MenuItem("Pinned news"),
            _MenuItem("View media files, likes and links"),
            _MenuItem("Mute notifications"),

            const SizedBox(height: 10),
            _SectionTitle("Privacy"),
            _MenuItem("Delete conversation", danger: true),
            _MenuItem("Block", danger: true),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Color(0xFF3686FF),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String text;
  final bool danger;

  const _MenuItem(this.text, {this.danger = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: danger ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      
    );
  }
}
