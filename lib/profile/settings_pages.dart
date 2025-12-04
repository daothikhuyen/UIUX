import 'package:finaluxui/profile/app_color.dart';
import 'package:flutter/material.dart';

// ================== 1. SETTINGS HUB (Màn hình chính) ==================
class SettingsHubScreen extends StatelessWidget {
  const SettingsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),

              // Menu Items
              _SettingTile(
                title: "Notifications",
                icon: Icons.notifications_outlined,
                onTap:
                    () => _navTo(
                      context,
                      const GenericSettingPage(
                        type: SettingType.notification,
                        title: "Notifications",
                      ),
                    ),
              ),
              _SettingTile(
                title: "Activities",
                icon: Icons.show_chart,
                onTap:
                    () => _navTo(
                      context,
                      const GenericSettingPage(
                        type: SettingType.activity,
                        title: "Activities",
                      ),
                    ),
              ),
              _SettingTile(
                title: "Privacy & Safety",
                icon: Icons.lock_outline,
                onTap:
                    () => _navTo(
                      context,
                      const GenericSettingPage(
                        type: SettingType.privacy,
                        title: "Privacy & Safety",
                      ),
                    ),
              ),
              _SettingTile(
                title: "Security",
                icon: Icons.security,
                onTap:
                    () => _navTo(
                      context,
                      const GenericSettingPage(
                        type: SettingType.security,
                        title: "Security",
                      ),
                    ),
              ),
              _SettingTile(
                title: "About",
                icon: Icons.info_outline,
                onTap:
                    () => _navTo(
                      context,
                      const GenericSettingPage(
                        type: SettingType.about,
                        title: "About",
                      ),
                    ),
              ),

              const SizedBox(height: 20),
              // Illustration & Login
              // Image.network('https://illustrations.popsy.co/amber/surr-people.png', height: 100),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Logins",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add or switch accounts",
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Log out",
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Log out all accounts",
                      style: TextStyle(color: AppColors.primaryBlue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

// ================== 2. GENERIC SETTING PAGE (Dùng chung cho các trang con) ==================
enum SettingType { notification, activity, privacy, security, about }

class GenericSettingPage extends StatelessWidget {
  final String title;
  final SettingType type;

  const GenericSettingPage({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (type != SettingType.about) _buildSearchBar(),
            const SizedBox(height: 20),

            // Nội dung thay đổi theo loại trang
            Expanded(child: _buildContent()),

            // Hình minh họa thay đổi theo loại trang
            // SizedBox(height: 150, child: _getIllustration()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (type) {
      case SettingType.notification:
        return Column(
          children: const [
            _SettingTile(
              title: "Turn on notification",
              isSwitch: true,
              switchValue: true,
            ),
            _SettingTile(title: "Silent Hours", subtitle: "20:00 - 6:00"),
            _SettingTile(title: "Mute"),
            _SettingTile(title: "Comment, reminder"),
            _SettingTile(title: "Notification sound", trailingText: "default"),
          ],
        );
      case SettingType.activity:
        return Column(
          children: const [
            _SettingTile(
              title: "Turn on activity status",
              isSwitch: true,
              switchValue: true,
            ),
            _SettingTile(
              title: "Location\nfor us can contact nearest center",
              isSwitch: true,
              switchValue: true,
            ),
            _SettingTile(title: "Activities log"),
          ],
        );
      case SettingType.privacy:
        return Column(
          children: const [
            _SettingTile(
              title: "Audience & media",
              subtitle: "information you allow other people to see",
            ),
            _SettingTile(
              title: "Your post",
              subtitle: "information associated with your post",
            ),
            _SettingTile(title: "Content you see"),
            _SettingTile(title: "Mute & block"),
            _SettingTile(title: "Bad word filter", trailingText: "default"),
          ],
        );
      case SettingType.security:
        return Column(
          children: const [
            _SettingTile(title: "Manage account"),
            _SettingTile(title: "PIN for open app", trailingText: "off"),
            _SettingTile(
              title: "Connected account",
              subtitle: "what you connect to like Google, X, etc",
            ),
          ],
        );
      case SettingType.about:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "this app is make for you...\nChin up and live your valuable life.\n^^",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 10),
              Text(
                "by HALO TEAM",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
    }
  }

  // Widget _getIllustration() {
  //   String url = 'https://illustrations.popsy.co/amber/surr-downloading.png'; // Default
  //   if (type == SettingType.activity) url = 'https://illustrations.popsy.co/amber/surr-chart.png';
  //   if (type == SettingType.privacy) url = 'https://illustrations.popsy.co/amber/surr-payment.png';
  //   if (type == SettingType.security) url = 'https://illustrations.popsy.co/amber/surr-shield.png';
  //   if (type == SettingType.about) url = 'https://illustrations.popsy.co/amber/surr-waiting.png';
  //   return Image.network(url);
  // }
}

// ================== 3. INTERNAL HELPERS (Chỉ dùng trong file này) ==================

Widget _buildSearchBar() {
  return Container(
    height: 45,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: AppColors.primaryBlue),
    ),
    child: const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: AppColors.primaryBlue),
        hintText: "Search for setting",
        hintStyle: TextStyle(color: AppColors.primaryBlue),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 8),
      ),
    ),
  );
}

class _SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? trailingText;
  final IconData? icon;
  final bool isSwitch;
  final bool switchValue;
  final VoidCallback? onTap;

  const _SettingTile({
    required this.title,
    this.subtitle,
    this.trailingText,
    this.icon,
    this.isSwitch = false,
    this.switchValue = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.black87),
              const SizedBox(width: 15),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),
            if (isSwitch)
              SizedBox(
                height: 30,
                child: Switch(
                  value: switchValue,
                  activeColor: AppColors.primaryBlue,
                  onChanged: (v) {},
                ),
              )
            else ...[
              if (trailingText != null)
                Text(
                  trailingText!,
                  style: const TextStyle(color: Colors.black54),
                ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.primaryBlue,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
