import 'package:finaluxui/mood/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import 'history_screen.dart';

// --- CÁC HẰNG SỐ VÀ MÀU SẮC ---
const Color _kPrimaryBlue = Color(0xFF4C7DFF);
const Color _kBackgroundColor = Color(0xFFFCFCFC); 
const Color _kBarChartBackground = Color(0xFFF1F7FC); 
const Color _kLightPinkBackground = Color(0xFFFDEEF2); // Màu nền hồng nhạt
const Color _kPrimaryTextColor = Colors.black;
const Color _kSecondaryTextColor = Colors.grey;

// Dữ liệu giả định
class MoodEntry {
  final String time;
  final String emoji;
  final Color color;
  final double heightRatio; 

  MoodEntry(this.time, this.emoji, this.color, this.heightRatio);
}

final List<MoodEntry> _moodData = [
  MoodEntry('5:00', '😡', const Color(0xFFF55A6B), 0.5),
  MoodEntry('8:00', '🤩', const Color(0xFFFFCC33), 0.8),
  MoodEntry('11:00', '😁', const Color(0xFF66BB6A), 1.0),
  MoodEntry('14:00', '😈', const Color(0xFF9C27B0), 0.9),
  MoodEntry('17:00', '😍', const Color(0xFFFF99AA), 0.7),
];

// Đổi tên class thành DashboardMoodScreen
class DashboardMoodScreen extends StatelessWidget { 
  const DashboardMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor,
      body: Column( 
        children: [
          // 1. PHẦN ĐÃ FIX LỖI OVERFLOW: Bao bọc nội dung cuộn bằng Expanded
          Expanded( 
            child: SingleChildScrollView( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  // Header
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: HomeHeader(),
                  ),
                  const SizedBox(height: 25),
                  
                  // 1. LỊCH VÀ EMOJI
                  const DateCalendar(),
                  
                  const SizedBox(height: 20),
                  
                  // 2. CHECK-IN TITLE VÀ ACTIONS (ĐÃ BỐ CỤC LẠI)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CheckinHeaderAndActions(), 
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // 3. CHECK-IN STATUS BAR (Thanh progress)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CheckinStatusBar(), 
                  ),
                  
                  const SizedBox(height: 30),
                  // Mood Chart
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: MoodChart(data: _moodData),
                  ),
                  const SizedBox(height: 30),
                  // Latest Note
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: LatestMoodNote(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          
          // 2. Thanh Điều Hướng Dưới cùng 
          const BottomNavBar(selectedIndex: 3,),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
//                          WIDGETS RIÊNG LẺ
// -------------------------------------------------------------------

// Widget Header (Hey, J97! và Ngày tháng)
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Text(
              'Hey, J97!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _kPrimaryTextColor,
              ),
            ),
            Text('👋', style: TextStyle(fontSize: 24)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _kPrimaryTextColor,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.calendar_today, size: 14, color: _kPrimaryTextColor),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget Lịch Ngày
class DateCalendar extends StatelessWidget {
  const DateCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu ngày giả định
    final List<Map<String, dynamic>> dates = [
      {'day': 'Thu', 'date': '30', 'selected': false, 'emoji': '😄'},
      {'day': 'Fri', 'date': '31', 'selected': false, 'emoji': '😘'},
      {'day': 'Sar', 'date': '1', 'selected': false, 'emoji': '😔'},
      {'day': 'Sun', 'date': '2', 'selected': true, 'emoji': '😀'},
    ];

    return Column(
      children: [
        // Hàng Lịch Ngày
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...dates.map((date) => DateItem(
                    day: date['day'],
                    date: date['date'],
                    isSelected: date['selected'],
                  )).toList(),
              // Khoảng trống cân bằng
              const SizedBox(width: 80), 
            ],
          ),
        ),
        const SizedBox(height: 15),
        // Hàng Emoji
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...dates.map((date) => SizedBox(
                width: 65, 
                child: Center(
                  child: Text(date['emoji'], style: const TextStyle(fontSize: 20)),
                ),
              )).toList(),
              // Khoảng trống cân bằng
              const SizedBox(width: 80), 
            ],
          ),
        ),
      ],
    );
  }
}

// Item Ngày Lịch
class DateItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const DateItem({
    super.key,
    required this.day,
    required this.date,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? _kBackgroundColor : _kLightPinkBackground, 
        borderRadius: BorderRadius.circular(10),
        border: isSelected
            ? Border.all(color: _kPrimaryBlue, width: 2) 
            : null,
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? _kPrimaryBlue : _kPrimaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 20,
              color: isSelected ? _kPrimaryBlue : _kPrimaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Nút Hành động nhỏ (Video/History)
class ActionButton extends StatelessWidget {
  final IconData icon;

  const ActionButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: const Color(0xFFFF99AA), size: 20),
    );
  }
}

// Widget MỚI: Dòng tiêu đề "Today's check-in" và 2 nút Action
class CheckinHeaderAndActions extends StatelessWidget {
  const CheckinHeaderAndActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Tiêu đề
        const Text(
          "Today's check-in",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _kPrimaryTextColor,
          ),
        ),
        // 2 Nút Action
       Row(
          children: [
            // Nút Video (không cần bọc nếu không có onTap)
            const ActionButton(icon: Icons.videocam_outlined), 
            const SizedBox(width: 15),
            
            // Bọc nút History bằng GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(), // <--- CHUYỂN TRANG
                  ),
                );
              },
              child: const ActionButton(icon: Icons.history),
            ),
          ],
        ),
      ],
    );
  }
}


// Widget ĐÃ SỬA: Thanh trạng thái check-in (Thanh progress)
class CheckinStatusBar extends StatelessWidget {
  const CheckinStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: _kLightPinkBackground, // Màu nền hồng nhạt
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              // Icon ngôi sao custom
              Icon(Icons.star, color: Color(0xFFFFCC33), size: 28), 
              SizedBox(width: 10),
              Text(
                "Check-in",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _kPrimaryTextColor,
                ),
              ),
            ],
          ),
          const Text(
            '1/11',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _kPrimaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}


// Widget Biểu đồ Tâm trạng
class MoodChart extends StatelessWidget {
  final List<MoodEntry> data;

  const MoodChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _kBarChartBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mood chart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _kPrimaryTextColor,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((entry) => MoodBar(entry: entry)).toList(),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Widget Thanh Mood Bar
class MoodBar extends StatelessWidget {
  final MoodEntry entry;

  const MoodBar({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    // Chiều cao tối đa của thanh bar (tỷ lệ với container)
    const double maxHeight = 150; 
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Thanh bar và Emoji
        SizedBox(
          height: maxHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Cột nền màu trắng mờ (chiều cao cố định)
              Container(
                width: 30,
                height: maxHeight,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7), 
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              // Cột chính
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 30,
                height: maxHeight * entry.heightRatio, // Chiều cao tỷ lệ
                decoration: BoxDecoration(
                  color: entry.color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(entry.emoji, style: const TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        // Thời gian
        Text(
          entry.time,
          style: const TextStyle(fontSize: 14, color: _kPrimaryTextColor),
        ),
      ],
    );
  }
}

// Widget Ghi chú Tâm trạng Gần đây nhất
class LatestMoodNote extends StatelessWidget {
  const LatestMoodNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text('😍', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text(
                    'Love',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _kPrimaryTextColor,
                    ),
                  ),
                  Text(' 11:00', style: TextStyle(fontSize: 14, color: _kSecondaryTextColor)),
                ],
              ),
              const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 16,
                  color: _kPrimaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: 'You feel cheerful and happy\n',
                  style: TextStyle(fontSize: 16, color: _kPrimaryTextColor),
                ),
                TextSpan(
                  text: 'Because of ',
                  style: TextStyle(fontSize: 16, color: _kSecondaryTextColor),
                ),
                TextSpan(
                  text: 'Relationship',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _kPrimaryTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


