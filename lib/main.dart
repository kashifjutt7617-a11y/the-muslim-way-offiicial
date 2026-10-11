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

// ============ Dashboard ============
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
      MaterialPageRoute(builder: (_) => const QuranPage()),
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

// ============ قرآن پاک کا صفحہ ============
class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  static const List<Map<String, dynamic>> surahs = [
    {'num': 1, 'name': 'الفاتحہ', 'meaning': 'کھولنے والی', 'ayahs': 7, 'makki': true},
    {'num': 2, 'name': 'البقرہ', 'meaning': 'گائے', 'ayahs': 286, 'makki': false},
    {'num': 3, 'name': 'آل عمران', 'meaning': 'عمران کا خاندان', 'ayahs': 200, 'makki': false},
    {'num': 4, 'name': 'النساء', 'meaning': 'عورتیں', 'ayahs': 176, 'makki': false},
    {'num': 5, 'name': 'المائدہ', 'meaning': 'دسترخوان', 'ayahs': 120, 'makki': false},
    {'num': 6, 'name': 'الانعام', 'meaning': 'مویشی', 'ayahs': 165, 'makki': true},
    {'num': 7, 'name': 'الاعراف', 'meaning': 'بلندیاں', 'ayahs': 206, 'makki': true},
    {'num': 8, 'name': 'الانفال', 'meaning': 'مالِ غنیمت', 'ayahs': 75, 'makki': false},
    {'num': 9, 'name': 'التوبہ', 'meaning': 'توبہ', 'ayahs': 129, 'makki': false},
    {'num': 10, 'name': 'یونس', 'meaning': 'یونس علیہ السلام', 'ayahs': 109, 'makki': true},
    {'num': 11, 'name': 'ہود', 'meaning': 'ہود علیہ السلام', 'ayahs': 123, 'makki': true},
    {'num': 12, 'name': 'یوسف', 'meaning': 'یوسف علیہ السلام', 'ayahs': 111, 'makki': true},
    {'num': 13, 'name': 'الرعد', 'meaning': 'گرج', 'ayahs': 43, 'makki': false},
    {'num': 14, 'name': 'ابراہیم', 'meaning': 'ابراہیم علیہ السلام', 'ayahs': 52, 'makki': true},
    {'num': 15, 'name': 'الحجر', 'meaning': 'پتھریلی زمین', 'ayahs': 99, 'makki': true},
    {'num': 16, 'name': 'النحل', 'meaning': 'شہد کی مکھی', 'ayahs': 128, 'makki': true},
    {'num': 17, 'name': 'بنی اسرائیل', 'meaning': 'اسرائیل کی اولاد', 'ayahs': 111, 'makki': true},
    {'num': 18, 'name': 'الکہف', 'meaning': 'غار', 'ayahs': 110, 'makki': true},
    {'num': 19, 'name': 'مریم', 'meaning': 'مریم علیہا السلام', 'ayahs': 98, 'makki': true},
    {'num': 20, 'name': 'طہ', 'meaning': 'طہ', 'ayahs': 135, 'makki': true},
    {'num': 21, 'name': 'الانبیاء', 'meaning': 'انبیاء', 'ayahs': 112, 'makki': true},
    {'num': 22, 'name': 'الحج', 'meaning': 'حج', 'ayahs': 78, 'makki': false},
    {'num': 23, 'name': 'المؤمنون', 'meaning': 'ایمان والے', 'ayahs': 118, 'makki': true},
    {'num': 24, 'name': 'النور', 'meaning': 'نور', 'ayahs': 64, 'makki': false},
    {'num': 25, 'name': 'الفرقان', 'meaning': 'حق و باطل میں فرق', 'ayahs': 77, 'makki': true},
    {'num': 26, 'name': 'الشعراء', 'meaning': 'شاعر', 'ayahs': 227, 'makki': true},
    {'num': 27, 'name': 'النمل', 'meaning': 'چیونٹی', 'ayahs': 93, 'makki': true},
    {'num': 28, 'name': 'القصص', 'meaning': 'قصے', 'ayahs': 88, 'makki': true},
    {'num': 29, 'name': 'العنکبوت', 'meaning': 'مکڑی', 'ayahs': 69, 'makki': true},
    {'num': 30, 'name': 'الروم', 'meaning': 'روم', 'ayahs': 60, 'makki': true},
    {'num': 31, 'name': 'لقمان', 'meaning': 'لقمان', 'ayahs': 34, 'makki': true},
    {'num': 32, 'name': 'السجدہ', 'meaning': 'سجدہ', 'ayahs': 30, 'makki': true},
    {'num': 33, 'name': 'الاحزاب', 'meaning': 'لشکر', 'ayahs': 73, 'makki': false},
    {'num': 34, 'name': 'سبأ', 'meaning': 'سبا', 'ayahs': 54, 'makki': true},
    {'num': 35, 'name': 'فاطر', 'meaning': 'پیدا کرنے والا', 'ayahs': 45, 'makki': true},
    {'num': 36, 'name': 'یس', 'meaning': 'یس', 'ayahs': 83, 'makki': true},
    {'num': 37, 'name': 'الصافات', 'meaning': 'صف باندھنے والے', 'ayahs': 182, 'makki': true},
    {'num': 38, 'name': 'ص', 'meaning': 'ص', 'ayahs': 88, 'makki': true},
    {'num': 39, 'name': 'الزمر', 'meaning': 'گروہ', 'ayahs': 75, 'makki': true},
    {'num': 40, 'name': 'غافر', 'meaning': 'بخشش والا', 'ayahs': 85, 'makki': true},
    {'num': 41, 'name': 'فصلت', 'meaning': 'واضح', 'ayahs': 54, 'makki': true},
    {'num': 42, 'name': 'الشوریٰ', 'meaning': 'مشورہ', 'ayahs': 53, 'makki': true},
    {'num': 43, 'name': 'الزخرف', 'meaning': 'زینت', 'ayahs': 89, 'makki': true},
    {'num': 44, 'name': 'الدخان', 'meaning': 'دھواں', 'ayahs': 59, 'makki': true},
    {'num': 45, 'name': 'الجاثیہ', 'meaning': 'گھٹنوں کے بل', 'ayahs': 37, 'makki': true},
    {'num': 46, 'name': 'الاحقاف', 'meaning': 'ریت کے ٹیلے', 'ayahs': 35, 'makki': true},
    {'num': 47, 'name': 'محمد', 'meaning': 'محمد ﷺ', 'ayahs': 38, 'makki': false},
    {'num': 48, 'name': 'الفتح'
