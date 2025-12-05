import 'package:flutter/material.dart';
const Color _kBackgroundColor = Color(0xFFF3D7DD); 

class ExerciseSelectorScreen extends StatefulWidget {
  const ExerciseSelectorScreen({super.key});

  @override
  State<ExerciseSelectorScreen> createState() => _ExerciseSelectorScreenState();
}

class _ExerciseSelectorScreenState extends State<ExerciseSelectorScreen> {
  // Danh sách các bài tập đã chọn
  final List<String> _selectedExercises = [];

  // Danh sách các bài tập đã sử dụng gần đây
  final List<String> _recentExercises = [
    'Box Breathing',
    'Body Scan',
    'Walking Meditation',
  ];

  // Danh sách tất cả các bài tập
  final List<String> _allExercises = [
    'Box Breathing',
    'Body Scan',
    'Walking Meditation',
    'Shadow Boxing',
    'Standing Forward Fold',
    'Seated Spinal Twist',
    'High Knees',
    // Thêm các bài tập khác nếu cần
  ];

  // Hàm xử lý khi chọn/bỏ chọn bài tập
  void _toggleExercise(String exercise) {
    setState(() {
      if (_selectedExercises.contains(exercise)) {
        _selectedExercises.remove(exercise);
      } else {
        _selectedExercises.add(exercise);
      }
    });
  }

  // Widget hiển thị từng thẻ bài tập (Chip)
  Widget _buildExerciseChip(String exercise) {
    final isSelected = _selectedExercises.contains(exercise);
    return GestureDetector(
      onTap: () => _toggleExercise(exercise),
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4285F4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4285F4) : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Text(
          exercise,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canContinue = _selectedExercises.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nút quay lại (Icon mũi tên bên trái)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // Tên người dùng bên phải
            const Text(
              "Hey, J97!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần chính có thể cuộn
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  // Phụ đề
                  const Text(
                    "Choose the exercise that make you improve your health",
                    textAlign: TextAlign.center, // Căn giữa tiêu đề
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child:  Text(
                      "Select at least 1 exercise",
                      // textAlign: TextAlign.center, // Căn giữa tiêu đề
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Thanh tìm kiếm
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: _kBackgroundColor,

                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        // hintText: "Search",
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ## Khu vực Bài tập đã dùng gần đây
                  const Text(
                    "Recent used",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    children: _recentExercises
                        .map((e) => _buildExerciseChip(e))
                        .toList(),
                  ),
                  const SizedBox(height: 30),

                  // ## Khu vực Tất cả Bài tập
                  const Text(
                    "All exercises",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    children: _allExercises
                        .map((e) => _buildExerciseChip(e))
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // ## Nút Continue (luôn nằm ở cuối màn hình)
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              bottom: 24.0,
              top: 5.0,
            ),
            child: ElevatedButton(
              onPressed: canContinue
                  ? () {
                      // Xử lý logic chuyển tiếp khi nút được nhấn
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Đã chọn: ${_selectedExercises.join(', ')}')),
                      );
                    }
                  : null, // Nút bị vô hiệu hóa nếu chưa chọn gì
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                disabledBackgroundColor: Colors.grey.shade400,
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}