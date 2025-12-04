// mood_screen.dart
import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
// 1. Import màn hình đích bạn vừa tạo
import 'choose__moode.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  int selectedIndex = 2;

  final moods = [
    "Angry",
    "Sad",
    "Neutral",
    "Happy",
    "Excited",
  ];

  final icons = [
    "😡",
    "😔",
    "🙂",
    "😊",
    "😍",
  ];

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
              "What is your mood now?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: isSelected
                            ? [const BoxShadow(color: Colors.black26, blurRadius: 6)]
                            : [],
                      ),
                      child: Text(
                        icons[index],
                        style: const TextStyle(fontSize: 36),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            Text(
              moods[selectedIndex],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const Spacer(),

            // 2. Bọc nút Continue bằng GestureDetector để thêm onTap
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: GestureDetector(
                // Gọi hàm chuyển trang khi được chạm
                onTap: () => _navigateToChooseMoodScreen(context), 
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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