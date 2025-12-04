import 'package:flutter/material.dart';

// Import màn hình đích (Giữ nguyên)
import 'dashboard_mood.dart'; 

// --- CÁC HẰNG SỐ VÀ MÀU SẮC ---
const Color _kPrimaryBlue = Color(0xFF4C7DFF);
const Color _kBackgroundColor = Color(0xFFFCFCFC); 
const Color _kInputFillColor = Color(0xFFFDEEF2); 
const Color _kPrimaryTextColor = Colors.black;
const Color _kSecondaryTextColor = Colors.grey;

// -------------------------------------------------------------------
// 1. CHUYỂN SANG STATEFUL WIDGET ĐỂ QUẢN LÝ TRẠNG THÁI LỚP PHỦ
// -------------------------------------------------------------------

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({super.key});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  // Biến trạng thái để kiểm soát việc hiển thị lớp phủ ghi âm
  bool _isRecording = false; 
  
  static const String _kInitialContent = 
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour';

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor,
      // SỬ DỤNG STACK ĐỂ PHỦ LỚP GHI ÂM LÊN TRÊN
      body: Stack(
        children: [
          // Lớp dưới cùng: Nội dung chính của AddNotesScreen
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomAppBar(), 
                        const SizedBox(height: 30),
                        const Text(
                          'Update your post',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: _kPrimaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Add any words that describe how you feel today',
                          style: TextStyle(
                            fontSize: 16,
                            color: _kSecondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const NoteInputField(initialText: _kInitialContent),
                        const SizedBox(height: 50),
                        
                        // Cập nhật Nút Ghi âm để gọi hàm _toggleRecording
                        Center(child: RecordVoiceButton(onTap: _toggleRecording)),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
                
                // Nút Save và Skip and Save
                const SaveActionButtons(), 
              ],
            ),
          ),

          // Lớp phủ ghi âm (chỉ hiển thị khi _isRecording là true)
          if (_isRecording)
            RecordingOverlay(
              onClose: _toggleRecording,
            ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// 2. WIDGET MỚI: LỚP PHỦ GHI ÂM (RecordingOverlay)
// -------------------------------------------------------------------

class RecordingOverlay extends StatelessWidget {
  final VoidCallback onClose;
  
  const RecordingOverlay({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Màu nền xám (giống như trong hình ảnh mic lớn)
    const Color overlayColor = Color(0xFFE0E0E0); 
    
    return Container(
      width: size.width,
      height: size.height,
      color: overlayColor,
      child: Stack(
        children: [
          // Nút Back/Đóng
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
              onPressed: onClose, // Đóng lớp phủ
            ),
          ),
          
          // Nội dung chính
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Microphone Lớn
                const Icon(
                  Icons.mic,
                  color: _kPrimaryTextColor,
                  size: 200, // Kích thước lớn
                ),
                const SizedBox(height: 20),
                const Text(
                  'Anything you want to add',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _kPrimaryTextColor,
                  ),
                ),
                const Text(
                  'Add any words that describe how you feel today',
                  style: TextStyle(
                    fontSize: 14,
                    color: _kSecondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Dòng Skip and Save và Đường cong Xanh
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Đường cong/Wave màu xanh
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _kPrimaryBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Nút/Text Skip and Save
                TextButton(
                  onPressed: () {
                    onClose();
                    // Thêm logic Skip & Save nếu cần
                  },
                  child: const Text(
                    'Skip and Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _kPrimaryTextColor,
                    ),
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

// -------------------------------------------------------------------
// 3. WIDGETS CƠ SỞ (ĐÃ ĐIỀU CHỈNH)
// -------------------------------------------------------------------

// Widget Nút Ghi âm (ĐÃ SỬA ĐỔI)
class RecordVoiceButton extends StatelessWidget {
  final VoidCallback onTap;
  
  const RecordVoiceButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap, // Gọi hàm mở lớp phủ
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
      icon: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kPrimaryTextColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _kPrimaryTextColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Icon(
          Icons.mic,
          color: _kInputFillColor,
          size: 24,
        ),
      ),
      label: const Text(
        'Record your voice',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _kPrimaryTextColor,
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------
// ... (Các Widget khác giữ nguyên) ...
// -------------------------------------------------------------------

// Widget App Bar chỉ có nút Back
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

// Widget Ô nhập liệu
class NoteInputField extends StatelessWidget {
    final String initialText;
    const NoteInputField({super.key, required this.initialText});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialText);
    return Container(
      height: 180,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _kInputFillColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller, 
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
            color: Color(0xFF2F2F30), 
            fontSize: 16,
            height: 1.5,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// Widget 2 Nút Hành động Dưới cùng (Save & Skip and Save)
class SaveActionButtons extends StatelessWidget {
  const SaveActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      color: _kBackgroundColor, 
      child: Column(
        children: [
          // Nút 1: Save (Nút chính)
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardMoodScreen(), 
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _kPrimaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bo tròn tối đa
                ),
                elevation: 5,
                shadowColor: _kPrimaryBlue.withOpacity(0.5),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Nút 2: Skip and Save (Nút phụ dạng Text)
          TextButton(
            onPressed: () {
              // Xử lý hành động Skip and Save
            },
            child: const Text(
              'Skip and Save',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _kPrimaryTextColor, // Màu đen hoặc xám đậm
              ),
            ),
          ),
        ],
      ),
    );
  }
}