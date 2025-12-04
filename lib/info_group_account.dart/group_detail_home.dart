import 'package:finaluxui/info_group_account.dart/widget/devider.dart';
import 'package:finaluxui/info_group_account.dart/widget/tab_row.dart';
import 'package:flutter/material.dart';

class GroupDetailHome extends StatelessWidget {
  const GroupDetailHome({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Trong suốt nếu muốn nhìn thấy ảnh
        elevation: 0, // Loại bỏ bóng
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
            TabRow(currentTab: 'Home'),
            SocialDevider(),
            _Suggestions(),
            const SizedBox(height: 8),
            _PostCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/* ======================== HEADER ======================== */
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
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.5),
        ),

        Positioned(right: 20, bottom: 40, child: _FollowButton()),

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

/* ======================== SUGGESTIONS ======================== */
class _Suggestions extends StatelessWidget {
  final items = const [
    {
      'name': 'Group Happy, D...',
      'img':
          'https://weart.vn/wp-content/uploads/2025/06/hinh-nen-may-tinh-cute-voi-hinh-anh-chu-meo-dang-thu-gian-tren-dam-may.jpg',
      'follow': '1000+',
    },
    {
      'name': 'Stress Happy, E...',
      'img':
          'https://onoff.vn/blog/wp-content/uploads/2025/08/chup-hinh-voi-co-to-quoc.jpg',
      'follow': '320+',
    },
    {
      'name': 'Group Happy',
      'img':
          'https://cdnv2.tgdd.vn/mwg-static/common/News/1577501/sticker-12.jpg',
      'follow': '1000+',
    },
  ];

  const _Suggestions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(
            'Suggestions for you',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 175,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (_, i) => _SuggestCard(
                  name: items[i]['name']!,
                  img: items[i]['img']!,
                  follow: items[i]['follow']!,
                ),
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemCount: items.length,
          ),
        ),
      ],
    );
  }
}

class _SuggestCard extends StatelessWidget {
  final String name;
  final String img;
  final String follow;
  const _SuggestCard({
    required this.name,
    required this.img,
    required this.follow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 26, backgroundImage: NetworkImage(img)),
          const SizedBox(height: 6),
          Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text(
            'follow: $follow',
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 32),
              shape: const StadiumBorder(),
            ),
            onPressed: () {},
            child: const Text('Follow', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: const [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/00/18/5e/00185e17a3368cb973caa35815d9212d.jpg',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Min',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today I cooked my own breakfast. Even though it was simple, I felt proud of myself for waking up early 💪',
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://i.pinimg.com/736x/00/18/5e/00185e17a3368cb973caa35815d9212d.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _IconText(Icons.favorite_border, 'Like'),
                _IconText(Icons.chat_bubble_outline, 'Comment'),
                _IconText(Icons.share_outlined, 'Share'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const _IconText(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon, size: 18), const SizedBox(width: 4), Text(text)],
    );
  }
}
