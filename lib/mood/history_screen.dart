import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import 'update_post.dart';
// Import màn hình đích cho nút Edit (nếu có, ví dụ: UpdatePostScreen)
// import 'update_post.dart'; 

// --- CÁC HẰNG SỐ VÀ MÀU SẮC ---
const Color _kPrimaryBlue = Color(0xFF4C7DFF);
const Color _kBackgroundColor = Color(0xFFFCFCFC); 
const Color _kCardColor = Colors.white; 
const Color _kPrimaryTextColor = Colors.black;
const Color _kSecondaryTextColor = Colors.grey;
const Color _kWarningRed = Color(0xFFF55A6B); // Màu đỏ cho chữ Delete/OOP!

// Dữ liệu giả định cho các mục lịch sử
class HistoryEntry {
  final String mood;
  final String emoji;
  final String time;
  final String description;
  final String reason;
  final String tip;
  final Color moodColor;

  HistoryEntry({
    required this.mood,
    required this.emoji,
    required this.time,
    required this.description,
    required this.reason,
    required this.tip,
    required this.moodColor,
  });
}

final List<HistoryEntry> _historyData = [
  HistoryEntry(
    mood: 'Love',
    emoji: '😍',
    time: '11:00',
    description: 'You feel cheerful and happy',
    reason: 'Relationship',
    tip: 'Take 5 minutes every day to think or write down 3 specific things you love or are grateful for about your partner and the relationship.',
    moodColor: const Color(0xFFFF99AA), // Màu hồng
  ),
  HistoryEntry(
    mood: 'Angry',
    emoji: '😤',
    time: '5:00',
    description: 'You feel bored and angry',
    reason: 'job',
    tip: 'Get up and take a brisk walk around the office or home. The change of scenery and blood circulation helps the mind become more alert.',
    moodColor: const Color(0xFFF55A6B), // Màu đỏ
  ),
  HistoryEntry(
    mood: 'Peacefull',
    emoji: '😇',
    time: '20:00',
    description: 'You feel peacefull and gentle',
    reason: 'family',
    tip: 'Take a walk, feel your footsteps, the wind and the sounds around you.',
    moodColor: const Color(0xFF5D9FFB), // Màu xanh
  ),
];

// 1. CHUYỂN SANG STATEFUL WIDGET ĐỂ QUẢN LÝ DIALOG
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  // Hàm hiển thị Dialog xác nhận xóa
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // Sử dụng widget Dialog tùy chỉnh
        return const DeleteConfirmationDialog(); 
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Custom App Bar ---
            const HistoryAppBar(),
            
            // --- Danh sách Lịch sử ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                itemCount: _historyData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    // Truyền hàm xóa xuống HistoryCard
                    child: HistoryCard(
                      entry: _historyData[index],
                      onDeleteTapped: () => _showDeleteConfirmationDialog(context),
                    ),
                  );
                },
              ),
            ),

            // --- Thanh Điều Hướng Dưới cùng ---
            const BottomNavBar(selectedIndex: 3,),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------
// 2. WIDGET MỚI: LỚP PHỦ XÁC NHẬN XÓA
// -------------------------------------------------------------------

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent, // Đặt màu nền trong suốt
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nút X (Đóng)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: _kSecondaryTextColor, size: 28),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            
            // Tiêu đề OOP!
            Text(
              'OOP!',
              style: TextStyle(
                color: _kWarningRed,
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            
            // Câu hỏi xác nhận
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 20, color: _kPrimaryTextColor, height: 1.5),
                children: [
                  const TextSpan(text: 'Are you sure '),
                  TextSpan(
                    text: 'delete',
                    style: TextStyle(color: _kWarningRed, fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' this post!'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Nút Yes
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý logic xóa bài viết ở đây
                  Navigator.of(context).pop(); // Đóng dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------
// 3. WIDGETS CƠ SỞ (ĐÃ SỬA ĐỔI CHỨC NĂNG)
// -------------------------------------------------------------------

// Widget App Bar cho màn hình History
class HistoryAppBar extends StatelessWidget {
  const HistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
      color: _kBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nút Back
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
            onPressed: () => Navigator.pop(context),
          ),
          // Tiêu đề
          const Text(
            "J97's history",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _kPrimaryTextColor),
          ),
          // Nút ngày tháng
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _kCardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: const [
                Text(
                  'Thu, 10 Oct',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _kPrimaryTextColor),
                ),
                SizedBox(width: 4),
                Icon(Icons.calendar_today, size: 14, color: _kPrimaryTextColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Thẻ Lịch sử (ĐÃ THÊM ONTAP DELETE)
class HistoryCard extends StatelessWidget {
  final HistoryEntry entry;
  final VoidCallback onDeleteTapped; // <--- CALLBACK CHO NÚT DELETE

  const HistoryCard({
    super.key, 
    required this.entry,
    required this.onDeleteTapped, // <--- THÊM YÊU CẦU CALLBACK
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 220, 225),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dòng Mood, Time và Edit/Delete
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mood và Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(entry.emoji, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 8),
                      Text(
                        entry.mood,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: entry.moodColor, 
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      entry.time,
                      style: const TextStyle(fontSize: 14, color: _kSecondaryTextColor),
                    ),
                  ),
                ],
              ),
              
              // Nút Delete / Edit
              Row(
                children: [
                  TextButton(
                    onPressed: onDeleteTapped, // <--- GỌI HÀM HIỂN THỊ DIALOG
                    child: const Text('Delete', style: TextStyle(color: _kWarningRed, fontSize: 14)),
                  ),
                  TextButton(
                    onPressed: () {
                      // Sử dụng Navigator.push để chuyển sang màn hình ChooseMoodScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // Thay ChooseMoodScreen() bằng tên class màn hình đích của bạn
                          builder: (context) => const UpdatePostScreen(), 
                        ),
                      );
                    },
                    child: Text('Edit', style: TextStyle(color: _kPrimaryBlue, fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Description và Reason
          Text(
            entry.description,
            style: const TextStyle(fontSize: 16, color: _kPrimaryTextColor, height: 1.4),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(
                  text: 'Because of ',
                  style: TextStyle(fontSize: 16, color: _kSecondaryTextColor),
                ),
                TextSpan(
                  text: entry.reason,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _kPrimaryTextColor),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Tip Section
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // color: _kTipBackground, 
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.wb_sunny_outlined, color: Color.fromARGB(255, 209, 166, 36), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tip',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _kPrimaryTextColor),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry.tip,
                        style: const TextStyle(fontSize: 14, color: _kPrimaryTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// // Widget Thanh Điều hướng Dưới cùng
// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80, 
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 3,
//             blurRadius: 15,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: const [
//           NavBarItem(icon: Icons.home_outlined, label: 'Home', isSelected: false),
//           NavBarItem(icon: Icons.chat_bubble_outline, label: 'Message', isSelected: false),
//           NavBarItem(icon: Icons.group_outlined, label: 'Social', isSelected: false),
//           NavBarItem(icon: Icons.sentiment_satisfied_alt, label: 'Mood', isSelected: true), 
//           NavBarItem(icon: Icons.person_outline, label: 'Profile', isSelected: false),
//         ],
//       ),
//     );
//   }
// }

// class NavBarItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isSelected;

//   const NavBarItem({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.isSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = isSelected ? _kPrimaryBlue : Colors.grey.shade700;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, color: color, size: 28),
//         Text(
//           label,
//           style: TextStyle(
//             color: color,
//             fontSize: 12,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
// }