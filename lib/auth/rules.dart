import 'package:finaluxui/home/home_page_screen.dart';
import 'package:flutter/material.dart';

class PeacefulSpaceScreen extends StatelessWidget {
  const PeacefulSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Màu sắc theo hình ảnh
    const Color primaryBlue = Color(0xFF4285F4);
    const Color darkText = Color(0xFF1E1E1E);
    const Color lightGrey = Color(0xFFE0E0E0);
    const Color secondaryBlue = Color(0xFF3B82F6); // Xanh dương đậm hơn một chút

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ## Tiêu đề chính
              const Text(
                'Welcome to the peaceful\nspace',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
              const SizedBox(height: 12),
              
              // ## Phụ đề
              const Text(
                'Journey of Understanding,\nPeaceful Space',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),

              // ## Hộp giải thích (Màu xanh nổi bật)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: secondaryBlue,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: secondaryBlue.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  'This is a community of people looking for empathy, a '
                  'place to share emotions. when experiencing this social '
                  'network (for people with mental disorders and '
                  'empathetic people) you will feel empathy and share '
                  'the feeling of helping others become better, have faith '
                  'in life.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 40),

              // ## Tiêu đề Quy tắc Cộng đồng
              const Text(
                'Community Rules',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
              const SizedBox(height: 24),

              // ## 4 Biểu tượng Quy tắc
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRuleItem(context, Icons.pan_tool, '1. non-\njudgmental'),
                  _buildRuleItem(context, Icons.accessibility_new, '2. Respect\nothers'),
                  _buildRuleItem(context, Icons.warning_amber, '3. Content\nwarning'),
                  _buildRuleItem(context, Icons.lock, '4. do not share\ninformation'),
                ],
              ),
              const SizedBox(height: 40),

              // ## Hộp hành động phụ (Màu xanh nổi bật)
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Use it positively and bring good things.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ## Nút chính "Agree and continue"
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(), 
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Agree and continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng từng mục quy tắc (Icon + Text)
  Widget _buildRuleItem(BuildContext context, IconData icon, String label) {
    return SizedBox(
      width: 80, // Giới hạn chiều rộng để căn giữa
      child: Column(
        children: [
          // Phần Icon có hiệu ứng 3D/Nổi
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // shadow nhẹ
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.black54, // Màu icon
            ),
          ),
          const SizedBox(height: 8),
          // Text mô tả quy tắc
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}