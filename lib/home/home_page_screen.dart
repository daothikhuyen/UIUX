import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'new_post.dart'; // Import để chuyển trang và dùng chung AppColors

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 50), // Tăng nhẹ padding top cho thoáng

              // ===== HEADER =====
              const StoriesHeader(),
              const SizedBox(height: 15),

              // ===== TABS + STORIES =====
              const PublicFeedTabs(),
              const SizedBox(height: 20),

              // ===== CREATE POST SECTION (Nút chuyển sang trang viết bài) =====
              const CreatePostSection(),
              const SizedBox(height: 15),
            ]),
          ),

          // ===== FEED =====
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate(const [
                FeedPost(
                  userName: 'Min',
                  time: '2m',
                  story: 'My Story',
                  text: 'Today I cooked my own breakfast. Even though it was a simple meal, I felt very proud of myself for waking up early. 💪',
                  // Lưu ý: Nếu chưa có ảnh thật trong folder assets/images, code sẽ báo lỗi. 
                  // Bạn có thể tạm thay bằng NetworkImage nếu muốn test nhanh.
                  imageAsset: 'assets/images/sun_egg.png', 
                  profileImage: 'assets/images/min_profile.jpg',
                  likes: 10,
                  comments: 2,
                  additionalTag: 'Small Wins',
                ),
                SizedBox(height: 20),
                FeedPost(
                  userName: 'Comila',
                  time: '15m',
                  story: 'My Pet',
                  text: 'Grateful for my cat. She doesn’t judge me when I leave. She just sits quietly on the sidelines. Her presence calms me down a lot. 🌱',
                  imageAsset: 'assets/images/cat_post.png',
                  secondImageAsset: 'assets/images/cat_post_2.png', 
                  profileImage: 'assets/images/comila_profile.png',
                  likes: 34,
                  comments: 8,
                  additionalTag: 'Grateful',
                  isDoubleImage: true,
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0,),
    );
  }
}

/// ================= HEADER =================
class StoriesHeader extends StatelessWidget {
  const StoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng màu từ AppColors bên new_post.dart nếu muốn đồng bộ
    // Hoặc định nghĩa cứng như thiết kế cũ
    final Color myColor60OpacityAlt = const Color(0xFF20487F).withOpacity(0.6);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [        
          Text(
            'Public Feed',
           style: TextStyle(
              color: myColor60OpacityAlt, 
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(Icons.notifications, color: Color(0xFF3686FF), size: 28),
        ],
      ),
    );
  }
}

/// ================= TABS + STORIES =================
class PublicFeedTabs extends StatelessWidget {
  const PublicFeedTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TABS =====
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                FeedTab(label: 'Most Recent', isSelected: true),
                SizedBox(width: 8),
                FeedTab(label: 'News'),
                SizedBox(width: 8),
                FeedTab(label: 'For you'),
                SizedBox(width: 8),
                FeedTab(label: 'Newbies'),
              ],
            ),
          ),

          const SizedBox(height: 10),
          Container(height: 1, width: double.infinity, color: Colors.grey.shade300),
          const SizedBox(height: 16),

          // ===== STORIES =====
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                StoryCard.create(),
                StoryCard(image: 'assets/images/story_fina.png', name: 'Fina'),
                StoryCard(image: 'assets/images/story_abi.png', name: 'Abi'),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(height: 1, width: double.infinity, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}

class FeedTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  const FeedTab({required this.label, this.isSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    final Color myColor60OpacityAlt = const Color(0xFF20487F).withOpacity(0.6);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFBFE3E2) : const Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isSelected ? const Color(0xFF1F5FBF) : myColor60OpacityAlt, 
            ),
          ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 3,
          width: isSelected ? 40 : 0,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF52D0CF) : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

/// ================= STORY CARD =================
class StoryCard extends StatelessWidget {
  final String image;
  final String name;
  final bool isCreate;

  const StoryCard({required this.image, required this.name, this.isCreate = false, super.key});
  const StoryCard.create({super.key}) : image = 'assets/images/story_create.png', name = 'Create stories', isCreate = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade300, // Màu nền phòng khi ảnh lỗi
        image: DecorationImage(
          // Sử dụng AssetImage theo yêu cầu. 
          // Nếu bạn chưa có ảnh, hãy đổi thành NetworkImage để test.
          image: isCreate 
            ? const NetworkImage('https://picsum.photos/200') as ImageProvider // Placeholder cho nút create
            : AssetImage(image), 
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCreate)
                  Container(
                    width: 32, height: 32,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.blue),
                  ),
                const SizedBox(height: 6),
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= CREATE POST SECTION (NAVIGATE) =================
class CreatePostSection extends StatelessWidget {
  const CreatePostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // --- CHUYỂN TRANG: Từ Home -> WritePostScreen ---
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WritePostScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.public, color: Color.fromARGB(255, 109, 109, 109), size: 16),
                SizedBox(width: 6),
                Text('Public', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Icon(Icons.keyboard_arrow_down, size: 16),
                Spacer(),
                Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            // Giả lập TextField nhưng thực chất là Text tĩnh để bấm vào
            const Text(
              'Say something...',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.add_circle_outline, color: Colors.blue, size: 28), // Icon to hơn chút cho đẹp
                LabelText('Label'),
                LabelText('Category'),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String text;
  const LabelText(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
    );
  }
}

/// ================= FEED POST =================
class FeedPost extends StatelessWidget {
  final String userName, time, story, text, imageAsset, profileImage, additionalTag;
  final String? secondImageAsset;
  final int likes, comments;
  final bool isDoubleImage;

  const FeedPost({
    super.key,
    required this.userName, required this.time, required this.story,
    required this.text, required this.imageAsset, required this.profileImage,
    required this.likes, required this.comments, required this.additionalTag,
    this.secondImageAsset, this.isDoubleImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                // Sử dụng AssetImage, fallback icon nếu lỗi
                backgroundImage: AssetImage(profileImage),
                onBackgroundImageError: (_, __) {}, 
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('$time · $story', style: TextStyle(color: Colors.grey.shade500, fontSize: 12))
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(height: 1.4)),
          const SizedBox(height: 10),
          if (isDoubleImage && secondImageAsset != null)
            Row(
              children: [
                Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(imageAsset, height: 160, fit: BoxFit.cover))),
                const SizedBox(width: 6),
                Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(secondImageAsset!, height: 160, fit: BoxFit.cover))),
              ],
            )
          else
            ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(imageAsset, height: 200, width: double.infinity, fit: BoxFit.cover)),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                child: Text(additionalTag, style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              const Icon(Icons.comment_outlined, size: 20, color: Colors.grey),
              Text(' $comments', style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 15),
              const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
              Text(' $likes', style: const TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
