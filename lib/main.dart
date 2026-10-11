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
        child: Column(
          children: const [
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
              _makeCard(context, Icons.menu_book, 'قرآن پاک', AppColors.deepGreen),
              _makeCard(context, Icons.auto_stories, 'صحیح حدیث', AppColors.lightGreen),
              _makeCard(context, Icons.volunteer_activism, 'دعائیں و اذکار', AppColors.gold),
              _makeCard(context, Icons.access_time, 'نماز کے اوقات', AppColors.deepGreen),
              _makeCard(context, Icons.explore, 'قبلہ کمپاس', AppColors.lightGreen),
              _makeCard(context, Icons.calendar_month, 'اسلامی کیلنڈر', AppColors.gold),
              _makeIstikharaCard(context),
              _makeCard(context, Icons.help_outline, 'روز مرہ مسائل', AppColors.lightGreen),
            ],
          ),
        ),
      ],
    );
  }

  Widget _makeCard(BuildContext context, IconData icon, String title, Color color) {
    return GestureDetector(
      onTap: () => _openComingSoon(context, title, icon),
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

  Widget _makeIstikharaCard(BuildContext context) {
    return GestureDetector(
      onTap: () => _openIstikhara(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.deepGreen.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.deepGreen.withOpacity(0.12),
              ),
              child: const Icon(Icons.auto_awesome, color: AppColors.deepGreen, size: 28),
            ),
            const SizedBox(height: 10),
            const Text(
              'استخارہ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
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

  Widget _makeContact(BuildContext context, IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
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


// ============ استخارہ کا مکمل صفحہ ============
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
          title: const Text(
            'استخارہ',
            style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.gold),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _sectionCard(
                title: 'استخارہ کیا ہے؟',
                icon: Icons.info_outline,
                items: const [
                  'استخارہ ایک عبادت ہے جس میں بندہ اللہ سے کسی جائز کام کے بارے میں رہنمائی مانگتا ہے۔',
                  'یہ نبی کریم ﷺ کی سنت ہے اور ہر مسلمان کو اس کی ضرورت پڑتی ہے۔',
                  'استخارہ صرف شادی کے لیے نہیں — بلکہ ہر جائز اور اہم کام کے لیے کیا جا سکتا ہے۔',
                  'مثلاً: نکاح، نوکری، کاروبار، سفر، گھر خریدنا، تعلیم کا انتخاب۔',
                ],
              ),
              _sectionCard(
                title: 'استخارہ کا مکمل طریقہ',
                icon: Icons.list_alt,
                items: const [
                  'وضو کریں اور نیت کریں کہ آپ استخارہ کر رہے ہیں۔',
                  'دو رکعت نفل نماز پڑھیں:',
                  'پہلی رکعت: سورۃ الفاتحہ + سورۃ الکافرون',
                  'دوسری رکعت: سورۃ الفاتحہ + سورۃ الاخلاص',
                  'سلام پھیرنے کے بعد دعائے استخارہ پڑھیں۔',
                  'پھر اس کام کا عزم کریں یا اللہ پر بھروسہ کریں۔',
                  'رات کو سوتے وقت بھی استخارہ کر سکتے ہیں۔',
                ],
              ),
              _arabicCard(
                title: 'دعائے استخارہ',
                arabic: 'اللَّهُمَّ إِنِّي أَسْتَخِيرُكَ بِعِلْمِكَ وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ فَإِنَّكَ تَقْدِرُ وَلَا أَقْدِرُ وَتَعْلَمُ وَلَا أَعْلَمُ وَأَنْتَ عَلَّامُ الْغُيُوبِ اللَّهُمَّ إِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الْأَمْرَ خَيْرٌ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي فَاقْدُرْهُ لِي وَيَسِّرْهُ لِي ثُمَّ بَارِكْ لِي فِيهِ وَإِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الْأَمْرَ شَرٌّ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي فَاصْرِفْهُ عَنِّي وَاقْدُرْ لِي الْخَيْرَ حَيْثُ كَانَ ثُمَّ أَرْضِنِي بِهِ',
                urdu: '"اے اللہ! میں تیرے علم کے ذریعے تجھ سے بھلائی مانگتا ہوں، اور تیری قدرت کے ذریعے تجھ سے طاقت مانگتا ہوں، اور تیرے عظیم فضل سے سوال کرتا ہوں۔ بے شک تو قدرت رکھتا ہے اور میں نہیں، تو جانتا ہے اور میں نہیں، اور تو غیبوں کا جاننے والا ہے۔ اے اللہ! اگر تو جانتا ہے کہ یہ کام میرے دین، میری زندگی، اور میرے انجام کے لیے بہتر ہے، تو اسے میرے لیے مقدر فرما، آسان فرما، اور اس میں برکت دے۔ اور اگر تو جانتا ہے کہ یہ کام میرے دین، میری زندگی، اور میرے انجام کے لیے برا ہے، تو اسے مجھ سے پھیر دے، اور جہاں بھی خیر ہو میرے لیے مقدر فرما، پھر مجھے اس پر راضی کر دے۔"',
                reference: '(صحیح بخاری: 1166)',
              ),
              _sectionCard(
                title: 'استخارہ کے بعد کیا کریں؟',
                icon: Icons.check_circle_outline,
                items: const [
                  'دل کے جھکاؤ کو دیکھیں — جس طرف دل مطمئن ہو، وہی بہتر ہے۔',
                  'خواب کا انتظار کرنا ضروری نہیں — خواب آنا شرط نہیں۔',
                  'اپنے کام کو آگے بڑھائیں — اللہ پر بھروسہ رکھیں۔',
                  'اگر الجھن ہو تو اہل علم سے مشورہ کریں۔',
                  'بار بار استخارہ کرنا جائز نہیں — ایک بار کافی ہے۔',
                ],
              ),
              _mistakesCard(),
              _noteCard(),
              _backButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gold.withOpacity(0.15),
                ),
                child: Icon(icon, color: AppColors.gold, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16, color: AppColors.gold)),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkText,
                          height: 1.7,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _arabicCard({
    required String title,
    required String arabic,
    required String urdu,
    required String reference,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gold.withOpacity(0.15),
                ),
                child: const Icon(Icons.volunteer_activism, color: AppColors.gold, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.deepGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.deepGreen.withOpacity(0.2)),
            ),
            child: Text(
              arabic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
                fontFamily: 'serif',
                height: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            urdu,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.darkText,
              fontStyle: FontStyle.italic,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              reference,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mistakesCard() {
    final mistakes = [
      ['خواب آنا ضروری ہے', 'نہیں — خواب شرط نہیں'],
      ['استخارہ صرف شادی کے لیے', 'نہیں — ہر جائز کام کے لیے'],
      ['استخارہ سے جواب خودکار ملتا ہے', 'نہیں — اللہ سے دعا ہے'],
      ['استخارہ کے بعد کچھ نہ کریں', 'نہیں — اپنے کام کو آگے بڑھائیں'],
      ['کسی ولی سے استخارہ کروانا', 'نہیں — خود کریں'],
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gold.withOpacity(0.15),
                ),
                child: const Icon(Icons.warning_amber_outlined, color: AppColors.gold, size: 22),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'استخارہ کے بارے میں غلط فہمیاں',
                  style: TextStyle(
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...mistakes.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.close, color: Colors.red, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            m[0],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check, color: Colors.green, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              m[1],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _noteCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.gold, width: 1.5),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: AppColors.gold, size: 22),
              SizedBox(width: 8),
              Text(
                'اہم نوٹ',
                style: TextStyle(
                  color: AppColors.deepGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'یہ App صرف رہنمائی کے لیے ہے — کوئی فتویٰ نہیں۔ کسی بھی شرعی مسئلے میں اپنے علاقے کے مستند مفتی یا اہل علم سے رجوع کریں۔',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkText,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        label: const Text(
          'واپس جائیں',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepGreen,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
