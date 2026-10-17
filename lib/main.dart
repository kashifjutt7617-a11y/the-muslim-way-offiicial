import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MuslimWayApp());
}

class AppColors {
  static const Color deepGreen = Color(0xFF0B4F3A);
  static const Color lightGreen = Color(0xFF1B6B4F);
  static const Color gold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFE8C766);
  static const Color cream = Color(0xFFFDFBF5);
  static const Color darkText = Color(0xFF1A1A1A);
}

class MuslimWayApp extends StatelessWidget {
  const MuslimWayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Muslim Way Offiicial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.deepGreen,
        scaffoldBackgroundColor: AppColors.cream,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.deepGreen, AppColors.lightGreen],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mosque, size: 100, color: AppColors.gold),
              SizedBox(height: 30),
              Text(
                'The Muslim Way',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Offiicial',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.lightGold,
                  letterSpacing: 4,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(color: AppColors.gold),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _openQuran(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuranPage()),
    );
  }

  String _formatDate(DateTime dt) {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday'
    ];
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  String _formatTime(DateTime dt) {
    int hour = dt.hour;
    final String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final String h = hour.toString().padLeft(2, '0');
    final String m = dt.minute.toString().padLeft(2, '0');
    final String s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s $period';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildQuickAccess(context),
                const SizedBox(height: 20),
                _buildDailyAyah(),
                const SizedBox(height: 25),
                _buildContactSection(context),
                const SizedBox(height: 25),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepGreen, AppColors.lightGreen],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 2),
                ),
                child: const Icon(Icons.mosque, color: AppColors.gold, size: 28),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Muslim Way',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Offiicial',
                      style: TextStyle(
                        color: AppColors.lightGold,
                        fontSize: 14,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.gold.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.gold, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(_now),
                      style: const TextStyle(
                        color: AppColors.cream,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: AppColors.gold, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(_now),
                      style: const TextStyle(
                        color: AppColors.cream,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'السلام علیکم',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'خوش آمدید! آج کا دن بابرکت ہو',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _makeCard(
                context, 
                Icons.menu_book, 
                'قرآن پاک', 
                AppColors.deepGreen, 
                customAction: () => _openQuran(context),
              ),
              _makeCard(
  context, 
  Icons.auto_stories, 
  'صحیح حدیث', 
  AppColors.lightGreen,
  customAction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HadithBooksPage())),
),
              _makeCard(
  context, 
  Icons.volunteer_activism, 
  'دعائیں و اذکار', 
  AppColors.gold,
  customAction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DuasPage())),
),
              _makeCard(context, Icons.auto_awesome, 'استخارہ', AppColors.deepGreen),
              _makeCard(context, Icons.access_time, 'نماز کے اوقات', AppColors.deepGreen),
              _makeCard(context, Icons.explore, 'قبلہ کمپاس', AppColors.lightGreen),
              _makeCard(context, Icons.calendar_month, 'اسلامی کیلنڈر', AppColors.gold),
              _makeCard(context, Icons.help_outline, 'روز مرہ مسائل', AppColors.lightGreen),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyAyah() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: const Column(
          children: [
            Row(
              children: [
                Icon(Icons.brightness_5, color: AppColors.gold, size: 22),
                SizedBox(width: 8),
                Text(
                  'آج کی آیت',
                  style: TextStyle(
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'إِنَّ مَعَ الْعُسْرِ يُسْرًا',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
                fontFamily: 'serif',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '"بے شک مشکل کے ساتھ آسانی ہے"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.darkText,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '(سورۃ الشرح: 6)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'رابطہ کریں',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _makeContact(context, Icons.chat, 'WhatsApp', 'واٹس ایپ پر رابطہ', const Color(0xFF25D366)),
              const SizedBox(height: 10),
              _makeContact(context, Icons.phone, 'Call', 'فون کال کریں', AppColors.deepGreen),
              const SizedBox(height: 10),
              _makeContact(context, Icons.language, 'Website', 'themuslimwayoffiicial.com', AppColors.gold),
            ],
          ),
        ),
      ],
    );
  }

  Widget _makeContact(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(title)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_back_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _makeCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color, {
    VoidCallback? customAction,
  }) {
    return GestureDetector(
      onTap: () {
        if (customAction != null) {
          customAction();
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ComingSoonPage(title: title, icon: icon),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.deepGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: const Column(
        children: [
          Icon(Icons.mosque, color: AppColors.gold, size: 30),
          SizedBox(height: 10),
          Text(
            'The Muslim Way Offiicial',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'version 1.0.0',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  static const List<Map<String, dynamic>> surahs = [
    {'n': 1, 'name': 'الفاتحہ', 'en': 'Al-Fatihah', 'ayat': 7, 'type': 'مکی'},
    {'n': 2, 'name': 'البقرہ', 'en': 'Al-Baqarah', 'ayat': 286, 'type': 'مدنی'},
    {'n': 3, 'name': 'آل عمران', 'en': 'Aal-Imran', 'ayat': 200, 'type': 'مدنی'},
    {'n': 4, 'name': 'النساء', 'en': 'An-Nisa', 'ayat': 176, 'type': 'مدنی'},
    {'n': 5, 'name': 'المائدہ', 'en': 'Al-Maidah', 'ayat': 120, 'type': 'مدنی'},
    {'n': 6, 'name': 'الانعام', 'en': 'Al-Anam', 'ayat': 165, 'type': 'مکی'},
    {'n': 7, 'name': 'الاعراف', 'en': 'Al-Araf', 'ayat': 206, 'type': 'مکی'},
    {'n': 8, 'name': 'الانفال', 'en': 'Al-Anfal', 'ayat': 75, 'type': 'مدنی'},
    {'n': 9, 'name': 'التوبہ', 'en': 'At-Taubah', 'ayat': 129, 'type': 'مدنی'},
    {'n': 10, 'name': 'یونس', 'en': 'Yunus', 'ayat': 109, 'type': 'مکی'},
    {'n': 11, 'name': 'ہود', 'en': 'Hud', 'ayat': 123, 'type': 'مکی'},
    {'n': 12, 'name': 'یوسف', 'en': 'Yusuf', 'ayat': 111, 'type': 'مکی'},
    {'n': 13, 'name': 'الرعد', 'en': 'Ar-Rad', 'ayat': 43, 'type': 'مدنی'},
    {'n': 14, 'name': 'ابراہیم', 'en': 'Ibrahim', 'ayat': 52, 'type': 'مکی'},
    {'n': 15, 'name': 'الحجر', 'en': 'Al-Hijr', 'ayat': 99, 'type': 'مکی'},
    {'n': 16, 'name': 'النحل', 'en': 'An-Nahl', 'ayat': 128, 'type': 'مکی'},
    {'n': 17, 'name': 'الاسراء', 'en': 'Al-Isra', 'ayat': 111, 'type': 'مکی'},
    {'n': 18, 'name': 'الکہف', 'en': 'Al-Kahf', 'ayat': 110, 'type': 'مکی'},
    {'n': 19, 'name': 'مریم', 'en': 'Maryam', 'ayat': 98, 'type': 'مکی'},
    {'n': 20, 'name': 'طہ', 'en': 'Ta-Ha', 'ayat': 135, 'type': 'مکی'},
    {'n': 21, 'name': 'الانبیاء', 'en': 'Al-Anbiya', 'ayat': 112, 'type': 'مکی'},
    {'n': 22, 'name': 'الحج', 'en': 'Al-Hajj', 'ayat': 78, 'type': 'مدنی'},
    {'n': 23, 'name': 'المؤمنون', 'en': 'Al-Muminun', 'ayat': 118, 'type': 'مکی'},
    {'n': 24, 'name': 'النور', 'en': 'An-Nur', 'ayat': 64, 'type': 'مدنی'},
    {'n': 25, 'name': 'الفرقان', 'en': 'Al-Furqan', 'ayat': 77, 'type': 'مکی'},
    {'n': 26, 'name': 'الشعراء', 'en': 'Ash-Shuara', 'ayat': 227, 'type': 'مکی'},
    {'n': 27, 'name': 'النمل', 'en': 'An-Naml', 'ayat': 93, 'type': 'مکی'},
    {'n': 28, 'name': 'القصص', 'en': 'Al-Qasas', 'ayat': 88, 'type': 'مکی'},
    {'n': 29, 'name': 'العنکبوت', 'en': 'Al-Ankabut', 'ayat': 69, 'type': 'مکی'},
    {'n': 30, 'name': 'الروم', 'en': 'Ar-Rum', 'ayat': 60, 'type': 'مکی'},
    {'n': 31, 'name': 'لقمان', 'en': 'Luqman', 'ayat': 34, 'type': 'مکی'},
    {'n': 32, 'name': 'السجدہ', 'en': 'As-Sajdah', 'ayat': 30, 'type': 'مکی'},
    {'n': 33, 'name': 'الاحزاب', 'en': 'Al-Ahzab', 'ayat': 73, 'type': 'مدنی'},
    {'n': 34, 'name': 'سبا', 'en': 'Saba', 'ayat': 54, 'type': 'مکی'},
    {'n': 35, 'name': 'فاطر', 'en': 'Fatir', 'ayat': 45, 'type': 'مکی'},
    {'n': 36, 'name': 'یٰسین', 'en': 'Ya-Sin', 'ayat': 83, 'type': 'مکی'},
    {'n': 37, 'name': 'الصافات', 'en': 'As-Saffat', 'ayat': 182, 'type': 'مکی'},
    {'n': 38, 'name': 'ص', 'en': 'Sad', 'ayat': 88, 'type': 'مکی'},
    {'n': 39, 'name': 'الزمر', 'en': 'Az-Zumar', 'ayat': 75, 'type': 'مکی'},
    {'n': 40, 'name': 'المؤمن', 'en': 'Al-Mumin', 'ayat': 85, 'type': 'مکی'},
    {'n': 41, 'name': 'فصلت', 'en': 'Fussilat', 'ayat': 54, 'type': 'مکی'},
    {'n': 42, 'name': 'الشوریٰ', 'en': 'Ash-Shura', 'ayat': 53, 'type': 'مکی'},
    {'n': 43, 'name': 'الزخرف', 'en': 'Az-Zukhruf', 'ayat': 89, 'type': 'مکی'},
    {'n': 44, 'name': 'الدخان', 'en': 'Ad-Dukhan', 'ayat': 59, 'type': 'مکی'},
    {'n': 45, 'name': 'الجاثیہ', 'en': 'Al-Jathiyah', 'ayat': 37, 'type': 'مکی'},
    {'n': 46, 'name': 'الاحقاف', 'en': 'Al-Ahqaf', 'ayat': 35, 'type': 'مکی'},
    {'n': 47, 'name': 'محمد', 'en': 'Muhammad', 'ayat': 38, 'type': 'مدنی'},
    {'n': 48, 'name': 'الفتح', 'en': 'Al-Fath', 'ayat': 29, 'type': 'مدنی'},
    {'n': 49, 'name': 'الحجرات', 'en': 'Al-Hujurat', 'ayat': 18, 'type': 'مدنی'},
    {'n': 50, 'name': 'ق', 'en': 'Qaf', 'ayat': 45, 'type': 'مکی'},
    {'n': 51, 'name': 'الذاریات', 'en': 'Adh-Dhariyat', 'ayat': 60, 'type': 'مکی'},
    {'n': 52, 'name': 'الطور', 'en': 'At-Tur', 'ayat': 49, 'type': 'مکی'},
    {'n': 53, 'name': 'النجم', 'en': 'An-Najm', 'ayat': 62, 'type': 'مکی'},
    {'n': 54, 'name': 'القمر', 'en': 'Al-Qamar', 'ayat': 55, 'type': 'مکی'},
    {'n': 55, 'name': 'الرحمن', 'en': 'Ar-Rahman', 'ayat': 78, 'type': 'مدنی'},
    {'n': 56, 'name': 'الواقعہ', 'en': 'Al-Waqiah', 'ayat': 96, 'type': 'مکی'},
    {'n': 57, 'name': 'الحدید', 'en': 'Al-Hadid', 'ayat': 29, 'type': 'مدنی'},
    {'n': 58, 'name': 'المجادلہ', 'en': 'Al-Mujadila', 'ayat': 22, 'type': 'مدنی'},
    {'n': 59, 'name': 'الحشر', 'en': 'Al-Hashr', 'ayat': 24, 'type': 'مدنی'},
    {'n': 60, 'name': 'الممتحنہ', 'en': 'Al-Mumtahanah', 'ayat': 13, 'type': 'مدنی'},
    {'n': 61, 'name': 'الصف', 'en': 'As-Saff', 'ayat': 14, 'type': 'مدنی'},
    {'n': 62, 'name': 'الجمعہ', 'en': 'Al-Jumuah', 'ayat': 11, 'type': 'مدنی'},
    {'n': 63, 'name': 'المنافقون', 'en': 'Al-Munafiqun', 'ayat': 11, 'type': 'مدنی'},
    {'n': 64, 'name': 'التغابن', 'en': 'At-Taghabun', 'ayat': 18, 'type': 'مدنی'},
    {'n': 65, 'name': 'الطلاق', 'en': 'At-Talaq', 'ayat': 12, 'type': 'مدنی'},
    {'n': 66, 'name': 'التحریم', 'en': 'At-Tahrim', 'ayat': 12, 'type': 'مدنی'},
    {'n': 67, 'name': 'الملک', 'en': 'Al-Mulk', 'ayat': 30, 'type': 'مکی'},
    {'n': 68, 'name': 'القلم', 'en': 'Al-Qalam', 'ayat': 52, 'type': 'مکی'},
    {'n': 69, 'name': 'الحاقہ', 'en': 'Al-Haqqah', 'ayat': 52, 'type': 'مکی'},
    {'n': 70, 'name': 'المعارج', 'en': 'Al-Maarij', 'ayat': 44, 'type': 'مکی'},
    {'n': 71, 'name': 'نوح', 'en': 'Nuh', 'ayat': 28, 'type': 'مکی'},
    {'n': 72, 'name': 'الجن', 'en': 'Al-Jinn', 'ayat': 28, 'type': 'مکی'},
    {'n': 73, 'name': 'المزمل', 'en': 'Al-Muzzammil', 'ayat': 20, 'type': 'مکی'},
    {'n': 74, 'name': 'المدثر', 'en': 'Al-Muddaththir', 'ayat': 56, 'type': 'مکی'},
    {'n': 75, 'name': 'القیامہ', 'en': 'Al-Qiyamah', 'ayat': 40, 'type': 'مکی'},
    {'n': 76, 'name': 'الدہر', 'en': 'Ad-Dahr', 'ayat': 31, 'type': 'مدنی'},
    {'n': 77, 'name': 'المرسلات', 'en': 'Al-Mursalat', 'ayat': 50, 'type': 'مکی'},
    {'n': 78, 'name': 'النبأ', 'en': 'An-Naba', 'ayat': 40, 'type': 'مکی'},
    {'n': 79, 'name': 'النازعات', 'en': 'An-Naziat', 'ayat': 46, 'type': 'مکی'},
    {'n': 80, 'name': 'عبس', 'en': 'Abasa', 'ayat': 42, 'type': 'مکی'},
    {'n': 81, 'name': 'التکویر', 'en': 'At-Takwir', 'ayat': 29, 'type': 'مکی'},
    {'n': 82, 'name': 'الانفطار', 'en': 'Al-Infitar', 'ayat': 19, 'type': 'مکی'},
    {'n': 83, 'name': 'المطففین', 'en': 'Al-Mutaffifin', 'ayat': 36, 'type': 'مکی'},
    {'n': 84, 'name': 'الانشقاق', 'en': 'Al-Inshiqaq', 'ayat': 25, 'type': 'مکی'},
    {'n': 85, 'name': 'البروج', 'en': 'Al-Buruj', 'ayat': 22, 'type': 'مکی'},
    {'n': 86, 'name': 'الطارق', 'en': 'At-Tariq', 'ayat': 17, 'type': 'مکی'},
    {'n': 87, 'name': 'الاعلیٰ', 'en': 'Al-Ala', 'ayat': 19, 'type': 'مکی'},
    {'n': 88, 'name': 'الغاشیہ', 'en': 'Al-Ghashiyah', 'ayat': 26, 'type': 'مکی'},
    {'n': 89, 'name': 'الفجر', 'en': 'Al-Fajr', 'ayat': 30, 'type': 'مکی'},
    {'n': 90, 'name': 'البلد', 'en': 'Al-Balad', 'ayat': 20, 'type': 'مکی'},
    {'n': 91, 'name': 'الشمس', 'en': 'Ash-Shams', 'ayat': 15, 'type': 'مکی'},
    {'n': 92, 'name': 'اللیل', 'en': 'Al-Lail', 'ayat': 21, 'type': 'مکی'},
    {'n': 93, 'name': 'الضحیٰ', 'en': 'Ad-Duha', 'ayat': 11, 'type': 'مکی'},
    {'n': 94, 'name': 'الشرح', 'en': 'Ash-Sharh', 'ayat': 8, 'type': 'مکی'},
    {'n': 95, 'name': 'التین', 'en': 'At-Tin', 'ayat': 8, 'type': 'مکی'},
    {'n': 96, 'name': 'العلق', 'en': 'Al-Alaq', 'ayat': 19, 'type': 'مکی'},
    {'n': 97, 'name': 'القدر', 'en': 'Al-Qadr', 'ayat': 5, 'type': 'مکی'},
    {'n': 98, 'name': 'البینہ', 'en': 'Al-Bayyinah', 'ayat': 8, 'type': 'مدنی'},
    {'n': 99, 'name': 'الزلزلہ', 'en': 'Az-Zalzalah', 'ayat': 8, 'type': 'مدنی'},
    {'n': 100, 'name': 'العادیات', 'en': 'Al-Adiyat', 'ayat': 11, 'type': 'مکی'},
    {'n': 101, 'name': 'القارعہ', 'en': 'Al-Qariah', 'ayat': 11, 'type': 'مکی'},
    {'n': 102, 'name': 'التکاثر', 'en': 'At-Takathur', 'ayat': 8, 'type': 'مکی'},
    {'n': 103, 'name': 'العصر', 'en': 'Al-Asr', 'ayat': 3, 'type': 'مکی'},
    {'n': 104, 'name': 'الہمزہ', 'en': 'Al-Humazah', 'ayat': 9, 'type': 'مکی'},
    {'n': 105, 'name': 'الفیل', 'en': 'Al-Fil', 'ayat': 5, 'type': 'مکی'},
    {'n': 106, 'name': 'قریش', 'en': 'Quraish', 'ayat': 4, 'type': 'مکی'},
    {'n': 107, 'name': 'الماعون', 'en': 'Al-Maun', 'ayat': 7, 'type': 'مکی'},
    {'n': 108, 'name': 'الکوثر', 'en': 'Al-Kauthar', 'ayat': 3, 'type': 'مکی'},
    {'n': 109, 'name': 'الکافرون', 'en': 'Al-Kafirun', 'ayat': 6, 'type': 'مکی'},
    {'n': 110, 'name': 'النصر', 'en': 'An-Nasr', 'ayat': 3, 'type': 'مدنی'},
    {'n': 111, 'name': 'اللہب', 'en': 'Al-Lahab', 'ayat': 5, 'type': 'مکی'},
    {'n': 112, 'name': 'الاخلاص', 'en': 'Al-Ikhlas', 'ayat': 4, 'type': 'مکی'},
    {'n': 113, 'name': 'الفلق', 'en': 'Al-Falaq', 'ayat': 5, 'type': 'مکی'},
    {'n': 114, 'name': 'الناس', 'en': 'An-Nas', 'ayat': 6, 'type': 'مکی'},
  ];
    @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          title: const Text(
            'قرآن پاک',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];
            return _SurahTile(
              number: surah['n'],
              name: surah['name'],
              englishName: surah['en'],
              ayatCount: surah['ayat'],
              type: surah['type'],
            );
          },
        ),
      ),
    );
  }
}

class _SurahTile extends StatelessWidget {
  final int number;
  final String name;
  final String englishName;
  final int ayatCount;
  final String type;

  const _SurahTile({
    required this.number,
    required this.name,
    required this.englishName,
    required this.ayatCount,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ComingSoonPage(
              title: name,
              icon: Icons.menu_book,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.gold.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.deepGreen.withOpacity(0.1),
                border: Border.all(color: AppColors.deepGreen, width: 1.5),
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepGreen,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepGreen,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    englishName,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$ayatCount آیات',
                  style: const TextStyle(fontSize: 12, color: AppColors.gold),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ComingSoonPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const ComingSoonPage({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: AppColors.gold),
            const SizedBox(height: 20),
            const Text(
              'بہت جلد دستیاب ہوگا',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'ان شاء اللہ',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HADITH BOOKS PAGE — صحاح ستہ
// ============================================================
class HadithBooksPage extends StatelessWidget {
  const HadithBooksPage({super.key});

  static const List<Map<String, dynamic>> hadithBooks = [
    {
      'name': 'صحیح بخاری',
      'en': 'Sahih al-Bukhari',
      'ayat': '7,563 احادیث',
      'icon': Icons.menu_book,
      'color': Color(0xFF0B4F3A),
    },
    {
      'name': 'صحیح مسلم',
      'en': 'Sahih Muslim',
      'ayat': '7,500 احادیث',
      'icon': Icons.auto_stories,
      'color': Color(0xFF1B6B4F),
    },
    {
      'name': 'سنن ابو داؤد',
      'en': 'Sunan Abu Dawood',
      'ayat': '5,274 احادیث',
      'icon': Icons.book,
      'color': Color(0xFFD4AF37),
    },
    {
      'name': 'جامع ترمذی',
      'en': 'Jami` at-Tirmidhi',
      'ayat': '3,956 احادیث',
      'icon': Icons.library_books,
      'color': Color(0xFF8B5A2B),
    },
    {
      'name': 'سنن نسائی',
      'en': 'Sunan an-Nasa\'i',
      'ayat': '5,758 احادیث',
      'icon': Icons.class_,
      'color': Color(0xFF2E4053),
    },
    {
      'name': 'سنن ابن ماجہ',
      'en': 'Sunan Ibn Majah',
      'ayat': '4,341 احادیث',
      'icon': Icons.bookmark,
      'color': Color(0xFF6C3483),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          title: const Text(
            'صحیح حدیث',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: hadithBooks.length,
          itemBuilder: (context, index) {
            final book = hadithBooks[index];
            return _HadithBookTile(book: book);
          },
        ),
      ),
    );
  }
}

class _HadithBookTile extends StatelessWidget {
  final Map<String, dynamic> book;

  const _HadithBookTile({required this.book});

  @override
  Widget build(BuildContext context) {
    final Color color = book['color'];
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ComingSoonPage(
              title: book['name'],
              icon: book['icon'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Book Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Icon(book['icon'], color: color, size: 32),
              ),
              const SizedBox(width: 16),
              
              // Book Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book['en'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.format_list_bulleted, size: 14, color: color),
                        const SizedBox(width: 4),
                        Text(
                          book['ayat'],
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Arrow Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
                child: Icon(Icons.arrow_back_ios, color: color, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DUAS PAGE — دعائیں و اذکار
// ============================================================
class DuasPage extends StatelessWidget {
  const DuasPage({super.key});

  static const List<Map<String, dynamic>> duaCategories = [
  {
    'name': 'صبح کی دعائیں',
    'en': 'Morning Duas',
    'icon': Icons.wb_sunny,
    'color': Color(0xFFFFA500),
    'duas': [
      {'title': 'صبح کی دعا', 'arabic': 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ', 'urdu': 'ہم نے صبح کی اور ساری بادشاہت اللہ ہی کے لیے صبح ہوئی، اور سب تعریف اللہ کے لیے ہے۔ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں۔', 'ref': 'صحیح مسلم: 2723'},
      {'title': 'حفظ کی دعا', 'arabic': 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ', 'urdu': 'اللہ کے نام سے، جس کے نام کے ساتھ زمین اور آسمان میں کوئی چیز نقصان نہیں پہنچا سکتی، اور وہ سننے والا جاننے والا ہے۔ (تین بار پڑھیں)', 'ref': 'ابو داؤد: 5088'},
      {'title': 'سید الاستغفار', 'arabic': 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ', 'urdu': 'اے اللہ! تو میرا رب ہے، تیرے سوا کوئی معبود نہیں۔ تو نے مجھے پیدا کیا، میں تیرا بندہ ہوں۔ میں اپنی طاقت کے مطابق تیرے عہد پر قائم ہوں۔ میں اپنے کیے ہوئے گناہوں سے تیری پناہ مانگتا ہوں۔ میں تیرے احسانات کا اعتراف کرتا ہوں اور اپنے گناہوں کا بھی۔ پس مجھے بخش دے، کیونکہ تیرے سوا کوئی گناہ نہیں بخش سکتا۔', 'ref': 'صحیح بخاری: 6306'},
    ]
  },
  {
    'name': 'شام کی دعائیں',
    'en': 'Evening Duas',
    'icon': Icons.nights_stay,
    'color': Color(0xFF4A235A),
    'duas': [
      {'title': 'شام کی دعا', 'arabic': 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ', 'urdu': 'ہم نے شام کی اور ساری بادشاہت اللہ ہی کے لیے شام ہوئی، اور سب تعریف اللہ کے لیے ہے۔ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں۔', 'ref': 'صحیح مسلم: 2723'},
      {'title': 'حفظ کی دعا', 'arabic': 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ', 'urdu': 'اللہ کے نام سے، جس کے نام کے ساتھ زمین اور آسمان میں کوئی چیز نقصان نہیں پہنچا سکتی، اور وہ سننے والا جاننے والا ہے۔ (تین بار پڑھیں)', 'ref': 'ابو داؤد: 5088'},
      {'title': 'شام کے وقت کی ایک اور دعا', 'arabic': 'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ', 'urdu': 'اے اللہ! تیری مدد سے ہم نے شام کی اور تیری مدد سے ہم نے صبح کی، تیری مدد سے ہم زندہ ہیں اور تیری مدد سے ہم مرتے ہیں، اور تیری ہی طرف لوٹنا ہے۔', 'ref': 'ترمذی: 3391'},
    ]
  },
  {
    'name': 'سونے کی دعائیں',
    'en': 'Sleeping Duas',
    'icon': Icons.hotel,
    'color': Color(0xFF1B4F72),
    'duas': [
      {'title': 'سونے کی دعا', 'arabic': 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا', 'urdu': 'اے اللہ! تیرے نام سے میں مرتا ہوں (سوتا ہوں) اور جیتا ہوں (جاگتا ہوں)۔', 'ref': 'صحیح بخاری: 6324'},
      {'title': 'بستر پر جانے کی دعا', 'arabic': 'اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ', 'urdu': 'اے اللہ! مجھے اس دن کے عذاب سے بچا جس دن تو اپنے بندوں کو اٹھائے گا۔ (تین بار پڑھیں)', 'ref': 'ابو داؤد: 5045'},
      {'title': 'سونے سے پہلے کی دعا', 'arabic': 'اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ', 'urdu': 'اے اللہ! میں نے اپنی جان تیرے سپرد کر دی، اپنا رخ تیری طرف کر لیا، اور اپنا معاملہ تیرے حوالے کر دیا۔', 'ref': 'صحیح بخاری: 247'},
    ]
  },
  {
    'name': 'جاگنے کی دعائیں',
    'en': 'Waking Up Duas',
    'icon': Icons.wb_twilight,
    'color': Color(0xFFD4AF37),
    'duas': [
      {'title': 'جاگنے کی دعا', 'arabic': 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ', 'urdu': 'سب تعریف اللہ کے لیے ہے جس نے ہمیں موت (نیند) کے بعد زندگی بخشی اور اسی کی طرف لوٹنا ہے۔', 'ref': 'صحیح بخاری: 6312'},
      {'title': 'نیند سے بیدار ہونے پر', 'arabic': 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ', 'urdu': 'اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کے لیے بادشاہت ہے اور اسی کے لیے تعریف ہے، اور وہ ہر چیز پر قادر ہے۔', 'ref': 'صحیح بخاری: 1154'},
    ]
  },
  {
    'name': 'سفر کی دعائیں',
    'en': 'Travel Duas',
    'icon': Icons.directions_car,
    'color': Color(0xFF2E86C1),
    'duas': [
      {'title': 'سواری پر بیٹھنے کی دعا', 'arabic': 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ', 'urdu': 'پاک ہے وہ ذات جس نے اس سواری کو ہمارے لیے مسخر کیا، حالانکہ ہم اسے قابو میں نہیں لا سکتے تھے، اور بے شک ہم اپنے رب کی طرف لوٹنے والے ہیں۔', 'ref': 'صحیح مسلم: 1342'},
      {'title': 'سفر کی دعا', 'arabic': 'اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرَّ وَالتَّقْوَى، وَمِنَ الْعَمَلِ مَا تَرْضَى', 'urdu': 'اے اللہ! ہم تجھ سے اس سفر میں نیکی اور پرہیزگاری کا، اور ایسے عمل کا سوال کرتے ہیں جس سے تو راضی ہو جائے۔', 'ref': 'صحیح مسلم: 1342'},
    ]
  },
  {
    'name': 'کھانے کی دعائیں',
    'en': 'Eating Duas',
    'icon': Icons.restaurant,
    'color': Color(0xFF2E7D32),
    'duas': [
      {'title': 'کھانے سے پہلے کی دعا', 'arabic': 'بِسْمِ اللَّهِ وَعَلَى بَرَكَةِ اللَّهِ', 'urdu': 'اللہ کے نام سے اور اللہ کی برکت پر (شروع کرتا ہوں)۔', 'ref': 'ابو داؤد: 3767'},
      {'title': 'کھانے کے بعد کی دعا', 'arabic': 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ', 'urdu': 'سب تعریف اللہ کے لیے ہے جس نے مجھے یہ کھلایا اور بغیر میری طاقت اور قوت کے مجھے یہ رزق دیا۔', 'ref': 'ترمذی: 3458'},
    ]
  },
  {
    'name': 'پریشانی کی دعائیں',
    'en': 'Distress Duas',
    'icon': Icons.healing,
    'color': Color(0xFFC0392B),
    'duas': [
      {'title': 'پریشانی کے وقت کی دعا', 'arabic': 'لَا إِلَهَ إِلَّا اللَّهُ الْعَظِيمُ الْحَلِيمُ، لَا إِلَهَ إِلَّا اللَّهُ رَبُّ الْعَرْشِ الْعَظِيمِ', 'urdu': 'اللہ کے سوا کوئی معبود نہیں جو بہت عظمت والا اور بردبار ہے۔ اللہ کے سوا کوئی معبود نہیں جو عرش عظیم کا رب ہے۔', 'ref': 'صحیح بخاری: 6345'},
      {'title': 'غم اور فکر کی دعا', 'arabic': 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ', 'urdu': 'اے اللہ! میں تیری پناہ مانگتا ہوں فکر اور غم سے، کمزوری اور سستی سے، کنجوسی اور بزدلی سے۔', 'ref': 'صحیح بخاری: 6369'},
    ]
  }
];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          title: const Text(
            'دعائیں و اذکار',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: duaCategories.length,
          itemBuilder: (context, index) {
            final cat = duaCategories[index];
            return _CategoryTile(category: cat);
          },
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final Map<String, dynamic> category;
  const _CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    final Color color = category['color'];
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DuaListPage(
              categoryName: category['name'], 
              duasList: category['duas']
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(category['icon'], color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              category['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              category['en'],
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class DuaListPage extends StatelessWidget {
  final String categoryName;
  final List<dynamic> duasList;

  const DuaListPage({super.key, required this.categoryName, required this.duasList});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          title: Text(categoryName, style: const TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: duasList.length,
          itemBuilder: (context, index) {
            final dua = duasList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.gold.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    dua['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepGreen,
                    ),
                  ),
                  const Divider(color: AppColors.gold, height: 24),
                  Text(
                    dua['arabic'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'serif',
                      height: 2.0,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
  dua['urdu'],
  textAlign: TextAlign.justify,
  style: TextStyle(
    fontSize: 14,
    color: Colors.grey[800],
    height: 1.5,
  ),
),
const SizedBox(height: 10),
Text(
  dua['ref'],
  style: const TextStyle(
    fontSize: 12,
    color: AppColors.gold,
    fontWeight: FontWeight.bold,
  ),
),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
