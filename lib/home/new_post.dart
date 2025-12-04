import 'package:flutter/material.dart';

// --- CẤU HÌNH MÀU SẮC ---
class AppColors {
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color textDark = Color(0xFF1F2937);
  static const Color textGrey = Color(0xFF9CA3AF);
  static const Color background = Color(0xFFF3F4F6);
  static const Color surface = Colors.white;
}

// ==========================================
// 1. MÀN HÌNH CHÍNH: VIẾT BÀI (WRITE POST)
// ==========================================
class WritePostScreen extends StatefulWidget {
  const WritePostScreen({super.key});

  @override
  State<WritePostScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final TextEditingController _textController = TextEditingController();
  
  // Trạng thái dữ liệu
  String _privacy = "Public"; 
  String? _selectedLabel;
  String? _selectedCategory;
  String? _checkInLocation; // Biến lưu vị trí check-in
  
  // Danh sách ảnh đã đính kèm
  List<String> _attachedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E7EB), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5E7EB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryBlue),
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
        centerTitle: true,
        title: const Text(
          "Write post",
          style: TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF60A5FA)),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          // Card chính
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              // --- Header: Avatar, Privacy, Check-in info ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage('https://picsum.photos/200'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _showPrivacySettings,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(
                                  _privacy == "Public" ? Icons.public : Icons.lock_outline,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _privacy,
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
                                ),
                                const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
                                
                                // Hiển thị vị trí Check-in nếu có
                                if (_checkInLocation != null) ...[
                                  const SizedBox(width: 5),
                                  Text(
                                    "at $_checkInLocation",
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                                ]
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.flag_outlined, color: Colors.grey),
                      onPressed: _showSensitiveWarningDialog,
                    ),
                  ],
                ),
              ),

              // --- Content Area (Text + Images) ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _textController,
                        maxLines: null, 
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                        decoration: const InputDecoration(
                          hintText: "Say something...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Grid hiển thị ảnh
                      if (_attachedImages.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: _attachedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    _attachedImages[index],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () => setState(() => _attachedImages.removeAt(index)),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.close, color: Colors.white, size: 16),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // --- Bottom Actions Toolbar ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
                ),
                child: Row(
                  children: [
                    _CircleIconButton(
                      icon: Icons.add,
                      onTap: _showAttachmentSheet,
                    ),
                    const SizedBox(width: 12),

                    _PillButton(
                      text: _selectedLabel ?? "Label",
                      isSelected: _selectedLabel != null,
                      onTap: () async {
                        final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const LabelScreen()));
                        if (result != null) setState(() => _selectedLabel = result);
                      },
                    ),
                    const SizedBox(width: 8),

                    _PillButton(
                      text: _selectedCategory ?? "Category",
                      isSelected: _selectedCategory != null,
                      onTap: () async {
                        final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryScreen()));
                        if (result != null) setState(() => _selectedCategory = result);
                      },
                    ),

                    const Spacer(),

                    _CircleIconButton(
                      icon: Icons.arrow_forward,
                      onTap: _handleSubmit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Logic Xử lý ---

  void _handleSubmit() {
    if (_textController.text.trim().isEmpty && _attachedImages.isEmpty && _checkInLocation == null) {
      _showCustomDialog(
        context: context,
        content: "Whoops! You forgot to write something",
        buttonText: "OK",
        onBtnPressed: () => Navigator.pop(context),
        isError: true,
      );
    } else {
      _showCustomDialog(
        context: context,
        title: "Are you ready?",
        content: "Please make sure you have Trigger Warning checked if the post covers any sensitive topics.",
        buttonText: "Add",
        onBtnPressed: () {
          Navigator.pop(context);
          // Reset data
          _textController.clear();
          setState(() {
            _selectedLabel = null;
            _selectedCategory = null;
            _checkInLocation = null;
            _attachedImages.clear();
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post created!")));
        },
      );
    }
  }

  void _showSensitiveWarningDialog() {
    // ... (Giữ nguyên logic dialog warning như cũ)
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Notification", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
                  SizedBox(width: 5),
                  Icon(Icons.stars, color: Colors.red, size: 20)
                ],
              ),
              const SizedBox(height: 15),
              const Text("Does your post content address any of the following sensitive topics?", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              const Text("Please make sure you flag Trigger Warning (TW)...", textAlign: TextAlign.left, style: TextStyle(fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 10),
              const Text("Start with 'TW: [Topic]' in the body.", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  void _showAttachmentSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSheetItem(Icons.image_outlined, "Upload a photo", onTap: () async {
                 Navigator.pop(ctx);
                 final List<String>? result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const PhotoGalleryScreen()));
                 if (result != null && result.isNotEmpty) setState(() => _attachedImages.addAll(result));
              }),
              _buildSheetItem(Icons.camera_alt_outlined, "Take a photo", onTap: () async {
                Navigator.pop(ctx);
                // Mở màn hình Camera giả lập
                final String? result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const TakePhotoScreen()));
                if (result != null) setState(() => _attachedImages.add(result));
              }),
              _buildSheetItem(Icons.location_on_outlined, "Check in", onTap: () async {
                Navigator.pop(ctx);
                // Mở màn hình Check-in
                final String? result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckInScreen()));
                if (result != null) setState(() => _checkInLocation = result);
              }),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  ListTile _buildSheetItem(IconData icon, String text, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  void _showPrivacySettings() {
    // ... (Giữ nguyên logic privacy như cũ)
    showDialog(context: context, builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(alignment: Alignment.topLeft, child: GestureDetector(onTap:()=> Navigator.pop(ctx), child: const Icon(Icons.close))),
              const SizedBox(height: 10),
              const Text("Who can see your post?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Your article will be displayed on the Feed Board... default is Public.", style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 20),
              _buildPrivacyOption("Public", Icons.public, _privacy == "Public", (val) { if(val) setState(() => _privacy = "Public"); Navigator.pop(ctx); }),
              _buildPrivacyOption("Private", Icons.person_outline, _privacy == "Private", (val) { if(val) setState(() => _privacy = "Private"); Navigator.pop(ctx); }),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(ctx), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text("Save", style: TextStyle(color: Colors.white))))
            ]))));
  }

  Widget _buildPrivacyOption(String title, IconData icon, bool isSelected, Function(bool) onChanged) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(children: [Icon(icon, size: 24), const SizedBox(width: 15), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const Spacer(), Switch(value: isSelected, onChanged: onChanged, activeColor: AppColors.primaryBlue)]));
  }
}

// ==========================================
// 2. MÀN HÌNH CHỤP ẢNH (GIẢ LẬP)
// ==========================================
class TakePhotoScreen extends StatelessWidget {
  const TakePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ảnh con mèo bên bờ biển giống thiết kế
    const String simulatedImage = "https://picsum.photos/id/40/800/1200"; 

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Viewfinder (Ảnh nền giả lập camera)
          Positioned.fill(
            child: Image.network(simulatedImage, fit: BoxFit.cover),
          ),
          
          // 2. Nút Close & Flash ở trên cùng
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Icon(Icons.flash_on, color: Colors.white, size: 30),
                ],
              ),
            ),
          ),

          // 3. Controls ở dưới đáy
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(bottom: 40, top: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: Column(
                children: [
                  // Nút Chụp
                  GestureDetector(
                    onTap: () {
                      // Giả lập chụp xong trả về ảnh
                      Navigator.pop(context, simulatedImage);
                    },
                    child: Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Chế độ chụp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("BOOMERANG", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      SizedBox(width: 20),
                      Text("PHOTO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(width: 20),
                      Text("VIDEO", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ==========================================
// 3. MÀN HÌNH CHECK-IN (CHECK IN LOCATION)
// ==========================================
class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> locations = [
      {"name": "Da Nang", "sub": "9T check-ins", "icon": Icons.location_on_outlined},
      {"name": "Starbucks", "sub": "1T check-ins", "icon": Icons.coffee},
      {"name": "Ha Noi", "sub": "12T check-ins", "icon": Icons.location_on_outlined},
      {"name": "VinWonders", "sub": "90.9k check-ins", "icon": Icons.confirmation_num_outlined},
      {"name": "TP. Hồ Chí Minh", "sub": "10T check-ins", "icon": Icons.location_on_outlined},
      {"name": "Gia Lai", "sub": "99M check-ins", "icon": Icons.location_on_outlined},
      {"name": "Da Lat", "sub": "5T check-ins", "icon": Icons.location_on_outlined},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {}, // Nút Done giả
            child: const Text("Done", style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 16)),
          )
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search location....",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                ),
              ),
            ),
          ),
          const Divider(),
          
          // List Locations
          Expanded(
            child: ListView.separated(
              itemCount: locations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final loc = locations[index];
                return GestureDetector(
                  onTap: () {
                    // Trả về tên địa điểm
                    Navigator.pop(context, loc['name']);
                  },
                  child: Row(
                    children: [
                      // Icon Box vuông xám
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E7EB),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: Icon(loc['icon'], color: Colors.black87),
                      ),
                      const SizedBox(width: 15),
                      // Text Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(loc['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(loc['sub'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                      // 3 dots menu
                      const Icon(Icons.more_horiz, color: Colors.black54),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. MÀN HÌNH CHỌN ẢNH (GALLERY)
// ==========================================
class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final List<String> _allImages = List.generate(15, (index) => 'https://picsum.photos/300/300?random=$index');
  final List<String> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.black, size: 28), onPressed: () => Navigator.pop(context)),
        actions: [TextButton(onPressed: () => Navigator.pop(context, _selectedImages), child: const Text("Done", style: TextStyle(color: AppColors.primaryBlue, fontSize: 18, fontWeight: FontWeight.bold)))],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemCount: _allImages.length,
        itemBuilder: (context, index) {
          final imageUrl = _allImages[index];
          final isSelected = _selectedImages.contains(imageUrl);
          return GestureDetector(
            onTap: () => setState(() => isSelected ? _selectedImages.remove(imageUrl) : _selectedImages.add(imageUrl)),
            child: Stack(children: [
              Positioned.fill(child: Image.network(imageUrl, fit: BoxFit.cover)),
              if (isSelected) Positioned.fill(child: Container(color: Colors.white.withOpacity(0.3))),
              Positioned(top: 8, left: 8, child: Container(width: 24, height: 24, decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? AppColors.primaryBlue : Colors.transparent, border: Border.all(color: Colors.white, width: 2)), child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null))
            ]),
          );
        },
      ),
    );
  }
}

// ==========================================
// 5. MÀN HÌNH CHỌN LABEL (Giữ nguyên bản đã sửa 2 cột)
// ==========================================
class LabelScreen extends StatefulWidget {
  const LabelScreen({super.key});
  @override
  State<LabelScreen> createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  String? _tempSelectedLabel;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentLabels = ["My Story", "My Pet", "My Colleague"];
  final List<String> _allExercises = ["Diary", "Emotions", "Self-Talk", "Goal Setting", "Problem Solving", "Encourage", "Deep Breathing", "Mindfulness", "Idea Brainstorming"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black), onPressed: () => Navigator.pop(context)), elevation: 0, backgroundColor: Colors.white, centerTitle: true, title: const Text("Please choose a label", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))),
      body: Column(children: [
          const Text("Select label", style: TextStyle(color: Colors.grey, fontSize: 14)), const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(height: 50, decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(30)), child: TextField(controller: _searchController, textAlignVertical: TextAlignVertical.center, decoration: const InputDecoration(prefixIcon: Icon(Icons.search, color: Colors.black54), hintText: "Search", border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 20))))),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Recent used", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 15),
                  GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 2.8), itemCount: _recentLabels.length, itemBuilder: (context, index) => _buildPillButton(text: _recentLabels[index], isSelected: _tempSelectedLabel == _recentLabels[index], onTap: () => setState(() => _tempSelectedLabel = _recentLabels[index]), isGridItem: true)),
                  const SizedBox(height: 30),
                  const Text("All exercises", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 15),
                  GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 2.8), itemCount: _allExercises.length, itemBuilder: (context, index) => _buildPillButton(text: _allExercises[index], isSelected: _tempSelectedLabel == _allExercises[index], onTap: () => setState(() => _tempSelectedLabel = _allExercises[index]), isGridItem: true)),
                  const SizedBox(height: 80)]))),
        ]),
      bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: SizedBox(height: 55, child: ElevatedButton(onPressed: () => Navigator.pop(context, _tempSelectedLabel), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 0), child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))))),
    );
  }

  Widget _buildPillButton({required String text, required bool isSelected, required VoidCallback onTap, bool isGridItem = false}) {
    return GestureDetector(onTap: onTap, child: Container(width: isGridItem ? double.infinity : null, padding: EdgeInsets.symmetric(horizontal: 24, vertical: isGridItem ? 0 : 12), alignment: Alignment.center, decoration: ShapeDecoration(color: isSelected ? AppColors.primaryBlue : Colors.white, shape: StadiumBorder(side: BorderSide(color: isSelected ? AppColors.primaryBlue : const Color(0xFF3B82F6), width: 1))), child: FittedBox(fit: BoxFit.scaleDown, child: Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, fontSize: 15)))));
  }
}

// ==========================================
// 6. MÀN HÌNH CHỌN CATEGORY (Giữ nguyên)
// ==========================================
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? _tempSelectedCategory;
  final List<Map<String, String>> _categories = [{"name": "Small Wins", "icon": "🏆"}, {"name": "Grateful", "icon": "🙏"}, {"name": "Confide", "icon": "🤝"}, {"name": "Strategy", "icon": "📊"}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black), onPressed: () => Navigator.pop(context)), elevation: 0, backgroundColor: Colors.white, centerTitle: true, title: const Text("Please choose a category", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))),
      body: Column(children: [
          const Text("Select a category", style: TextStyle(color: Colors.grey, fontSize: 14)), const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(height: 50, decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(30)), child: const TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search, color: Colors.black54), hintText: "Search", border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15))))),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("All Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 20),
                  GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.8, crossAxisSpacing: 20, mainAxisSpacing: 30), itemCount: _categories.length, itemBuilder: (context, index) {
                      final item = _categories[index]; final isSelected = _tempSelectedCategory == item['name'];
                      return GestureDetector(onTap: () => setState(() => _tempSelectedCategory = item['name']), child: Container(alignment: Alignment.center, decoration: ShapeDecoration(color: Colors.white, shape: StadiumBorder(side: BorderSide(color: isSelected ? AppColors.primaryBlue : Colors.transparent, width: 2))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(item['name']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)), const SizedBox(width: 8), Text(item['icon']!, style: const TextStyle(fontSize: 20))])));
                    })]))),
        ]),
      bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: SizedBox(height: 55, child: ElevatedButton(onPressed: () => Navigator.pop(context, _tempSelectedCategory), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 0), child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))))),
    );
  }
}

// ==========================================
// 7. WIDGETS & HELPER
// ==========================================
void _showCustomDialog({required BuildContext context, String? title, required String content, required String buttonText, required VoidCallback onBtnPressed, bool isError = false}) {
  showDialog(context: context, builder: (ctx) => Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), child: Padding(padding: const EdgeInsets.all(24.0), child: Column(mainAxisSize: MainAxisSize.min, children: [if (isError) Align(alignment: Alignment.topRight, child: GestureDetector(onTap: () => Navigator.pop(ctx), child: const Icon(Icons.close, color: AppColors.primaryBlue, size: 28))), if (title != null) Padding(padding: const EdgeInsets.only(bottom: 10.0), child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))), Text(content, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.black87)), const SizedBox(height: 25), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onBtnPressed, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), padding: const EdgeInsets.symmetric(vertical: 14)), child: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))))]))));
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon; final VoidCallback onTap; const _CircleIconButton({required this.icon, required this.onTap});
  @override Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)), child: Icon(icon, color: Colors.grey.shade600, size: 20)));
}

class _PillButton extends StatelessWidget {
  final String text; final bool isSelected; final VoidCallback onTap; const _PillButton({required this.text, this.isSelected = false, required this.onTap});
  @override Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), decoration: BoxDecoration(color: isSelected ? Colors.grey[200] : Colors.transparent, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade300)), child: Text(text, style: TextStyle(color: Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal))));
}