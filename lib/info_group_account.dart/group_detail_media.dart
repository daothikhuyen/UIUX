import 'package:finaluxui/info_group_account.dart/widget/devider.dart';
import 'package:finaluxui/info_group_account.dart/widget/tab_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GroupDetailMediaFiles extends StatelessWidget {
  const GroupDetailMediaFiles({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final List<String> images = [
      "assets/images/d1.jpg",
      "assets/images/cute.jpg",
      "assets/images/d1.jpg",
      "assets/images/cute.jpg",
      "assets/images/d1.jpg",
      "assets/images/d1.jpg",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Trong suốt nếu muốn nhìn thấy ảnh
        elevation: 0, // Loại bỏ bóng
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
        ],

        title: Text(
          "Group Happy EveryDay",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Header(w: w),
            const SizedBox(height: 60),
            TabRow(currentTab: 'Media files'),
            SocialDevider(),
            MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(10),
              itemCount: images.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(images[index], fit: BoxFit.cover),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final double w;
  const _Header({required this.w});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Cover
        Container(
          height: 250,
          width: w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/d1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 250,
          width: w,
          color: Colors.black.withOpacity(0.5), // 0.5 = 50% trong suốt
        ),

        Positioned(
          right: 20, // cách mép trái 10px
          bottom: 40, // cách đáy ảnh 10px (âm nghĩa là nằm phía dưới ảnh)
          child: _FollowButton(),
        ),

        Positioned(
          right: 10, // cách mép trái 10px
          bottom: -50, // cách đáy ảnh 10px (âm nghĩa là nằm phía dưới ảnh)
          child: _StatsRow(),
        ),

        // Avatar + Name + Follow
        Positioned(
          left: 16,
          right: 16,
          bottom: -36,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundImage: AssetImage('assets/images/d1.jpg'),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ],
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7E57C2),
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        elevation: 0,
      ),
      onPressed: () {},
      icon: const Icon(Icons.group_add, size: 18, color: Colors.white),
      label: const Text('Follow'),
    );
  }
}

/* ======================== STATS ======================== */
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 44, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _StatItem('32', 'Posts'),
          SizedBox(width: 40),
          _StatItem('300+', 'Follower'),
          SizedBox(width: 40),
          _StatItem('2', 'Following'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}
