import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:intl/intl.dart';

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
                const SizedBox(height: 16),
                _buildDailyHadith(),
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
    final DateFormat dateFormat = DateFormat('EEEE, d MMMM yyyy');
    final DateFormat timeFormat = DateFormat('hh:mm:ss a');

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
                child: const Icon(Icons.mosque,
                    color: AppColors.gold, size: 28),
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
                    const Icon(Icons.calendar_today,
                        color: AppColors.gold, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      dateFormat.format(_now),
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
                    const Icon(Icons.access_time,
                        color: AppColors.gold, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      timeFormat.format(_now),
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

  Widget _buildDailyAyah() {
    final List<Map<String, String>> ayahs = [
      {'ar': 'إِنَّ مَعَ الْعُسْرِ يُسْرًا', 'ur': 'بے شک مشکل کے ساتھ آسانی ہے۔', 'ref': 'سورۃ الشرح: 6'},
      {'ar': 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ', 'ur': 'اور جو اللہ پر بھروسہ کرے تو وہ اُس کے لیے کافی ہے۔', 'ref': 'سورۃ الطلاق: 3'},
      {'ar': 'فَاذْكُرُونِي أَذْكُرْكُمْ', 'ur': 'پس تم میرا ذکر کرو، میں تمہارا ذکر کروں گا۔', 'ref': 'سورۃ البقرہ: 152'},
      {'ar': 'وَاصْبِرْ إِنَّ اللَّهَ مَعَ الصَّابِرِينَ', 'ur': 'اور صبر کرو، بے شک اللہ صبر کرنے والوں کے ساتھ ہے۔', 'ref': 'سورۃ الانفال: 46'},
      {'ar': 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 'ur': 'خبردار! اللہ کے ذکر سے ہی دلوں کو سکون ملتا ہے۔', 'ref': 'سورۃ الرعد: 28'},
      {'ar': 'وَاللَّهُ خَيْرُ الرَّازِقِينَ', 'ur': 'اور اللہ بہترین رزق دینے والا ہے۔', 'ref': 'سورۃ الجمعہ: 11'},
      {'ar': 'وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ', 'ur': 'اور وہ تمہارے ساتھ ہے جہاں بھی تم ہو۔', 'ref': 'سورۃ الحدید: 4'},
      {'ar': 'إِنَّ اللَّهَ غَفُورٌ رَّحِيمٌ', 'ur': 'بے شک اللہ بخشنے والا، رحم کرنے والا ہے۔', 'ref': 'سورۃ البقرہ: 173'},
      {'ar': 'وَعَسَىٰ أَن تَكْرَهُوا شَيْئًا وَهُوَ خَيْرٌ لَّكُمْ', 'ur': 'اور ممکن ہے تم کسی چیز کو ناپسند کرو اور وہ تمہارے لیے بہتر ہو۔', 'ref': 'سورۃ البقرہ: 216'},
      {'ar': 'إِنَّ اللَّهَ يُحِبُّ الْمُتَوَكِّلِينَ', 'ur': 'بے شک اللہ توکل کرنے والوں سے محبت کرتا ہے۔', 'ref': 'سورۃ آل عمران: 159'},
      {'ar': 'وَأَن لَّيْسَ لِلْإِنسَانِ إِلَّا مَا سَعَىٰ', 'ur': 'اور انسان کے لیے وہی ہے جس کی وہ کوشش کرے۔', 'ref': 'سورۃ النجم: 39'},
      {'ar': 'إِنَّ اللَّهَ يَأْمُرُ بِالْعَدْلِ وَالْإِحْسَانِ', 'ur': 'بے شک اللہ انصاف اور نیکی کا حکم دیتا ہے۔', 'ref': 'سورۃ النحل: 90'},
      {'ar': 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا', 'ur': 'پس بے شک مشکل کے ساتھ آسانی ہے۔', 'ref': 'سورۃ الشرح: 5'},
      {'ar': 'وَاللَّهُ يَعْلَمُ وَأَنتُمْ لَا تَعْلَمُونَ', 'ur': 'اور اللہ جانتا ہے اور تم نہیں جانتے۔', 'ref': 'سورۃ البقرہ: 216'},
      {'ar': 'وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ', 'ur': 'اور میری توفیق صرف اللہ کی طرف سے ہے۔', 'ref': 'سورۃ ہود: 88'},
      {'ar': 'إِنَّ اللَّهَ وَاسِعٌ عَلِيمٌ', 'ur': 'بے شک اللہ کشادگی والا، جاننے والا ہے۔', 'ref': 'سورۃ البقرہ: 115'},
      {'ar': 'وَتَوَكَّلْ عَلَى اللَّهِ وَكَفَىٰ بِاللَّهِ وَكِيلًا', 'ur': 'اور اللہ پر بھروسہ کریں، اور اللہ کافی ہے کارساز۔', 'ref': 'سورۃ النساء: 81'},
      {'ar': 'إِنَّ اللَّهَ لَا يُحِبُّ الْمُسْرِفِينَ', 'ur': 'بے شک اللہ حد سے بڑھنے والوں کو پسند نہیں کرتا۔', 'ref': 'سورۃ الاعراف: 31'},
      {'ar': 'وَاللَّهُ مَعَ الصَّابِرِينَ', 'ur': 'اور اللہ صبر کرنے والوں کے ساتھ ہے۔', 'ref': 'سورۃ البقرہ: 249'},
      {'ar': 'إِنَّ فِي ذَٰلِكَ لَآيَاتٍ لِّقَوْمٍ يَتَفَكَّرُونَ', 'ur': 'بے شک اِس میں غور کرنے والوں کے لیے نشانیاں ہیں۔', 'ref': 'سورۃ الرعد: 3'},
      {'ar': 'وَاتَّقُوا اللَّهَ وَاعْلَمُوا أَنَّ اللَّهَ مَعَ الْمُتَّقِينَ', 'ur': 'اور اللہ سے ڈرو، اور جان لو کہ اللہ پرہیزگاروں کے ساتھ ہے۔', 'ref': 'سورۃ البقرہ: 194'},
      {'ar': 'وَهُوَ الْغَفُورُ الْوَدُودُ', 'ur': 'اور وہ بخشنے والا، محبت کرنے والا ہے۔', 'ref': 'سورۃ البروج: 14'},
      {'ar': 'إِنَّ اللَّهَ يُحِبُّ الصَّابِرِينَ', 'ur': 'بے شک اللہ صبر کرنے والوں سے محبت کرتا ہے۔', 'ref': 'سورۃ آل عمران: 146'},
      {'ar': 'وَاذْكُر رَّبَّكَ إِذَا نَسِيتَ', 'ur': 'اور اپنے رب کا ذکر کرو جب بھول جاؤ۔', 'ref': 'سورۃ الکہف: 24'},
      {'ar': 'رَبِّ زِدْنِي عِلْمًا', 'ur': 'اے میرے رب! میرے علم میں اضافہ فرما۔', 'ref': 'سورۃ طہ: 114'},
      {'ar': 'وَاللَّهُ عَلِيمٌ حَكِيمٌ', 'ur': 'اور اللہ جاننے والا، حکمت والا ہے۔', 'ref': 'سورۃ النساء: 26'},
      {'ar': 'إِنَّ اللَّهَ مَعَ الَّذِينَ اتَّقَوا وَّالَّذِينَ هُم مُّحْسِنُونَ', 'ur': 'بے شک اللہ پرہیزگاروں اور نیکوکاروں کے ساتھ ہے۔', 'ref': 'سورۃ النحل: 128'},
      {'ar': 'وَبَشِّرِ الصَّابِرِينَ', 'ur': 'اور صبر کرنے والوں کو خوشخبری دے دیں۔', 'ref': 'سورۃ البقرہ: 155'},
      {'ar': 'إِنَّ اللَّهَ لَا يُضِيعُ أَجْرَ الْمُحْسِنِينَ', 'ur': 'بے شک اللہ نیکوکاروں کا اجر ضائع نہیں کرتا۔', 'ref': 'سورۃ التوبہ: 120'},
      {'ar': 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً', 'ur': 'اے ہمارے رب! ہمیں دنیا میں بھی بھلائی دے اور آخرت میں بھی بھلائی دے۔', 'ref': 'سورۃ البقرہ: 201'},
    ];

    final int dayOfYear = int.parse(DateFormat('D').format(_now));
    final Map<String, String> todayAyah = ayahs[dayOfYear % ayahs.length];

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
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.brightness_5,
                    color: AppColors.gold, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'آج کی آیت',
                  style: TextStyle(
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  '${dayOfYear % ayahs.length + 1}/${ayahs.length}',
                  style: TextStyle(
                    color: AppColors.darkText.withOpacity(0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              todayAyah['ar'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
                fontFamily: 'serif',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '"${todayAyah['ur']}"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.darkText,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '(${todayAyah['ref']})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDailyHadith() {
    final List<Map<String, String>> hadiths = [
      {'ar': 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى', 'ur': 'اعمال کا دارومدار نیتوں پر ہے۔', 'ref': 'صحیح بخاری: 1'},
      {'ar': 'الدِّينُ النَّصِيحَةُ', 'ur': 'دین خیر خواہی کا نام ہے۔', 'ref': 'صحیح مسلم: 55'},
      {'ar': 'مَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ', 'ur': 'جو اللہ اور آخرت پر ایمان رکھتا ہے وہ اچھی بات کہے یا خاموش رہے۔', 'ref': 'صحیح بخاری: 6018'},
      {'ar': 'لاَ يُؤْمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لأَخِيهِ مَا يُحِبُّ لِنَفْسِهِ', 'ur': 'تم میں سے کوئی اُس وقت تک مومن نہیں ہو سکتا جب تک وہ اپنے بھائی کے لیے وہی نہ چاہے جو اپنے لیے چاہتا ہے۔', 'ref': 'صحیح بخاری: 13'},
      {'ar': 'اتَّقِ اللَّهَ حَيْثُمَا كُنْتَ', 'ur': 'جہاں بھی ہو اللہ سے ڈرو۔', 'ref': 'سنن ترمذی: 1987'},
      {'ar': 'الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ', 'ur': 'مسلمان وہ ہے جس کی زبان اور ہاتھ سے دوسرے مسلمان محفوظ رہیں۔', 'ref': 'صحیح بخاری: 10'},
      {'ar': 'خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ', 'ur': 'تم میں سب سے بہتر وہ ہے جو قرآن سیکھے اور سکھائے۔', 'ref': 'صحیح بخاری: 5027'},
      {'ar': 'الطُّهُورُ شَطْرُ الإِيمَانِ', 'ur': 'پاکیزگی ایمان کا حصہ ہے۔', 'ref': 'صحیح مسلم: 223'},
      {'ar': 'مَنْ حُسْنِ إِسْلاَمِ الْمَرْءِ تَرْكُهُ مَا لاَ يَعْنِيهِ', 'ur': 'آدمی کے اسلام کی خوبی یہ ہے کہ وہ بے کار چیزوں کو چھوڑ دے۔', 'ref': 'سنن ترمذی: 2317'},
      {'ar': 'لاَ تَغْضَبْ', 'ur': 'غصہ نہ کرو۔', 'ref': 'صحیح بخاری: 6116'},
      {'ar': 'الْجَنَّةُ تَحْتَ أَقْدَامِ الأُمَّهَاتِ', 'ur': 'جنت ماؤں کے قدموں کے نیچے ہے۔', 'ref': 'سنن نسائی (صحیح)'},
      {'ar': 'مَنْ صَلَّى عَلَىَّ صَلاَةً صَلَّى اللَّهُ عَلَيْهِ بِهَا عَشْرًا', 'ur': 'جو مجھ پر ایک بار درود بھیجے، اللہ اُس پر دس رحمتیں بھیجتا ہے۔', 'ref': 'صحیح مسلم: 408'},
      {'ar': 'الصَّلاَةُ نُورٌ', 'ur': 'نماز نور ہے۔', 'ref': 'صحیح مسلم: 223'},
      {'ar': 'الدُّعَاءُ مُخُّ الْعِبَادَةِ', 'ur': 'دعا عبادت کا مغز ہے۔', 'ref': 'سنن ترمذی: 3371'},
      {'ar': 'مَنْ لاَ يَرْحَمُ لاَ يُرْحَمُ', 'ur': 'جو رحم نہیں کرتا اُس پر رحم نہیں کیا جائے گا۔', 'ref': 'صحیح بخاری: 5997'},
      {'ar': 'الْكَلِمَةُ الطَّيِّبَةُ صَدَقَةٌ', 'ur': 'اچھی بات کہنا بھی صدقہ ہے۔', 'ref': 'صحیح بخاری: 2989'},
      {'ar': 'إِنَّ اللَّهَ جَمِيلٌ يُحِبُّ الْجَمَالَ', 'ur': 'بے شک اللہ خوبصورت ہے اور خوبصورتی کو پسند کرتا ہے۔', 'ref': 'صحیح مسلم: 91'},
      {'ar': 'الْيَدُ الْعُلْيَا خَيْرٌ مِنَ الْيَدِ السُّفْلَى', 'ur': 'دینے والا ہاتھ لینے والے ہاتھ سے بہتر ہے۔', 'ref': 'صحیح بخاری: 1429'},
      {'ar': 'مَنْ سَلَكَ طَرِيقًا يَطْلُبُ فِيهِ عِلْمًا سَلَكَ اللَّهُ بِهِ طَرِيقًا إِلَى الْجَنَّةِ', 'ur': 'جو علم کی تلاش میں راستہ چلے، اللہ اُس کے لیے جنت کا راستہ آسان کر دیتا ہے۔', 'ref': 'صحیح مسلم: 2699'},
      {'ar': 'إِنَّ اللَّهَ رَفِيقٌ يُحِبُّ الرِّفْقَ', 'ur': 'بے شک اللہ نرمی کرنے والا ہے اور نرمی کو پسند کرتا ہے۔', 'ref': 'صحیح مسلم: 2593'},
      {'ar': 'لاَ تَحْقِرَنَّ مِنَ الْمَعْرُوفِ شَيْئًا', 'ur': 'نیکی کی کسی چیز کو حقیر نہ سمجھو۔', 'ref': 'صحیح مسلم: 2620'},
      {'ar': 'الْحَيَاءُ شُعْبَةٌ مِنَ الإِيمَانِ', 'ur': 'حیا ایمان کی شاخ ہے۔', 'ref': 'صحیح بخاری: 9'},
      {'ar': 'أَفْضَلُ الذِّكْرِ لاَ إِلَهَ إِلاَّ اللَّهُ', 'ur': 'سب سے افضل ذکر «لا الہ الا اللہ» ہے۔', 'ref': 'سنن ترمذی: 3383'},
      {'ar': 'الصَّدَقَةُ تُطْفِئُ الْخَطِيئَةَ كَمَا يُطْفِئُ الْمَاءُ النَّارَ', 'ur': 'صدقہ گناہ کو ایسے بجھا دیتا ہے جیسے پانی آگ کو بجھاتا ہے۔', 'ref': 'سنن ترمذی: 614'},
      {'ar': 'أَحَبُّ الأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ', 'ur': 'اللہ کے نزدیک سب سے پسندیدہ عمل وہ ہے جو ہمیشہ کیا جائے۔', 'ref': 'صحیح مسلم: 783'},
      {'ar': 'مَنْ صَمَتَ نَجَا', 'ur': 'جو خاموش رہا وہ نجات پا گیا۔', 'ref': 'سنن ترمذی: 2501'},
      {'ar': 'الْمُؤْمِنُ لِلْمُؤْمِنِ كَالْبُنْيَانِ يَشُدُّ بَعْضُهُ بَعْضًا', 'ur': 'مومن دوسرے مومن کے لیے عمارت کی طرح ہے۔', 'ref': 'صحیح بخاری: 481'},
      {'ar': 'إِنَّ الرِّفْقَ لاَ يَكُونُ فِي شَىْءٍ إِلاَّ زَانَهُ', 'ur': 'نرمی جس چیز میں بھی ہو اُسے خوبصورت بنا دیتی ہے۔', 'ref': 'صحیح مسلم: 2594'},
      {'ar': 'مَنْ كَذَبَ عَلَىَّ مُتَعَمِّدًا فَلْيَتَبَوَّأْ مَقْعَدَهُ مِنَ النَّارِ', 'ur': 'جو جان بوجھ کر مجھ پر جھوٹ باندھے وہ جہنم میں اپنا ٹھکانہ بنا لے۔', 'ref': 'صحیح بخاری: 110'},
      {'ar': 'بُعِثْتُ لأُتَمِّمَ مَكَارِمَ الأَخْلاَقِ', 'ur': 'مجھے اچھے اخلاق کی تکمیل کے لیے بھیجا گیا ہے۔', 'ref': 'مسند احمد: 8952'},
    ];

    final int dayOfYear = int.parse(DateFormat('D').format(_now));
    final Map<String, String> todayHadith =
        hadiths[(dayOfYear + 3) % hadiths.length];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
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
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.menu_book,
                    color: AppColors.gold, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'آج کی حدیث',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(dayOfYear + 3) % hadiths.length + 1}/${hadiths.length}',
                  style: const TextStyle(
                    color: AppColors.cream,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              todayHadith['ar'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
                fontFamily: 'serif',
                height: 1.8,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '"${todayHadith['ur']}"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.cream,
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '📚 ${todayHadith['ref']}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.lightGold,
                fontWeight: FontWeight.bold,
              ),
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
              _makeContact(context, Icons.chat, 'WhatsApp', 'واٹس ایپ پر رابطہ',
                  const Color(0xFF25D366), () => _openWhatsApp(context)),
              const SizedBox(height: 10),
              _makeContact(context, Icons.phone, 'Call', 'فون کال کریں',
                  AppColors.deepGreen, () => _openPhone(context)),
              const SizedBox(height: 10),
              _makeContact(context, Icons.language, 'Website',
                  'themuslimwayoffiicial.com', AppColors.gold,
                  () => _openWebsite(context)),
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
            'version 1.0.0+4',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
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
            if (SurahDetailPage.shortSurahs.containsKey(number)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SurahDetailPage(surahNumber: number),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ComingSoonPage(
                      title: 'سورۃ $name', icon: Icons.menu_book),
                ),
              );
            }
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
