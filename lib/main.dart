import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class AppContact {
  static const String whatsappNumber = '+447838186629';
  static const String phoneNumber = '+447838186629';
  static const String website = 'https://www.themuslimwayoffiicial.com';
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
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

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<void> _openWhatsApp(BuildContext context) async {
    final url = 'https://wa.me/${AppContact.whatsappNumber.replaceAll('+', '')}';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openPhone(BuildContext context) async {
    final uri = Uri.parse('tel:${AppContact.phoneNumber}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openWebsite(BuildContext context) async {
    final uri = Uri.parse(AppContact.website);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openQuran(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => QuranPage()),
    );
  }
  void _openIstikhara(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => const IstikharaPage()),
  );
  }

  void _openComingSoon(BuildContext context, String title, IconData icon) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ComingSoonPage(title: title, icon: icon),
      ),
    );
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
                _buildDailyAyah(),
                const SizedBox(height: 20),
                _buildQuickAccess(context),
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
          colors: [AppColors.deepGreen, AppColors.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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

  Widget _buildDailyAyah() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.gold.withOpacity(0.4), width: 1.5),
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
              _makeCard(context, Icons.menu_book, 'قرآن پاک', AppColors.deepGreen, _openQuran),
              _makeCard(context, Icons.auto_stories, 'صحیح حدیث', AppColors.lightGreen, null),
              _makeCard(context, Icons.volunteer_activism, 'دعائیں و اذکار', AppColors.gold, null),
              _makeCard(context, Icons.access_time, 'نماز کے اوقات', AppColors.deepGreen, null),
              _makeCard(context, Icons.explore, 'قبلہ کمپاس', AppColors.lightGreen, null),
              _makeCard(context, Icons.calendar_month, 'اسلامی کیلنڈر', AppColors.gold, null),
              _makeCard(context, Icons.auto_awesome, 'استخارہ', AppColors.deepGreen, _openIstikhara),
              _makeCard(context, Icons.help_outline, 'روز مرہ مسائل', AppColors.lightGreen, null),
            ],
          ),
        ),
      ],
    );
  }

  Widget _makeCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    void Function(BuildContext)? customAction,
  ) {
    return GestureDetector(
      onTap: () {
        if (customAction != null) {
          customAction(context);
        } else {
          _openComingSoon(context, title, icon);
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
              _makeContact(context, Icons.chat, 'WhatsApp', 'واٹس ایپ پر رابطہ', const Color(0xFF25D366), () => _openWhatsApp(context)),
              const SizedBox(height: 10),
              _makeContact(context, Icons.phone, 'Call', 'فون کال کریں', AppColors.deepGreen, () => _openPhone(context)),
              const SizedBox(height: 10),
              _makeContact(context, Icons.language, 'Website', 'themuslimwayoffiicial.com', AppColors.gold, () => _openWebsite(context)),
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
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
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

// ============ Coming Soon Page ============
class ComingSoonPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const ComingSoonPage({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.gold),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.deepGreen.withOpacity(0.1),
                    border: Border.all(color: AppColors.gold, width: 2),
                  ),
                  child: Icon(icon, size: 80, color: AppColors.deepGreen),
                ),
                const SizedBox(height: 30),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(width: 60, height: 3, color: AppColors.gold),
                const SizedBox(height: 20),
                const Text(
                  'بہت جلد دستیاب ہوگا',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Coming Soon',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text(
                    'واپس جائیں',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// QURAN PAGE — مکمل 114 سورتیں
// ============================================================
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
    {'n': 40, 'name': 'غافر', 'en': 'Ghafir', 'ayat': 85, 'type': 'مکی'},
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
    {'n': 58, 'name': 'المجادلہ', 'en': 'Al-Mujadilah', 'ayat': 22, 'type': 'مدنی'},
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
    {'n': 76, 'name': 'الانسان', 'en': 'Al-Insan', 'ayat': 31, 'type': 'مدنی'},
    {'n': 77, 'name': 'المرسلات', 'en': 'Al-Mursalat', 'ayat': 50, 'type': 'مکی'},
    {'n': 78, 'name': 'النبا', 'en': 'An-Naba', 'ayat': 40, 'type': 'مکی'},
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
    {'n': 99, 'name': 'الزلزال', 'en': 'Az-Zalzalah', 'ayat': 8, 'type': 'مدنی'},
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
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        foregroundColor: AppColors.gold,
        title: const Text(
          'قرآن پاک',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.deepGreen, AppColors.lightGreen],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.gold, width: 1.5),
              ),
              child: const Column(
                children: [
                  Icon(Icons.menu_book, color: AppColors.gold, size: 32),
                  SizedBox(height: 6),
                  Text(
                    'قرآن مجید — 114 سورتیں',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'کسی بھی سورت پر ٹیپ کریں',
                    style: TextStyle(color: AppColors.cream, fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: surahs.length,
                itemBuilder: (context, index) {
                  final s = surahs[index];
                  return _SurahTile(
                    number: s['n'] as int,
                    name: s['name'] as String,
                    englishName: s['en'] as String,
                    ayat: s['ayat'] as int,
                    type: s['type'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurahTile extends StatelessWidget {
  final int number;
  final String name;
  final String englishName;
  final int ayat;
  final String type;

  const _SurahTile({
    required this.number,
    required this.name,
    required this.englishName,
    required this.ayat,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ComingSoonPage(title: 'سورۃ $name', icon: Icons.menu_book),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.gold.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.deepGreen,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.gold, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سورۃ $name',
                        style: const TextStyle(
                          color: AppColors.deepGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        englishName,
                        style: TextStyle(
                          color: AppColors.darkText.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$ayat آیات',
                      style: const TextStyle(
                        color: AppColors.darkText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: type == 'مکی'
                            ? AppColors.gold.withOpacity(0.2)
                            : AppColors.lightGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: type == 'مکی'
                              ? const Color(0xFF8B6914)
                              : AppColors.lightGreen,
                          fontSize: 10,
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

// ============================================================
// ISTIKHARA PAGE — مکمل شرعی رہنمائی
// ============================================================
class IstikharaPage extends StatelessWidget {
  const IstikharaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          foregroundColor: AppColors.gold,
          title: const Text(
            'استخارہ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.gold),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            _IstikharaHeader(),
            SizedBox(height: 16),
            _IstikharaCard(
              title: 'استخارہ کیا ہے؟',
              body:
                  'استخارہ کا مطلب ہے اللہ تعالیٰ سے کسی کام میں بھلائی طلب کرنا۔ '
                  'جب انسان کسی جائز کام کا ارادہ کرے اور اسے صحیح یا غلط ہونے میں تردد ہو، '
                  'تو دو رکعت نماز پڑھ کر دعائے استخارہ پڑھے۔ '
                  'یہ سنت سے ثابت شدہ عمل ہے اور نبی کریم ﷺ نے اس کی تعلیم دی ہے۔',
            ),
            _IstikharaCard(
              title: 'استخارہ کا شرعی طریقہ',
              body:
                  '① وضو کریں (پاک ہو کر)\n\n'
                  '② دو رکعت نفل نماز پڑھیں — پہلی رکعت میں سورۃ الفاتحہ کے بعد '
                  'سورۃ الکافرون، دوسری رکعت میں سورۃ الفاتحہ کے بعد سورۃ الاخلاص '
                  'پڑھنا افضل ہے\n\n'
                  '③ نماز سے فارغ ہو کر اللہ کی حمد و ثنا کریں اور درود شریف پڑھیں\n\n'
                  '④ دل میں اس کام کا ارادہ رکھتے ہوئے دعائے استخارہ پڑھیں\n\n'
                  '⑤ دعا کے بعد اللہ پر توکل کریں اور جو دل میں رجحان پیدا ہو '
                  'اس پر عمل کریں\n\n'
                  '⑥ اگر دل مطمئن نہ ہو تو اہل علم و مشورہ سے کام لیں',
            ),
            _IstikharaArabicCard(),
            _IstikharaCard(
              title: 'دعائے استخارہ کا ترجمہ',
              body:
                  'اے اللہ! میں تیرے علم کے ذریعے تجھ سے بھلائی طلب کرتا ہوں، '
                  'اور تیری قدرت کے ذریعے طاقت مانگتا ہوں، '
                  'اور تیرے عظیم فضل سے سوال کرتا ہوں۔ '
                  'بے شک تو قدرت رکھتا ہے اور میں نہیں رکھتا، '
                  'تو جانتا ہے اور میں نہیں جانتا، '
                  'اور تو غیبوں کا جاننے والا ہے۔\n\n'
                  'اے اللہ! اگر یہ کام میرے دین، میری دنیا، میری زندگی اور میرے '
                  'انجام کے لحاظ سے بہتر ہے تو اسے میرے لیے مقدر کر دے، '
                  'آسان کر دے اور پھر اس پر برکت دے۔\n\n'
                  'اور اگر یہ کام میرے دین، میری دنیا، میری زندگی اور میرے '
                  'انجام کے لحاظ سے برا ہے تو اسے مجھ سے پھیر دے، '
                  'اور جہاں بھلائی ہو وہاں میرا رخ کر دے، '
                  'اور پھر مجھے اس پر راضی کر دے۔',
            ),
            _IstikharaCard(
              title: 'صحیح حوالہ',
              body:
                  'حضرت جابر بن عبداللہ رضی اللہ عنہ سے روایت ہے کہ رسول اللہ ﷺ '
                  'ہمیں ہر کام میں استخارہ سکھاتے تھے، جیسے قرآن کی سورت سکھاتے تھے۔\n\n'
                  '📖 صحیح بخاری: 1166\n'
                  '📖 صحیح بخاری: 6382\n'
                  '📖 سنن ابو داؤد: 1538\n'
                  '📖 سنن ترمذی: 480\n'
                  '📖 سنن ابن ماجہ: 1383',
            ),
            _IstikharaCard(
              title: 'عام غلط فہمیاں (ضرور پڑھیں)',
              body:
                  '❌ "استخارہ کے بعد خواب آنا ضروری ہے" — یہ غلط ہے۔ '
                  'خواب آنا شرط نہیں، دل کا رجحان کافی ہے۔\n\n'
                  '❌ "استخارہ صرف شادی کے لیے ہے" — یہ غلط ہے۔ '
                  'ہر جائز اور مشکوک کام کے لیے کیا جا سکتا ہے۔\n\n'
                  '❌ "استخارہ ایک ہی بار کیا جاتا ہے" — نہیں، '
                  'ضرورت پڑنے پر کئی بار کیا جا سکتا ہے۔\n\n'
                  '❌ "استخارہ کے بعد خود فیصلہ نہیں کرنا" — نہیں، '
                  'دل کے رجحان اور عقل و مشورے کے مطابق فیصلہ کریں۔',
            ),
            _IstikharaCard(
              title: 'اہم نصیحت',
              body:
                  'اگر استخارہ کے بعد بھی تردد ہو تو اہل علم سے مشورہ کریں '
                  'اور اپنے دل کی گواہی کو اہمیت دیں۔\n\n'
                  '﴿ وَشَاوِرْهُمْ فِي الْأَمْرِ ۖ فَإِذَا عَزَمْتَ فَتَوَكَّلْ عَلَى اللَّهِ ﴾\n\n'
                  '"اور ان سے مشورہ کریں، پھر جب آپ عزم کر لیں تو اللہ پر توکل کریں۔"\n\n'
                  '📖 سورۃ آل عمران: 159',
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _IstikharaHeader extends StatelessWidget {
  const _IstikharaHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.deepGreen, AppColors.lightGreen],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold, width: 2),
      ),
      child: const Column(
        children: [
          Icon(Icons.auto_awesome, color: AppColors.gold, size: 48),
          SizedBox(height: 12),
          Text(
            'دعائے استخارہ',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'اللہ سے بھلائی طلب کرنے کی سنت',
            style: TextStyle(color: AppColors.cream, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _IstikharaCard extends StatelessWidget {
  final String title;
  final String body;
  const _IstikharaCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepGreen.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.deepGreen,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              color: AppColors.darkText,
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _IstikharaArabicCard extends StatelessWidget {
  const _IstikharaArabicCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.deepGreen,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold, width: 2),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'دعائے استخارہ (عربی)',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14),
          Text(
            'اللَّهُمَّ إِنِّي أَسْتَخِيرُكَ بِعِلْمِكَ، وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ، '
            'وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ، فَإِنَّكَ تَقْدِرُ وَلَا أَقْدِرُ، '
            'وَتَعْلَمُ وَلَا أَعْلَمُ، وَأَنْتَ عَلَّامُ الْغُيُوبِ. '
            'اللَّهُمَّ إِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الْأَمْرَ خَيْرٌ لِي فِي دِينِي '
            'وَدُنْيَايَ وَمَعَاشِي وَعَاقِبَةِ أَمْرِي، فَاقْدُرْهُ لِي وَيَسِّرْهُ لِي '
            'ثُمَّ بَارِكْ لِي فِيهِ. وَإِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الْأَمْرَ شَرٌّ لِي '
            'فِي دِينِي وَدُنْيَايَ وَمَعَاشِي وَعَاقِبَةِ أَمْرِي، فَاصْرِفْهُ عَنِّي '
            'وَاقْدُرْ لِي الْخَيْرَ حَيْثُ كَانَ، ثُمَّ أَرْضِنِي بِهِ.',
            style: TextStyle(
              color: AppColors.cream,
              fontSize: 18,
              height: 2.2,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
