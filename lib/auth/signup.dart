import 'package:flutter/material.dart';

import 'login.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  // Hàm xây dựng các widget minh họa/hình ảnh
  Widget _buildIllustration(BuildContext context) {
    // Lấy kích thước màn hình để tính toán kích thước hình ảnh
    final screenWidth = MediaQuery.of(context).size.width;
    // Chiều rộng hình ảnh chiếm 80% màn hình để đảm bảo nó không bị tràn
    final imageWidth = screenWidth * 0.8; 

    return Image.asset( // <--- Sử dụng Image.asset cho ảnh local
      'assets/images/signup.png', // <-- ĐƯỜNG DẪN CỦA BẠN ĐÃ ĐƯỢC CHÈN
      width: imageWidth,
      fit: BoxFit.contain, // Đảm bảo hình ảnh được hiển thị vừa vặn
    );
  }

  @override
  Widget build(BuildContext context) {
    // Màu sắc chung
    const Color primaryBlue = Color(0xFF4285F4);
    const Color lightGrey = Color(0xFFF0F0F0);
    const Color accentRed = Color(0xFFEA4335);

    return Scaffold(
      backgroundColor: Colors.white,
      // Đặt màn hình vào SafeArea để tránh các vùng như notch
      body: SafeArea( 
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // ## Phần Hình ảnh Minh họa (Đã sửa lỗi và căn giữa)
                Center( 
                  child: _buildIllustration(context),
                ),
                const SizedBox(height: 48),

                // ## Tiêu đề Chào mừng
                const Text(
                  'Get started',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create an anonymous account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // ## Trường nhập Username
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    fillColor: lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                  ),
                ),
                const SizedBox(height: 16),

                // ## Trường nhập Password
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility_off,
                          color: Colors.black54), // Biểu tượng mắt
                      onPressed: () {
                        // Xử lý hiển thị/ẩn mật khẩu
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ## Quên mật khẩu
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       // Xử lý quên mật khẩu
                //     },
                //     child: const Text(
                //       'Forget password ?',
                //       style: TextStyle(
                //         color: accentRed,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),

                // ## Nút "Continue with Google"
                ElevatedButton.icon(
                  onPressed: () {
                    // Xử lý đăng nhập với Google
                  },
                  icon: const Icon(Icons.g_mobiledata, size: 28), // Biểu tượng Google (minh họa)
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ## Nút "Login"
                ElevatedButton(
                  onPressed: () {
                    // Xử lý đăng nhập
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ## Đăng ký
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Already a member ? ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(), 
                          ),
                        );
                      },
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: accentRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}