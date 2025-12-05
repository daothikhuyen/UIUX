// mood_screen.dart
import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

// 1. Import màn hình đích bạn vừa tạo
import 'choose__moode.dart';
import 'exercise_selector_screen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  int selectedIndex = 2;

  
  // Hàm xử lý chuyển trang
  void _navigateToChooseMoodScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmotionPickerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3D7DD),
      bottomNavigationBar: BottomNavBar(selectedIndex: 3,),
      body: SafeArea(
        child: Column(
          children: [
            // ... (Các phần giao diện phía trên giữ nguyên) ...

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hey, J97!👋",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16),
                        SizedBox(width: 6),
                        Text("Thu, 10 Oct"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            const Text(
              "Resource Library & Quick Exercises",
              textAlign: TextAlign.center, // Căn giữa tiêu đề
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            

            const Spacer(),

            // 2. Bọc nút Continue bằng GestureDetector để thêm onTap
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: GestureDetector(
                // Gọi hàm chuyển trang khi được chạm
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExerciseSelectorScreen(), 
                    ),
                  );
                }, 
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                       BoxShadow(
                        color: Colors.black26, 
                        blurRadius: 6,
                        offset: Offset(0, 3)
                      )
                    ]
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}