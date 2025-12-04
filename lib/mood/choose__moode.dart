import 'package:flutter/material.dart';

import 'choosed_mood.dart';
import 'mood_home.dart';

// Màu sắc chính cho màn hình
const Color _kPrimaryBlue = Color(0xFF4C7DFF);
// ĐÃ THAY ĐỔI MÀU NỀN THEO YÊU CẦU
const Color _kBackgroundColor = Color(0xFFF3D7DD); 

// Dữ liệu giả định cho các biểu tượng cảm xúc (GIỮ NGUYÊN)
class Emotion {
  final String emoji;
  final String label;

  Emotion(this.emoji, this.label);
}

final List<Emotion> _recentEmotions = [
  Emotion('😩', 'Confused'),
  Emotion('😤', 'Angry'),
  Emotion('😲', 'Wow'),
  Emotion('😌', 'Peaceful'),
  Emotion('🤩', 'Happy'),
  Emotion('😊', 'Shy'),
  Emotion('😇', 'Fine'),
];

final List<Emotion> _allEmotions = [
  Emotion('😔', 'Sad'),
  Emotion('🙂', 'Carefree'),
  Emotion('😈', 'Upset'),
  Emotion('😂', 'Funny'),
  Emotion('😁', 'Happy'),
  Emotion('😟', 'Bored'),
  Emotion('🥰', 'Love'),
  Emotion('😛', 'Grateful'),
];

class EmotionPickerScreen extends StatelessWidget {
  const EmotionPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SỬ DỤNG MÀU NỀN MỚI
      backgroundColor: _kBackgroundColor, 
      body: SafeArea(
        child: Column(
          children: [
            // --- Phần Đầu Trang (App Bar) ---
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TopAppBar(), 
            ),
            
            // --- Nội dung chính cuộn được ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    
                    // Tiêu đề
                    Center(
                      child:const Text(
                      'Choose the emotion that make you feel',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                    ),
                    
                    // Mô tả
                    const SizedBox(height: 8),
                    const Text(
                      'Select at least 1 emotion',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    
                    const SizedBox(height: 25),
                    
                    // Thanh Tìm kiếm
                    const SearchBarWidget(),
                    
                    const SizedBox(height: 30),
                    
                    // --- Emotions được sử dụng gần đây ---
                    const Text(
                      'Recent used',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    EmotionGrid(emotions: _recentEmotions),
                    
                    const SizedBox(height: 30),
                    
                    // --- Tất cả cảm xúc ---
                    const Text(
                      'All emotions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    EmotionGrid(emotions: _allEmotions),
                    
                    const SizedBox(height: 100), // Khoảng trống cho nút Continue
                  ],
                ),
              ),
            ),
            
            // --- Nút Continue cố định dưới cùng ---
            const ContinueButton(),
          ],
        ),
      ),
    );
  }
}

// Widget App Bar tùy chỉnh (GIỮ NGUYÊN)
class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // Căn chỉnh nội dung sang hai bên
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Nút Back (Góc trái)
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
          onPressed: () {
            // Sử dụng Navigator.push để chuyển sang màn hình ChooseMoodScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                // Thay ChooseMoodScreen() bằng tên class màn hình đích của bạn
                builder: (context) => const MoodScreen(), 
              ),
            );
          },
        ),
        
        // Dùng Spacer để đẩy nội dung "Hey, J97!" sang phải
        const Spacer(), 

        // Lời chào "Hey, J97!👋" (Góc phải)
        Row(
          children: const [
            Text(
              'Hey, J97!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text('👋', style: TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }
}

// Widget Thanh Tìm kiếm (ĐÃ SỬA ĐỔI THEO YÊU CẦU SHADOW VÀ RADIUS)
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7), // Màu nền nhẹ
        // Radius full 30
        borderRadius: BorderRadius.circular(30), 
        // Thay thế border bằng BoxShadow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Màu bóng đổ, có độ trong suốt
            offset: const Offset(4, 5),          // Dịch chuyển X=4, Y=5
            blurRadius: 30,                       // Độ mờ/lan tỏa
            spreadRadius: 0,                      // Không lan tỏa
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

// ... (EmotionGrid)
class EmotionGrid extends StatelessWidget {
  final List<Emotion> emotions;

  const EmotionGrid({super.key, required this.emotions});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 0.75,
      children: emotions.map((emotion) {
        return EmotionItem(
          emotion: emotion,
          // isSelected: emotion.label == 'Happy',
        );
      }).toList(),
    );
  }
}

// ... (EmotionItem)
class EmotionItem extends StatelessWidget {
  final Emotion emotion;
  final bool isSelected;

  const EmotionItem({
    super.key,
    required this.emotion,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: isSelected ? _kPrimaryBlue : Colors.transparent,
            shape: BoxShape.circle,
            border: isSelected
                ? null
                : Border.all(color: Colors.grey.shade300, width: 1.5),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: _kPrimaryBlue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            emotion.emoji,
            style: const TextStyle(fontSize: 35),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          emotion.label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ... (ContinueButton)
class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Màu nền cho vùng nút
        color: _kBackgroundColor, 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            // Sử dụng Navigator.push để chuyển sang màn hình ChooseMoodScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                // Thay ChooseMoodScreen() bằng tên class màn hình đích của bạn
                builder: (context) => const ChoosedMoodScreen(), 
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _kPrimaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}