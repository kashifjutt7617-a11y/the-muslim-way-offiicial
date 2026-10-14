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
Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
     if (mounted) {
       setState(() {});
     }
      });
  }
  
@override
void dispose() {
  _timer?.cancel();
  super.dispose();
}
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mosque, size: 80, color: AppColors.deepGreen),
                const SizedBox(height: 20),
                const Text(
                  'The Muslim Way Offiicial',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepGreen,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.deepGreen,
borderRadius: BorderRadius.circular(12),
                    ),
  child: Column(
  children: [
    Text(
      _formatDate(now),
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(height: 6),
    Text(
      _formatTime(now),
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
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
