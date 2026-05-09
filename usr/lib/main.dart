import 'package:flutter/material.dart';

void main() {
  runApp(const CakePresentationApp());
}

class CakePresentationApp extends StatelessWidget {
  const CakePresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cake Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
        fontFamily: 'Roboto', // Default fallback, but Flutter will handle Thai characters fine.
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> slides = [
    SlideData(
      title: "ยินดีต้อนรับสู่โลกของเค้ก 🎂",
      subtitle: "ความหวานที่ลงตัวสำหรับทุกโอกาส",
      description:
          "เค้กไม่ได้เป็นเพียงแค่ของหวาน แต่เป็นสัญลักษณ์ของการเฉลิมฉลอง ความสุข และความทรงจำที่ดีในทุกช่วงเวลาสำคัญของชีวิต",
      icon: Icons.cake,
      backgroundColor: const Color(0xFFFFF0F5), // Lavender Blush
      iconColor: Colors.pinkAccent,
    ),
    SlideData(
      title: "เค้กคืออะไร? 🍰",
      subtitle: "ศิลปะแห่งการอบขนม",
      description:
          "เค้กคือขนมอบที่มีส่วนผสมหลักได้แก่ แป้ง น้ำตาล ไข่ เนย และนม ผ่านกระบวนการอบจนฟูนุ่ม มีหลากหลายรสชาติและเนื้อสัมผัส",
      icon: Icons.bakery_dining,
      backgroundColor: const Color(0xFFF0F8FF), // Alice Blue
      iconColor: Colors.blueAccent,
    ),
    SlideData(
      title: "ประเภทของเค้กที่นิยม 🧁",
      subtitle: "เลือกแบบที่ใช่ สไตล์ที่ชอบ",
      description:
          "• สปันจ์เค้ก (Sponge Cake): เนื้อเบานุ่ม\n• บัตเตอร์เค้ก (Butter Cake): เนื้อแน่น หอมเนย\n• ชิฟฟอนเค้ก (Chiffon Cake): เบาฟู ละลายในปาก\n• ชีสเค้ก (Cheesecake): เข้มข้น หอมชีส",
      icon: Icons.auto_awesome,
      backgroundColor: const Color(0xFFF5FFFA), // Mint Cream
      iconColor: Colors.teal,
    ),
    SlideData(
      title: "ทำไมเราถึงรักเค้ก? ❤️",
      subtitle: "มากกว่าความอร่อย คือความสุข",
      description:
          "เพราะเค้กช่วยเติมเต็มความหวานให้กับชีวิต ไม่ว่าจะเป็นวันเกิด วันแต่งงาน หรือแค่วันธรรมดาที่ต้องการรางวัลเล็กๆ น้อยๆ ให้กับตัวเอง",
      icon: Icons.favorite,
      backgroundColor: const Color(0xFFFFFACD), // Lemon Chiffon
      iconColor: Colors.orangeAccent,
    ),
  ];

  void _nextPage() {
    if (_currentPage < slides.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SlideWidget(slide: slides[index]);
            },
          ),
          // Navigation controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage > 0
                      ? IconButton(
                          onPressed: _previousPage,
                          icon: const Icon(Icons.arrow_back_ios, size: 28),
                          color: Colors.black54,
                          tooltip: 'ย้อนกลับ',
                        )
                      : const SizedBox(width: 44), // Placeholder to keep alignment
                  // Dots indicator
                  Row(
                    children: List.generate(
                      slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentPage == index ? 24.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? slides[_currentPage].iconColor
                              : Colors.black26,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  _currentPage < slides.length - 1
                      ? IconButton(
                          onPressed: _nextPage,
                          icon: const Icon(Icons.arrow_forward_ios, size: 28),
                          color: Colors.black54,
                          tooltip: 'ถัดไป',
                        )
                      : const SizedBox(width: 44),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;

  const SlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: slide.backgroundColor,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  slide.icon,
                  size: 120,
                  color: slide.iconColor,
                ),
                const SizedBox(height: 40),
                Text(
                  slide.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: slide.iconColor.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  slide.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  slide.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.8,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 60), // Space for bottom navigation
              ],
            ),
          ),
        ),
      ),
    );
  }
}
