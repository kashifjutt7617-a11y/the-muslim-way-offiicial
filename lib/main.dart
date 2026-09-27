import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0B4F3A),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MuslimWayApp());
}

// ============ Colors ============
class AppColors {
  static const Color deepGreen = Color(0xFF0B4F3A);
  static const Color lightGreen = Color(0xFF1B6B4F);
  static const Color gold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFE8C766);
  static const Color cream = Color(0xFFFDFBF5);
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color whatsapp = Color(0xFF25D366);
}

// ============ Contact Info ============
class AppContact {
  static const String whatsappNumber = '+447838186629';
  static const String phoneNumber = '+447838186629';
  static const String website = 'https://www.themuslimwayoffiicial.com';
  static const String appName = 'The Muslim Way Offiicial';
}

// ============ Main App ============
class MuslimWayApp extends StatelessWidget {
  const MuslimWayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppContact.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.deepGreen,
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.deepGreen,
          primary: AppColors.deepGreen,
          secondary: AppColors.gold,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ============ Splash Screen ============
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
          MaterialPageRoute(builder: (_) => const HomePage()),
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
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 3),
                  color: Colors.white.withOpacity(0.08),
                ),
                child: const Icon(Icons.mosque, size: 80, color: AppColors.gold),
              ),
              const SizedBox(height: 30),
              const Text(
                'The Muslim Way',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Offiicial',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 20),
              Container(width: 60, height: 2, color: AppColors.gold),
              const SizedBox(height: 20),
              const Text(
                'بسم الله الرحمن الرحيم',
                style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'serif'),
              ),
              const SizedBox(height: 60),
              const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ Home Page ============
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeTab(),
    Center(child: Text('قرآن - Coming Soon', style: TextStyle(fontSize: 20))),
    Center(child: Text('حدیث - Coming Soon', style: TextStyle(fontSize: 20))),
    Center(child: Text('دعائیں - Coming Soon', style: TextStyle(fontSize: 20))),
    Center(child: Text('نماز - Coming Soon', style: TextStyle(fontSize: 20))),
    Center(child: Text('قبلہ - Coming Soon', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.deepGreen,
          selectedItemColor: AppColors.gold,
          unselectedItemColor: Colors.white70,
          selectedLabelStyle: const TextStyle(fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'قرآن'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'حدیث'),
            BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: 'دعائیں'),
            BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'نماز'),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'قبلہ'),
          ],
        ),
      ),
    );
  }
}

// ============ Home Tab ============
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  Future<void> _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open: $url')),
        );
      }
    }
  }

  void _openWhatsApp(BuildContext context) {
    final url = 'https://wa.me/${AppContact.whatsappNumber.replaceAll('+', '')}';
    _launchURL(context, url);
  }

  void _openPhone(BuildContext context) {
    _launchURL(context, 'tel:${AppContact.phoneNumber}');
  }

  void _openWebsite(BuildContext context) {
    _launchURL(context, AppContact.website);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
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
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'خوش آمدید! آج کا دن بابرکت ہو',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Daily Ayah
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.gold.withOpacity(0.4), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.deepGreen.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
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
            ),

            // Quick Access Title
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

            // Quick Access Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: const [
                  QuickCard(icon: Icons.menu_book, title: 'قرآن پاک', color: AppColors.deepGreen),
                  QuickCard(icon: Icons.auto_stories, title: 'صحیح حدیث', color: AppColors.lightGreen),
                  QuickCard(icon: Icons.volunteer_activism, title: 'دعائیں و اذکار', color: AppColors.gold),
                  QuickCard(icon: Icons.access_time, title: 'نماز کے اوقات', color: AppColors.deepGreen),
                  QuickCard(icon: Icons.explore, title: 'قبلہ کمپاس', color: AppColors.lightGreen),
                  QuickCard(icon: Icons.calendar_month, title: 'اسلامی کیلنڈر', color: AppColors.gold),
                ],
              ),
            ),

            // Contact Section
            const SizedBox(height: 25),
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
                  ContactButton(
                    icon: Icons.chat,
                    title: 'WhatsApp',
                    subtitle: 'واٹس ایپ پر رابطہ',
                    color: AppColors.whatsapp,
                    onTap: () => _openWhatsApp(context),
                  ),
                  const SizedBox(height: 10),
                  ContactButton(
                    icon: Icons.phone,
                    title: 'Call',
                    subtitle: 'فون کال کریں',
                    color: AppColors.deepGreen,
                    onTap: () => _openPhone(context),
                  ),
                  const SizedBox(height: 10),
                  ContactButton(
                    icon: Icons.language,
                    title: 'Website',
                    subtitle: 'themuslimwayoffiicial.com',
                    color: AppColors.gold,
                    onTap: () => _openWebsite(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Footer
            Container(
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
                  SizedBox(height: 10),
                  Text(
                    '© 2026 All rights reserved',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ Contact Button Widget ============
class ContactButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const ContactButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
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
      ),
    );
  }
}

// ============ Quick Card Widget ============
class QuickCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const QuickCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @overr
