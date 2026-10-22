import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
  // واٹس ایپ کھولنے کا فنکشن
void _launchWhatsApp() async {
final Uri url = Uri.parse('https://wa.link/b0a0ve');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch WhatsApp');
  }
}
// نمازوں کے اوقات (فی الحال سیمپل، بعد میں GPS سے لنک کریں گے)
final Map<String, String> _prayerTimes = {
  'فجر': '05:00',
  'ظہر': '12:30',
  'عصر': '15:45',
  'مغرب': '18:15',
  'عشاء': '19:45',
};

Map<String, String> get _nextPrayerInfo {
  final now = DateTime.now();
  final currentTime = now.hour * 60 + now.minute;

  final timesInMinutes = {
    'فجر': 5 * 60,
    'ظہر': 12 * 60 + 30,
    'عصر': 15 * 60 + 45,
    'مغرب': 18 * 60 + 15,
    'عشاء': 19 * 60 + 45,
  };

  String nextName = 'فجر';
  String nextTimeStr = '05:00';
  int nextTimeInMinutes = timesInMinutes['فجر']!;

  for (var entry in timesInMinutes.entries) {
    if (entry.value > currentTime) {
      nextName = entry.key;
      nextTimeInMinutes = entry.value;
      break;
    }
  }

  if (currentTime >= timesInMinutes['عشاء']!) {
    nextName = 'فجر';
    nextTimeInMinutes = timesInMinutes['فجر']! + (24 * 60);
  }

  final h = (nextTimeInMinutes ~/ 60) % 24;
  final m = nextTimeInMinutes % 60;
  nextTimeStr = '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

  int diff = nextTimeInMinutes - currentTime;
  if (diff < 0) diff += 24 * 60;

  final hoursLeft = diff ~/ 60;
  final minutesLeft = diff % 60;
  final secondsLeft = 59 - now.second;

  return {
    'name': nextName,
    'time': nextTimeStr,
    'countdown': '${hoursLeft.toString().padLeft(2, '0')}:${minutesLeft.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}',
  };
}

// 30 آیات کا مکمل ڈیٹا
final List<Map<String, String>> _dailyAyats = [
  {'arabic': 'إِنَّ مَعَ الْعُسْرِ يُسْرًا', 'urdu': '"بے شک مشکل کے ساتھ آسانی ہے"', 'ref': '(سورۃ الشرح: 6)'},
  {'arabic': 'فَاذْكُرُونِي أَذْكُرْكُمْ', 'urdu': '"پس تم مجھے یاد کرو، میں تمہیں یاد رکھوں گا"', 'ref': '(سورۃ البقرہ: 152)'},
  {'arabic': 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ', 'urdu': '"اور جو اللہ پر بھروسہ کرے، تو وہ اس کے لیے کافی ہے"', 'ref': '(سورۃ الطلاق: 3)'},
  {'arabic': 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ', 'urdu': '"بے شک اللہ صبر کرنے والوں کے ساتھ ہے"', 'ref': '(سورۃ البقرہ: 153)'},
  {'arabic': 'رَبِّ زِدْنِي عِلْمًا', 'urdu': '"اے میرے رب! میرے علم میں اضافہ فرما"', 'ref': '(سورۃ طہ: 114)'},
  {'arabic': 'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰ', 'urdu': '"اور عنقریب تیرا رب تجھے اتنا دے گا کہ تو خوش ہو جائے گا"', 'ref': '(سورۃ الضحیٰ: 5)'},
  {'arabic': 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا', 'urdu': '"پس بے شک مشکل کے ساتھ آسانی ہے"', 'ref': '(سورۃ الشرح: 5)'},
  {'arabic': 'وَاصْبِرْ فَإِنَّ اللَّهَ لَا يُضِيعُ أَجْرَ الْمُحْسِنِينَ', 'urdu': '"اور صبر کرو، بے شک اللہ نیکوکاروں کا اجر ضائع نہیں کرتا"', 'ref': '(سورۃ ہود: 115)'},
  {'arabic': 'وَعَسَىٰ أَن تَكْرَهُوا شَيْئًا وَهُوَ خَيْرٌ لَّكُمْ', 'urdu': '"اور ممکن ہے تم کسی چیز کو ناپسند کرو اور وہ تمہارے لیے بہتر ہو"', 'ref': '(سورۃ البقرہ: 216)'},
  {'arabic': 'لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا', 'urdu': '"اللہ کسی جان کو اس کی طاقت سے زیادہ تکلیف نہیں دیتا"', 'ref': '(سورۃ البقرہ: 286)'},
  {'arabic': 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 'urdu': '"سن لو! اللہ کے ذکر سے ہی دلوں کو سکون ملتا ہے"', 'ref': '(سورۃ الرعد: 28)'},
  {'arabic': 'وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ', 'urdu': '"اور میری توفیق صرف اللہ کی طرف سے ہے"', 'ref': '(سورۃ ہود: 88)'},
  {'arabic': 'ادْعُونِي أَسْتَجِبْ لَكُمْ', 'urdu': '"تم مجھے پکارو، میں تمہاری دعا قبول کروں گا"', 'ref': '(سورۃ غافر: 60)'},
  {'arabic': 'وَقُل رَّبِّ ارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيرًا', 'urdu': '"اور کہہ، اے میرے رب! ان (والدین) پر رحم فرما جیسے انہوں نے بچپن میں مجھے پالا"', 'ref': '(سورۃ الاسراء: 24)'},
  {'arabic': 'فَاتَّقُوا اللَّهَ مَا اسْتَطَعْتُمْ', 'urdu': '"پس جتنا ممکن ہو اللہ سے ڈرو"', 'ref': '(سورۃ التغابن: 16)'},
  {'arabic': 'وَلَا تَيْأَسُوا مِن رَّوْحِ اللَّهِ', 'urdu': '"اور اللہ کی رحمت سے مایوس نہ ہو"', 'ref': '(سورۃ یوسف: 87)'},
  {'arabic': 'إِنَّ الصَّلَاةَ تَنْهَىٰ عَنِ الْفَحْشَاءِ وَالْمُنكَرِ', 'urdu': '"بے شک نماز بے حیائی اور برے کاموں سے روکتی ہے"', 'ref': '(سورۃ العنکبوت: 45)'},
  {'arabic': 'وَلَا تَقْرَبُوا الزِّنَىٰ إِنَّهُ كَانَ فَاحِشَةً وَسَاءَ سَبِيلًا', 'urdu': '"اور زنا کے قریب نہ جاؤ، بے شک وہ بے حیائی ہے اور بہت برا راستہ ہے"', 'ref': '(سورۃ الاسراء: 32)'},
  {'arabic': 'وَلَا تَقْتُلُوا النَّفْسَ الَّتِي حَرَّمَ اللَّهُ إِلَّا بِالْحَقِّ', 'urdu': '"اور جس جان کو اللہ نے حرام کیا ہے اسے قتل نہ کرو مگر حق کے ساتھ"', 'ref': '(سورۃ الانعام: 151)'},
  {'arabic': 'وَبِالْوَالِدَيْنِ إِحْسَانًا', 'urdu': '"اور والدین کے ساتھ احسان کرو"', 'ref': '(سورۃ الاسراء: 23)'},
  {'arabic': 'وَأَقِيمُوا الصَّلَاةَ وَآتُوا الزَّكَاةَ', 'urdu': '"اور نماز قائم کرو اور زکوٰۃ ادا کرو"', 'ref': '(سورۃ البقرہ: 43)'},
  {'arabic': 'وَأَوْفُوا بِالْعَهْدِ إِنَّ الْعَهْدَ كَانَ مَسْئُولًا', 'urdu': '"اور عہد پورا کرو، بے شک عہد کے بارے میں پوچھا جائے گا"', 'ref': '(سورۃ الاسراء: 34)'},
  {'arabic': 'وَأْمُرْ بِالْمَعْرُوفِ وَانْهَ عَنِ الْمُنكَرِ', 'urdu': '"اور نیکی کا حکم دو اور برائی سے روکو"', 'ref': '(سورۃ لقمان: 17)'},
  {'arabic': 'وَلَا تَمْشِ فِي الْأَرْضِ مَرَحًا', 'urdu': '"اور زمین پر اکڑ کر مت چلو"', 'ref': '(سورۃ لقمان: 18)'},
  {'arabic': 'وَاصْبِرْ عَلَىٰ مَا أَصَابَكَ', 'urdu': '"اور جو مصیبت تم پر آئے اس پر صبر کرو"', 'ref': '(سورۃ لقمان: 17)'},
  {'arabic': 'إِنَّ اللَّهَ يُحِبُّ الْمُتَوَكِّلِينَ', 'urdu': '"بے شک اللہ بھروسہ کرنے والوں کو پسند کرتا ہے"', 'ref': '(سورۃ آل عمران: 159)'},
  {'arabic': 'وَاللَّهُ خَيْرُ الرَّازِقِينَ', 'urdu': '"اور اللہ سب سے بہتر رزق دینے والا ہے"', 'ref': '(سورۃ الجمعة: 11)'},
  {'arabic': 'وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ', 'urdu': '"اور وہ تمہارے ساتھ ہے جہاں بھی تم ہو"', 'ref': '(سورۃ الحدید: 4)'},
  {'arabic': 'إِنَّ اللَّهَ لَا يُحِبُّ الظَّالِمِينَ', 'urdu': '"بے شک اللہ ظالموں کو پسند نہیں کرتا"', 'ref': '(سورۃ آل عمران: 140)'},
  {'arabic': 'وَمَنْ أَحْسَنُ قَوْلًا مِّمَّن دَعَا إِلَى اللَّهِ وَعَمِلَ صَالِحًا', 'urdu': '"اور اس سے بہتر کس کی بات ہو سکتی ہے جو اللہ کی طرف بلائے اور نیک عمل کرے"', 'ref': '(سورۃ فصلت: 33)'},
];
  // 30 صحیح احادیث کا مکمل ڈیٹا
final List<Map<String, String>> _dailyHadiths = [
  {'arabic': 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ', 'urdu': '"اعمال کا دارومدار نیتوں پر ہے"', 'ref': '(صحیح بخاری: 1)'},
  {'arabic': 'الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ', 'urdu': '"سچا مسلمان وہ ہے جس کی زبان اور ہاتھ سے دوسرے مسلمان محفوظ رہیں"', 'ref': '(صحیح بخاری: 10)'},
  {'arabic': 'مَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ', 'urdu': '"جو اللہ اور آخرت کے دن پر ایمان رکھتا ہے، وہ اچھی بات کہے یا خاموش رہے"', 'ref': '(صحیح بخاری: 6018)'},
  {'arabic': 'لَا يُؤْمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لِأَخِيهِ مَا يُحِبُّ لِنَفْسِهِ', 'urdu': '"تم میں سے کوئی اس وقت تک مومن نہیں ہو سکتا جب تک اپنے بھائی کے لیے وہی نہ چاہے جو اپنے لیے چاہتا ہے"', 'ref': '(صحیح بخاری: 13)'},
  {'arabic': 'خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ', 'urdu': '"تم میں سب سے بہتر وہ ہے جو قرآن سیکھے اور دوسروں کو سکھائے"', 'ref': '(صحیح بخاری: 5027)'},
  {'arabic': 'الدِّينُ النَّصِيحَةُ', 'urdu': '"دین خیر خواہی کا نام ہے"', 'ref': '(صحیح مسلم: 55)'},
  {'arabic': 'الطُّهُورُ شَطْرُ الإِيمَانِ', 'urdu': '"پاکیزگی نصف ایمان ہے"', 'ref': '(صحیح مسلم: 223)'},
  {'arabic': 'اتَّقِ اللَّهَ حَيْثُمَا كُنْتَ', 'urdu': '"جہاں بھی ہو اللہ سے ڈرو"', 'ref': '(ترمذی: 1987)'},
  {'arabic': 'مَنْ لَا يَرْحَمُ لَا يُرْحَمُ', 'urdu': '"جو رحم نہیں کرتا، اس پر رحم نہیں کیا جاتا"', 'ref': '(صحیح بخاری: 5997)'},
  {'arabic': 'خَيْرُ النَّاسِ أَنْفَعُهُمْ لِلنَّاسِ', 'urdu': '"لوگوں میں سب سے بہتر وہ ہے جو لوگوں کے لیے سب سے زیادہ نفع بخش ہو"', 'ref': '(طبرانی)'},
  {'arabic': 'الْكَلِمَةُ الطَّيِّبَةُ صَدَقَةٌ', 'urdu': '"اچھی بات کہنا بھی صدقہ ہے"', 'ref': '(صحیح بخاری: 2989)'},
  {'arabic': 'تَبَسُّمُكَ فِي وَجْهِ أَخِيكَ لَكَ صَدَقَةٌ', 'urdu': '"اپنے بھائی کے سامنے مسکرانا بھی صدقہ ہے"', 'ref': '(ترمذی: 1956)'},
  {'arabic': 'مَنْ نَفَّسَ عَنْ مُؤْمِنٍ كُرْبَةً نَفَّسَ اللَّهُ عَنْهُ كُرْبَةً مِنْ كُرَبِ يَوْمِ الْقِيَامَةِ', 'urdu': '"جو کسی مومن کی پریشانی دور کرے، اللہ قیامت کے دن اس کی پریشانی دور فرمائے گا"', 'ref': '(صحیح مسلم: 2699)'},
  {'arabic': 'الْمُؤْمِنُ لِلْمُؤْمِنِ كَالْبُنْيَانِ يَشُدُّ بَعْضُهُ بَعْضًا', 'urdu': '"ایک مومن دوسرے مومن کے لیے عمارت کی طرح ہے، جس کا ایک حصہ دوسرے کو مضبوط کرتا ہے"', 'ref': '(صحیح بخاری: 481)'},
  {'arabic': 'إِنَّ اللَّهَ جَمِيلٌ يُحِبُّ الْجَمَالَ', 'urdu': '"بے شک اللہ خوبصورت ہے اور خوبصورتی کو پسند کرتا ہے"', 'ref': '(صحیح مسلم: 91)'},
  {'arabic': 'مَنْ صَلَّى عَلَيَّ صَلَاةً صَلَّى اللَّهُ عَلَيْهِ بِهَا عَشْرًا', 'urdu': '"جو مجھ پر ایک بار درود پڑھے، اللہ اس پر دس رحمتیں نازل فرماتا ہے"', 'ref': '(صحیح مسلم: 408)'},
  {'arabic': 'أَحَبُّ الأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ', 'urdu': '"اللہ کے نزدیک سب سے پسندیدہ عمل وہ ہے جو ہمیشہ کیا جائے، اگرچہ وہ تھوڑا ہو"', 'ref': '(صحیح بخاری: 6464)'},
  {'arabic': 'مَنْ حَجَّ فَلَمْ يَرْفُثْ وَلَمْ يَفْسُقْ رَجَعَ كَيَوْمِ وَلَدَتْهُ أُمُّهُ', 'urdu': '"جو حج کرے اور کوئی گناہ نہ کرے، وہ اس دن کی طرح پاک ہو جاتا ہے جس دن اس کی ماں نے اسے جنم دیا تھا"', 'ref': '(صحیح بخاری: 1521)'},
  {'arabic': 'لَا تَغْضَبْ', 'urdu': '"غصہ نہ کرو"', 'ref': '(صحیح بخاری: 6116)'},
  {'arabic': 'الْجَنَّةُ تَحْتَ أَقْدَامِ الأُمَّهَاتِ', 'urdu': '"جنت ماؤں کے قدموں کے نیچے ہے"', 'ref': '(نسائی)'},
  {'arabic': 'مَنْ أَصْبَحَ مِنْكُمْ آمِنًا فِي سِرْبِهِ مُعَافًى فِي جَسَدِهِ عِنْدَهُ قُوتُ يَوْمِهِ فَكَأَنَّمَا حِيزَتْ لَهُ الدُّنْيَا', 'urdu': '"جو شخص صبح اٹھے اور وہ امن میں ہو، جسم تندرست ہو، اور دن کا کھانا موجود ہو، تو گویا اسے پوری دنیا مل گئی"', 'ref': '(ترمذی: 2346)'},
  {'arabic': 'صَدَقَةُ السِّرِّ تُطْفِئُ غَضَبَ الرَّبِّ', 'urdu': '"چھپا کر صدقہ دینا اللہ کے غضب کو بجھا دیتا ہے"', 'ref': '(طبرانی)'},
  {'arabic': 'مَنْ سَتَرَ مُسْلِمًا سَتَرَهُ اللَّهُ فِي الدُّنْيَا وَالآخِرَةِ', 'urdu': '"جو کسی مسلمان کی پردہ پوشی کرے، اللہ دنیا اور آخرت میں اس کی پردہ پوشی فرمائے گا"', 'ref': '(صحیح مسلم: 2699)'},
  {'arabic': 'أَعْطُوا الأَجِيرَ أَجْرَهُ قَبْلَ أَنْ يَجِفَّ عَرَقُهُ', 'urdu': '"مزدور کو اس کی مزدوری اس کا پسینہ خشک ہونے سے پہلے دے دو"', 'ref': '(ابن ماجہ: 2443)'},
  {'arabic': 'مَنْ حَسُنَ خُلُقُهُ بَلَغَ دَرَجَةَ الصَّائِمِ الْقَائِمِ', 'urdu': '"جس کا اخلاق اچھا ہو، وہ روزہ رکھنے اور رات کو قیام کرنے والے کے درجے تک پہنچ جاتا ہے"', 'ref': '(ابو داؤد: 4798)'},
  {'arabic': 'مَنْ كَذَبَ عَلَيَّ مُتَعَمِّدًا فَلْيَتَبَوَّأْ مَقْعَدَهُ مِنَ النَّارِ', 'urdu': '"جس نے جان بوجھ کر مجھ پر جھوٹ باندھا، وہ اپنا ٹھکانہ جہنم میں بنا لے"', 'ref': '(صحیح بخاری: 110)'},
  {'arabic': 'بَلِّغُوا عَنِّي وَلَوْ آيَةً', 'urdu': '"میری طرف سے پہنچاؤ، اگرچہ ایک آیت ہی ہو"', 'ref': '(صحیح بخاری: 3461)'},
  {'arabic': 'الْمُسْلِمُ مِرْآةُ أَخِيهِ', 'urdu': '"مسلمان اپنے بھائی کا آئینہ ہے"', 'ref': '(ابو داؤد: 4918)'},
  {'arabic': 'مَنْ كَانَ فِي حَاجَةِ أَخِيهِ كَانَ اللَّهُ فِي حَاجَتِهِ', 'urdu': '"جو اپنے بھائی کی ضرورت میں ہو، اللہ اس کی ضرورت میں ہوتا ہے"', 'ref': '(صحیح بخاری: 2442)'},
  {'arabic': 'مَنْ لَزِمَ الاِسْتِغْفَارَ جَعَلَ اللَّهُ لَهُ مِنْ كُلِّ هَمٍّ فَرَجًا', 'urdu': '"جس نے استغفار کو لازم کر لیا، اللہ اس کے ہر غم سے نجات کا راستہ نکال دے گا"', 'ref': '(ابو داؤد: 1518)'},
  {'arabic': 'إِنَّ الرِّفْقَ لَا يَكُونُ فِي شَيْءٍ إِلَّا زَانَهُ', 'urdu': '"نرمی جس چیز میں بھی ہو، اسے خوبصورت بنا دیتی ہے"', 'ref': '(صحیح مسلم: 2594)'},
];

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

Map<String, String> get _todayAyah {
  int dayIndex = _now.day % _dailyAyats.length; 
  return _dailyAyats[dayIndex];
}

Map<String, String> get _todayHadith {
  int dayIndex = _now.day % _dailyHadiths.length; 
  return _dailyHadiths[dayIndex];
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
String _formatUrduDate(DateTime dt) {
  const urduMonths = [
    'جنوری', 'فروری', 'مارچ', 'اپریل', 'مئی', 'جون',
    'جولائی', 'اگست', 'ستمبر', 'اکتوبر', 'نومبر', 'دسمبر'
  ];
  const islamicMonths = [
    'محرم', 'صفر', 'ربیع الاول', 'ربیع الثانی', 'جمادی الاول', 'جمادی الثانی',
    'رجب', 'شعبان', 'رمضان', 'شوال', 'ذیقعدہ', 'ذی الحجہ'
  ];

  int islamicYear = dt.year - 622; 
  int islamicMonthIndex = (dt.month + 6) % 12; 

  return '${dt.day} ${urduMonths[dt.month - 1]} ${dt.year} | ${islamicMonths[islamicMonthIndex]} ${islamicYear}ھ';
}
  @override
Widget build(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    _launchWhatsApp();
  },
  backgroundColor: const Color(0xFF25D366),
  child: const Icon(Icons.wechat, color: Colors.white, size: 35),
),
     drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: const BoxDecoration(
          color: AppColors.deepGreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.gold,
              child: Icon(Icons.person, size: 40, color: AppColors.deepGreen),
            ),
            const SizedBox(height: 10),
            const Text(
              'The Muslim Way',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Offiicial App',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
      ListTile(
        leading: const Icon(Icons.info_outline, color: AppColors.deepGreen),
        title: const Text('About Us'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings, color: AppColors.deepGreen),
        title: const Text('Settings'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.chat, color: Colors.green),
        title: const Text('WhatsApp Support'),
        onTap: () {
          Navigator.pop(context);
        _launchWhatsApp();
        },
      ),
      ListTile(
        leading: const Icon(Icons.notifications, color: AppColors.deepGreen),
        title: const Text('Notifications'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.share, color: AppColors.deepGreen),
        title: const Text('Share App'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.verified, color: AppColors.gold),
        title: const Text('Version 1.0.0'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ],
  ),
),
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
              const SizedBox(height: 20),
              _buildDailyHadith(),
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
       
          Builder(
  builder: (context) => IconButton(
    icon: const Icon(Icons.menu, color: AppColors.gold, size: 30),
    onPressed: () => Scaffold.of(context).openDrawer(),
  ),
),
const SizedBox(width: 5),

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
        
        // 1. سلام اور خوش آمدید
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
        
        const SizedBox(height: 20),
        
        // 2. تاریخ اور لائیو ٹائم
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
  Expanded(
  child: Row(
    children: [
      const Icon(Icons.calendar_today, color: AppColors.gold, size: 16),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          _formatUrduDate(_now),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.cream,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ),
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
        
        const SizedBox(height: 10),
        
        // 3. اگلی نماز کا کارڈ (لائیو ٹائم کے ساتھ)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.gold.withOpacity(0.8),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.mosque, color: AppColors.gold, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'اگلی نماز: ${_nextPrayerInfo['name']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.timer, color: AppColors.gold, size: 18),
                  const SizedBox(width: 5),
                  Text(
                    'باقی وقت: ${_nextPrayerInfo['countdown']}',
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
              _makeCard(
                context, 
                Icons.auto_awesome, 
                'استخارہ', 
                AppColors.deepGreen,
                customAction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const IstikharaPage())),
              ),
              _makeCard(context, Icons.access_time, 'نماز کے اوقات', AppColors.deepGreen),
              _makeCard(context, Icons.explore, 'قبلہ کمپاس', AppColors.lightGreen),
              _makeCard(
  context, 
  Icons.star, 
  'اللہ کے 99 نام', 
  AppColors.gold,
  customAction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AsmaUlHusnaPage())),
),
              _makeCard(
  context, 
  Icons.help_outline, 
  'روز مرہ مسائل', 
  AppColors.lightGreen,
  customAction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyProblemsPage())),
),
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
        child: Column(
          children: [
            const Row(
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
            const SizedBox(height: 15),
            Text(
              _todayAyah['arabic']!,
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
              _todayAyah['urdu']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.darkText,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _todayAyah['ref']!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyHadith() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.deepGreen.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.auto_stories, color: AppColors.deepGreen, size: 22),
                SizedBox(width: 8),
                Text(
                  'آج کی حدیث',
                  style: TextStyle(
                    color: AppColors.deepGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              _todayHadith['arabic']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
                fontFamily: 'serif',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _todayHadith['urdu']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.darkText,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _todayHadith['ref']!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const IslamicCalendarPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.deepGreen, AppColors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepGreen.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.calendar_month, color: AppColors.gold, size: 35),
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Islamic & English Calendar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'اسلامی اور انگریزی کیلنڈر (تہوار اور چھٹیاں)',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_back_ios, color: AppColors.gold, size: 18),
          ],
        ),
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
// ============================================================
// QURAN PAGE — 114 سورتوں کی مکمل list
// ============================================================
class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  static const List<Map<String, dynamic>> surahs = [
    {
      'n': 1, 'name': 'الفاتحہ', 'en': 'Al-Fatihah', 'ayat': 7, 'type': 'مکی',
      'verses': [
        {'arabic': 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', 'urdu': 'شروع اللہ کے نام سے جو بڑا مہربان نہایت رحم والا ہے۔'},
        {'arabic': 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ', 'urdu': 'سب تعریف اللہ کے لیے ہے جو تمام جہانوں کا پالنے والا ہے۔'},
        {'arabic': 'الرَّحْمَٰنِ الرَّحِيمِ', 'urdu': 'بڑا مہربان نہایت رحم والا۔'},
        {'arabic': 'مَالِكِ يَوْمِ الدِّينِ', 'urdu': 'انصاف کے دن کا حاکم۔'},
        {'arabic': 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ', 'urdu': 'ہم تیری ہی عبادت کرتے ہیں اور تجھ ہی سے مدد مانگتے ہیں۔'},
        {'arabic': 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ', 'urdu': 'ہمیں سیدھا راستہ دکھا۔'},
        {'arabic': 'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ', 'urdu': 'ان لوگوں کا راستہ جن پر تو نے انعام کیا، نہ ان کا جن پر غضب ہوا اور نہ گمراہوں کا۔'},
      ]
    },
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
    {
      'n': 103, 'name': 'العصر', 'en': 'Al-Asr', 'ayat': 3, 'type': 'مکی',
      'verses': [
        {'arabic': 'وَالْعَصْرِ', 'urdu': 'زمانے کی قسم ہے۔'},
        {'arabic': 'إِنَّ الْإِنسَانَ لَفِي خُسْرٍ', 'urdu': 'بے شک انسان خسارے میں ہے۔'},
        {'arabic': 'إِلَّا الَّذِينَ آمَنُوا وَعَمِلُوا الصَّالِحَاتِ وَتَوَاصَوْا بِالْحَقِّ وَتَوَاصَوْا بِالصَّبْرِ', 'urdu': 'سوائے ان کے جو ایمان لائے، نیک عمل کیے، اور ایک دوسرے کو حق اور صبر کی تلقین کی۔'},
      ]
    },
    {'n': 104, 'name': 'الہمزہ', 'en': 'Al-Humazah', 'ayat': 9, 'type': 'مکی'},
    {
      'n': 105, 'name': 'الفیل', 'en': 'Al-Fil', 'ayat': 5, 'type': 'مکی',
      'verses': [
        {'arabic': 'أَلَمْ تَرَ كَيْفَ فَعَلَ رَبُّكَ بِأَصْحَابِ الْفِيلِ', 'urdu': 'کیا آپ نے نہیں دیکھا کہ آپ کے رب نے ہاتھی والوں کے ساتھ کیا کیا؟'},
        {'arabic': 'أَلَمْ يَجْعَلْ كَيْدَهُمْ فِي تَضْلِيلٍ', 'urdu': 'کیا اس نے ان کی چال کو بے کار نہیں کر دیا؟'},
        {'arabic': 'وَأَرْسَلَ عَلَيْهِمْ طَيْرًا أَبَابِيلَ', 'urdu': 'اور ان پر غول کے غول پرندے بھیجے۔'},
        {'arabic': 'تَرْمِيهِم بِحِجَارَةٍ مِّن سِجِّيلٍ', 'urdu': 'جو ان پر کھدی ہوئی مٹی کے پتھر مارتے تھے۔'},
        {'arabic': 'فَجَعَلَهُمْ كَعَصْفٍ مَّأْكُولٍ', 'urdu': 'پس انہیں کھائے ہوئے بھوسے کی طرح کر دیا۔'},
      ]
    },
    {
      'n': 106, 'name': 'قریش', 'en': 'Quraish', 'ayat': 4, 'type': 'مکی',
      'verses': [
        {'arabic': 'لِإِيلَافِ قُرَيْشٍ', 'urdu': 'قریش کو مانوس کرنے کے لیے۔'},
        {'arabic': 'إِيلَافِهِمْ رِحْلَةَ الشِّتَاءِ وَالصَّيْفِ', 'urdu': 'یعنی انہیں سردی اور گرمی کے سفر سے مانوس کرنے کے لیے۔'},
        {'arabic': 'فَلْيَعْبُدُوا رَبَّ هَٰذَا الْبَيْتِ', 'urdu': 'پس انہیں چاہیے کہ اس گھر (کعبہ) کے رب کی عبادت کریں۔'},
        {'arabic': 'الَّذِي أَطْعَمَهُم مِّن جُوعٍ وَآمَنَهُم مِّنْ خَوْفٍ', 'urdu': 'جس نے انہیں بھوک میں کھانا کھلایا اور خوف سے امن دیا۔'},
      ]
    },
    {
      'n': 107, 'name': 'الماعون', 'en': 'Al-Maun', 'ayat': 7, 'type': 'مکی',
      'verses': [
        {'arabic': 'أَرَأَيْتَ الَّذِي يُكَذِّبُ بِالدِّينِ', 'urdu': 'کیا آپ نے اس شخص کو دیکھا جو انصاف کے دن کو جھٹلاتا ہے؟'},
        {'arabic': 'فَذَٰلِكَ الَّذِي يَدُعُّ الْيَتِيمَ', 'urdu': 'پس یہی وہ ہے جو یتیم کو دھکے دیتا ہے۔'},
        {'arabic': 'وَلَا يَحُضُّ عَلَىٰ طَعَامِ الْمِسْكِينِ', 'urdu': 'اور مسکین کو کھانا کھلانے کی ترغیب نہیں دیتا۔'},
        {'arabic': 'فَوَيْلٌ لِّلْمُصَلِّينَ', 'urdu': 'پس نمازیوں کے لیے تباہی ہے۔'},
        {'arabic': 'الَّذِينَ هُمْ عَن صَلَاتِهِمْ سَاهُونَ', 'urdu': 'جو اپنی نمازوں سے غافل ہیں۔'},
        {'arabic': 'الَّذِينَ هُمْ يُرَاءُونَ', 'urdu': 'جو دکھلاوا کرتے ہیں۔'},
        {'arabic': 'وَيَمْنَعُونَ الْمَاعُونَ', 'urdu': 'اور ضرورت کی چیزوں (کے دینے) سے انکار کرتے ہیں۔'},
      ]
    },
    {
      'n': 108, 'name': 'الکوثر', 'en': 'Al-Kauthar', 'ayat': 3, 'type': 'مکی',
      'verses': [
        {'arabic': 'إِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ', 'urdu': 'بے شک ہم نے آپ کو کوثر (بہت بڑی نعمت) عطا کی ہے۔'},
        {'arabic': 'فَصَلِّ لِرَبِّكَ وَانْحَرْ', 'urdu': 'پس اپنے رب کے لیے نماز پڑھیں اور قربانی کریں۔'},
        {'arabic': 'إِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ', 'urdu': 'بے شک آپ کا دشمن ہی بے نام و نشان ہے۔'},
      ]
    },
    {
      'n': 109, 'name': 'الکافرون', 'en': 'Al-Kafirun', 'ayat': 6, 'type': 'مکی',
      'verses': [
        {'arabic': 'قُلْ يَا أَيُّهَا الْكَافِرُونَ', 'urdu': 'کہہ دو اے کافرو!۔'},
        {'arabic': 'لَا أَعْبُدُ مَا تَعْبُدُونَ', 'urdu': 'میں ان کی عبادت نہیں کرتا جن کی تم عبادت کرتے ہو۔'},
        {'arabic': 'وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ', 'urdu': 'اور نہ تم ان کی عبادت کرنے والے ہو جن کی میں عبادت کرتا ہوں۔'},
        {'arabic': 'وَلَا أَنَا عَابِدٌ مَّا عَبَدتُّمْ', 'urdu': 'اور نہ میں ان کی عبادت کرنے والا ہوں جن کی تم نے عبادت کی۔'},
        {'arabic': 'وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ', 'urdu': 'اور نہ تم ان کی عبادت کرنے والے ہو جن کی میں عبادت کرتا ہوں۔'},
        {'arabic': 'لَكُمْ دِينُكُمْ وَلِيَ دِينِ', 'urdu': 'تمہارے لیے تمہارا دین اور میرے لیے میرا دین۔'},
      ]
    },
    {
      'n': 110, 'name': 'النصر', 'en': 'An-Nasr', 'ayat': 3, 'type': 'مدنی',
      'verses': [
        {'arabic': 'إِذَا جَاءَ نَصْرُ اللَّهِ وَالْفَتْحُ', 'urdu': 'جب اللہ کی مدد آئی اور فتح حاصل ہوئی۔'},
        {'arabic': 'وَرَأَيْتَ النَّاسَ يَدْخُلُونَ فِي دِينِ اللَّهِ أَفْوَاجًا', 'urdu': 'اور آپ نے لوگوں کو دیکھا کہ وہ اللہ کے دین میں فوج در فوج داخل ہو رہے ہیں۔'},
        {'arabic': 'فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚ إِنَّهُ كَانَ تَوَّابًا', 'urdu': 'تو اپنے رب کی حمد کے ساتھ تسبیح کریں اور اس سے بخشش مانگیں، بے شک وہ بہت توبہ قبول کرنے والا ہے۔'},
      ]
    },
    {
      'n': 111, 'name': 'اللہب', 'en': 'Al-Lahab', 'ayat': 5, 'type': 'مکی',
      'verses': [
        {'arabic': 'تَبَّتْ يَدَا أَبِي لَهَبٍ وَتَبَّ', 'urdu': 'ابو لہب کے دونوں ہاتھ ٹوٹ جائیں اور وہ خود بھی ہلاک ہو۔'},
        {'arabic': 'مَا أَغْنَىٰ عَنْهُ مَالُهُ وَمَا كَسَبَ', 'urdu': 'نہ اس کا مال اس کے کام آیا اور نہ اس کی کمائی۔'},
        {'arabic': 'سَيَصْلَىٰ نَارًا ذَاتَ لَهَبٍ', 'urdu': 'عنقریب وہ شعلہ زن آگ میں داخل ہوگا۔'},
        {'arabic': 'وَامْرَأَتُهُ حَمَّالَةَ الْحَطَبِ', 'urdu': 'اور اس کی عورت بھی، جو لکڑیاں ڈھونے والی ہے۔'},
        {'arabic': 'فِي جِيدِهَا حَبْلٌ مِّن مَّسَدٍ', 'urdu': 'اس کی گردن میں مونجھ کی رسی ہوگی۔'},
      ]
    },
    {
      'n': 112, 'name': 'الاخلاص', 'en': 'Al-Ikhlas', 'ayat': 4, 'type': 'مکی',
      'verses': [
        {'arabic': 'قُلْ هُوَ اللَّهُ أَحَدٌ', 'urdu': 'کہہ دو کہ وہ اللہ ایک ہے۔'},
        {'arabic': 'اللَّهُ الصَّمَدُ', 'urdu': 'اللہ بے نیاز ہے۔'},
        {'arabic': 'لَمْ يَلِدْ وَلَمْ يُولَدْ', 'urdu': 'نہ اس نے کسی کو جنا اور نہ وہ کسی سے جنا گیا۔'},
        {'arabic': 'وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ', 'urdu': 'اور نہ کوئی اس کا ہمسر ہے۔'},
      ]
    },
    {
      'n': 113, 'name': 'الفلق', 'en': 'Al-Falaq', 'ayat': 5, 'type': 'مکی',
      'verses': [
        {'arabic': 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ', 'urdu': 'کہہ دو میں صبح کے رب کی پناہ مانگتا ہوں۔'},
        {'arabic': 'مِن شَرِّ مَا خَلَقَ', 'urdu': 'ہر اس چیز کے شر سے جو اس نے پیدا کی۔'},
        {'arabic': 'وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ', 'urdu': 'اور اندھیری رات کے شر سے جب وہ چھا جائے۔'},
        {'arabic': 'وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ', 'urdu': 'اور گرہوں میں پھونکنے والیوں کے شر سے۔'},
        {'arabic': 'وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ', 'urdu': 'اور حسد کرنے والے کے شر سے جب وہ حسد کرے۔'},
      ]
    },
    {
      'n': 114, 'name': 'الناس', 'en': 'An-Nas', 'ayat': 6, 'type': 'مکی',
      'verses': [
        {'arabic': 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ', 'urdu': 'کہہ دو میں لوگوں کے رب کی پناہ مانگتا ہوں۔'},
        {'arabic': 'مَلِكِ النَّاسِ', 'urdu': 'لوگوں کے بادشاہ کی۔'},
        {'arabic': 'إِلَٰهِ النَّاسِ', 'urdu': 'لوگوں کے معبود کی۔'},
        {'arabic': 'مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ', 'urdu': 'وسوسہ ڈالنے والے، پیچھے ہٹ جانے والے کے شر سے۔'},
        {'arabic': 'الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ', 'urdu': 'جو لوگوں کے دلوں میں وسوسہ ڈالتا ہے۔'},
        {'arabic': 'مِنَ الْجِنَّةِ وَالنَّاسِ', 'urdu': 'وہ جنوں میں سے ہو یا انسانوں میں سے۔'},
      ]
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
            builder: (_) => SurahDetailPage(
              surah: QuranPage.surahs.firstWhere((s) => s['n'] == number),
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
      ]
    },
    {
      'name': 'شام کی دعائیں',
      'en': 'Evening Duas',
      'icon': Icons.nights_stay,
      'color': Color(0xFF4A235A),
      'duas': [
        {'title': 'شام کی دعا', 'arabic': 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ', 'urdu': 'ہم نے شام کی اور ساری بادشاہت اللہ ہی کے لیے شام ہوئی، اور سب تعریف اللہ کے لیے ہے۔ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں۔', 'ref': 'صحیح مسلم: 2723'},
      ]
    },
    {
      'name': 'کھانے کی دعائیں',
      'en': 'Eating Duas',
      'icon': Icons.restaurant,
      'color': Color(0xFF2E7D32),
      'duas': [
        {'title': 'کھانے سے پہلے کی دعا', 'arabic': 'بِسْمِ اللَّهِ وَعَلَى بَرَكَةِ اللَّهِ', 'urdu': 'اللہ کے نام سے اور اللہ کی برکت پر (شروع کرتا ہوں)۔', 'ref': 'ابو داؤد: 3767'},
      ]
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
            childAspectRatio: 1.0,
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
// ============================================================
// ISTIKHARA PAGE — استخارہ
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
          title: const Text(
            'استخارہ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionCard(
                title: 'استخارہ کیا ہے؟',
                icon: Icons.info_outline,
                content: 'استخارہ کا مطلب ہے کسی معاملے میں اللہ تعالیٰ سے بھلائی طلب کرنا۔ جب انسان کسی جائز کام کا ارادہ کرے اور اسے صحیح فیصلہ کرنے میں الجھن ہو، تو وہ نماز پڑھ کر اللہ سے مدد مانگتا ہے تاکہ اللہ اس کے لیے بہتر فیصلہ آسان فرمائے۔',
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                title: 'استخارہ کا طریقہ',
                icon: Icons.format_list_numbered,
                content: '1. پہلے وضو کریں اور اچھی طرح تیار ہوں۔\n2. کوئی بھی دو رکعت نفل نماز پڑھیں (بہتر ہے کہ پہلی رکعت میں سورۃ الکافرون اور دوسری میں سورۃ الاخلاص پڑھیں)۔\n3. نماز کے بعد اللہ کی حمد و ثنا کریں اور درود شریف پڑھیں۔\n4. پھر نیچے دی گئی مسنون دعا پڑھیں۔\n5. دل میں اپنے اس کام کا ارادہ کریں۔\n6. اللہ جو بہتر سمجھے گا، وہ کام آسان کر دے گا۔',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 2),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.brightness_5, color: AppColors.gold),
                        SizedBox(width: 8),
                        Text(
                          'مسنون دعا',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepGreen),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'اللَّهُمَّ إِنِّي أَسْتَخِيرُكَ بِعِلْمِكَ وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ فَإِنَّكَ تَقْدِرُ وَلَا أَقْدِرُ وَتَعْلَمُ وَلَا أَعْلَمُ وَأَنْتَ عَلَّامُ الْغُيُوبِ اللَّهُمَّ إِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الْأَمْرَ خَيْرٌ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي فَاقْدُرْهُ لِي وَيَسِّرْهُ لِي ثُمَّ بَارِكْ لِي فِيهِ وَإِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الْأَمْرَ شَرٌّ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي فَاصْرِفْهُ عَنِّي وَاصْرِفْنِي عَنْهُ وَاقْدُرْ لِي الْخَيْرَ حَيْثُ كَانَ ثُمَّ أَرْضِنِي بِهِ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontFamily: 'serif', height: 2.0, color: AppColors.darkText),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.gold),
                    const SizedBox(height: 8),
                    Text(
                      '"اے اللہ! میں تجھ سے تیرے علم کے ذریعے بھلائی چاہتا ہوں اور تیری قدرت کے ذریعے طاقت مانگتا ہوں۔ میں تجھ سے تیرے فضلِ عظیم کی درخواست کرتا ہوں، کیونکہ تو قدرت رکھتا ہے اور میں نہیں، تو جانتا ہے اور میں نہیں جانتا، تو تمام پوشیدہ چیزوں کا جاننے والا ہے۔ اے اللہ! اگر تو جانتا ہے کہ یہ کام میرے لیے میرے دین، میرے رزق اور میرے انجام کے لحاظ سے بہتر ہے، تو اسے میرے لیے مقدر فرما، آسان فرما اور پھر اس میں برکت دے۔ اور اگر تو جانتا ہے کہ یہ کام میرے لیے میرے دین، میرے رزق اور میرے انجام کے لحاظ سے برا ہے، تو اسے مجھ سے پھیر دے اور مجھے اس سے پھیر دے، اور میرے لیے جہاں بھی بھلائی ہو وہ مقدر فرما اور پھر مجھے اس پر راضی کر دے۔"',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'حوالہ: صحیح بخاری (1166)',
                      style: TextStyle(fontSize: 12, color: AppColors.gold, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                title: 'عام غلط فہمیاں',
                icon: Icons.warning_amber_rounded,
                content: '1. یہ ضروری نہیں کہ خواب میں اشارہ ملے۔\n2. استخارہ کا مطلب یہ نہیں کہ آپ کوئی کام شروع ہی نہ کریں۔ پہلے مشورہ کریں، پھر استخارہ کریں۔\n3. استخارہ صرف بڑے کاموں کے لیے نہیں، بلکہ ہر جائز معاملے میں کیا جا سکتا ہے۔',
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required String content}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.deepGreen.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.deepGreen),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepGreen),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.6),
          ),
        ],
      ),
    );
  }
}
// ============================================================
// SURAH DETAIL PAGE — سورت کا صفحہ
// ============================================================
class SurahDetailPage extends StatelessWidget {
  final Map<String, dynamic> surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    List<dynamic> verses = surah['verses'] ?? [];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          title: Text(
            surah['name'],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: verses.isEmpty
            ? const Center(
                child: Text(
                  'اس سورت کا ترجمہ جلد شامل کیا جائے گا۔',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: verses.length,
                itemBuilder: (context, index) {
                  final verse = verses[index];
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.deepGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'آیت ${index + 1}',
                              style: const TextStyle(color: AppColors.deepGreen, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          verse['arabic'] ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'serif',
                            height: 2.0,
                            color: AppColors.darkText,
                          ),
                        ),
                        const Divider(color: AppColors.gold, height: 30),
                        Text(
                          verse['urdu'] ?? '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            height: 1.6,
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
// ============================================================
// ISLAMIC & ENGLISH CALENDAR PAGE
// ============================================================
class IslamicCalendarPage extends StatelessWidget {
  const IslamicCalendarPage({super.key});

  static const List<Map<String, String>> islamicEvents = [
    {'date': '1 محرم', 'event': 'اسلامی نیا سال'},
    {'date': '10 محرم', 'event': 'یومِ عاشورہ'},
    {'date': '12 ربیع الاول', 'event': 'عید میلاد النبی ﷺ'},
    {'date': '27 رجب', 'event': 'شبِ معراج'},
    {'date': '15 شعبان', 'event': 'شبِ برات'},
    {'date': '1 رمضان', 'event': 'رمضان المبارک کا آغاز'},
    {'date': '27 رمضان', 'event': 'شبِ قدر (اندازاً)'},
    {'date': '1 شوال', 'event': 'عید الفطر'},
    {'date': '9 ذی الحجہ', 'event': 'یومِ عرفہ'},
    {'date': '10 ذی الحجہ', 'event': 'عید الاضحیٰ'},
  ];

  static const List<String> englishMonths = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> islamicMonths = [
    'محرم', 'صفر', 'ربیع الاول', 'ربیع الثانی', 'جمادی الاول', 'جمادی الثانی',
    'رجب', 'شعبان', 'رمضان', 'شوال', 'ذیقعدہ', 'ذی الحجہ'
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.deepGreen,
          title: const Text(
            'اسلامی اور انگریزی کیلنڈر',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.deepGreen, AppColors.lightGreen],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'آج کی تاریخ',
                      style: TextStyle(color: AppColors.gold, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${now.day} ${englishMonths[now.month - 1]} ${now.year}',
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${islamicMonths[(now.month + 6) % 12]} ${now.year - 622}ھ (اندازاً)',
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'اسلامی تہوار اور اہم دن',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepGreen),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: islamicEvents.length,
                itemBuilder: (context, index) {
                  final event = islamicEvents[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.deepGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            event['date']!,
                            style: const TextStyle(color: AppColors.deepGreen, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            event['event']!,
                            style: const TextStyle(fontSize: 15, color: AppColors.darkText),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'انگریزی مہینے',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepGreen),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: englishMonths.map((month) {
                  return Chip(
                    label: Text(month),
                    backgroundColor: AppColors.deepGreen.withOpacity(0.1),
                    labelStyle: const TextStyle(color: AppColors.deepGreen),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
class AsmaUlHusnaPage extends StatelessWidget {
  const AsmaUlHusnaPage({super.key});

  static const List<Map<String, String>> names = [
  {'arabic': 'الرَّحْمَنُ', 'urdu': 'الرحمٰن', 'meaning': 'بہت مہربان'},
  {'arabic': 'الرَّحِيمُ', 'urdu': 'الرحیم', 'meaning': 'نہایت رحم والا'},
  {'arabic': 'الْمَلِكُ', 'urdu': 'الملک', 'meaning': 'بادشاہ'},
  {'arabic': 'الْقُدُّوسُ', 'urdu': 'القدوس', 'meaning': 'پاکیزہ'},
  {'arabic': 'السَّلَامُ', 'urdu': 'السلام', 'meaning': 'سلامتی والا'},
  {'arabic': 'الْمُؤْمِنُ', 'urdu': 'المؤمن', 'meaning': 'امن دینے والا'},
  {'arabic': 'الْمُهَيْمِنُ', 'urdu': 'المہیمن', 'meaning': 'نگہبان'},
  {'arabic': 'الْعَزِيزُ', 'urdu': 'العزیز', 'meaning': 'غالب'},
  {'arabic': 'الْجَبَّارُ', 'urdu': 'الجبار', 'meaning': 'زبردست'},
  {'arabic': 'الْمُتَكَبِّرُ', 'urdu': 'المتكبر', 'meaning': 'بڑائی والا'},
  {'arabic': 'الْخَالِقُ', 'urdu': 'الخالق', 'meaning': 'پیدا کرنے والا'},
  {'arabic': 'الْبَارِئُ', 'urdu': 'البارئ', 'meaning': 'بنانے والا'},
  {'arabic': 'الْمُصَوِّرُ', 'urdu': 'المصور', 'meaning': 'صورت بنانے والا'},
  {'arabic': 'الْغَفَّارُ', 'urdu': 'الغفار', 'meaning': 'بہت بخشنے والا'},
  {'arabic': 'الْقَهَّارُ', 'urdu': 'القهار', 'meaning': 'سب پر غالب'},
  {'arabic': 'الْوَهَّابُ', 'urdu': 'الوهاب', 'meaning': 'بہت عطا کرنے والا'},
  {'arabic': 'الرَّزَّاقُ', 'urdu': 'الرزاق', 'meaning': 'رزق دینے والا'},
  {'arabic': 'الْفَتَّاحُ', 'urdu': 'الفتاح', 'meaning': 'کھولنے والا'},
  {'arabic': 'الْعَلِيمُ', 'urdu': 'العلیم', 'meaning': 'سب جاننے والا'},
  {'arabic': 'الْقَابِضُ', 'urdu': 'القابض', 'meaning': 'تنگی کرنے والا'},
  {'arabic': 'الْبَاسِطُ', 'urdu': 'الباسط', 'meaning': 'کشادگی دینے والا'},
  {'arabic': 'الْخَافِضُ', 'urdu': 'الخافض', 'meaning': 'پست کرنے والا'},
  {'arabic': 'الرَّافِعُ', 'urdu': 'الرافع', 'meaning': 'بلند کرنے والا'},
  {'arabic': 'الْمُعِزُّ', 'urdu': 'المعز', 'meaning': 'عزت دینے والا'},
  {'arabic': 'الْمُذِلُّ', 'urdu': 'المذل', 'meaning': 'ذلیل کرنے والا'},
  {'arabic': 'السَّمِيعُ', 'urdu': 'السمیع', 'meaning': 'سننے والا'},
  {'arabic': 'الْبَصِيرُ', 'urdu': 'البصیر', 'meaning': 'دیکھنے والا'},
  {'arabic': 'الْحَكَمُ', 'urdu': 'الحکم', 'meaning': 'فیصلہ کرنے والا'},
  {'arabic': 'الْعَدْلُ', 'urdu': 'العدل', 'meaning': 'انصاف کرنے والا'},
  {'arabic': 'اللَّطِيفُ', 'urdu': 'اللطیف', 'meaning': 'مہربان'},
  {'arabic': 'الْخَبِيرُ', 'urdu': 'الخبیر', 'meaning': 'باخبر'},
  {'arabic': 'الْحَلِيمُ', 'urdu': 'الحلیم', 'meaning': 'بردبار'},
  {'arabic': 'الْعَظِيمُ', 'urdu': 'العظیم', 'meaning': 'بڑا'},
  {'arabic': 'الْغَفُورُ', 'urdu': 'الغفور', 'meaning': 'بخشنے والا'},
  {'arabic': 'الشَّكُورُ', 'urdu': 'الشکور', 'meaning': 'قدر کرنے والا'},
  {'arabic': 'الْعَلِيُّ', 'urdu': 'العلی', 'meaning': 'بلند'},
  {'arabic': 'الْكَبِيرُ', 'urdu': 'الکبیر', 'meaning': 'بہت بڑا'},
  {'arabic': 'الْحَفِيظُ', 'urdu': 'الحفیظ', 'meaning': 'حفاظت کرنے والا'},
  {'arabic': 'الْمُقِيتُ', 'urdu': 'المقیت', 'meaning': 'روزی دینے والا'},
  {'arabic': 'الْحَسِيبُ', 'urdu': 'الحسیب', 'meaning': 'حساب لینے والا'},
  {'arabic': 'الْجَلِيلُ', 'urdu': 'الجلیل', 'meaning': 'عظمت والا'},
  {'arabic': 'الْكَرِيمُ', 'urdu': 'الکریم', 'meaning': 'کرم کرنے والا'},
  {'arabic': 'الرَّقِيبُ', 'urdu': 'الرقیب', 'meaning': 'نگہداشت کرنے والا'},
  {'arabic': 'الْمُجِيبُ', 'urdu': 'المجیب', 'meaning': 'دعا قبول کرنے والا'},
  {'arabic': 'الْوَاسِعُ', 'urdu': 'الواسع', 'meaning': 'کشادگی والا'},
  {'arabic': 'الْحَكِيمُ', 'urdu': 'الحکیم', 'meaning': 'حکمت والا'},
  {'arabic': 'الْوَدُودُ', 'urdu': 'الودود', 'meaning': 'محبت کرنے والا'},
  {'arabic': 'الْمَجِيدُ', 'urdu': 'المجید', 'meaning': 'بزرگی والا'},
  {'arabic': 'الْبَاعِثُ', 'urdu': 'الباعث', 'meaning': 'اٹھانے والا'},
  {'arabic': 'الشَّهِيدُ', 'urdu': 'الشہید', 'meaning': 'گواہ'},
  {'arabic': 'الْحَقُّ', 'urdu': 'الحق', 'meaning': 'سچا'},
  {'arabic': 'الْوَكِيلُ', 'urdu': 'الوکیل', 'meaning': 'کارساز'},
  {'arabic': 'الْقَوِيُّ', 'urdu': 'القوی', 'meaning': 'طاقتور'},
  {'arabic': 'الْمَتِينُ', 'urdu': 'المتین', 'meaning': 'مضبوط'},
  {'arabic': 'الْوَلِيُّ', 'urdu': 'الولی', 'meaning': 'مددگار'},
  {'arabic': 'الْحَمِيدُ', 'urdu': 'الحمید', 'meaning': 'تعریف والا'},
  {'arabic': 'الْمُحْصِي', 'urdu': 'المحسی', 'meaning': 'گننے والا'},
  {'arabic': 'الْمُبْدِئُ', 'urdu': 'المبدئ', 'meaning': 'شروع کرنے والا'},
  {'arabic': 'الْمُعِيدُ', 'urdu': 'المعید', 'meaning': 'لوٹانے والا'},
  {'arabic': 'الْمُحْيِي', 'urdu': 'المحیی', 'meaning': 'زندگی دینے والا'},
  {'arabic': 'الْمُمِيتُ', 'urdu': 'الممیت', 'meaning': 'موت دینے والا'},
  {'arabic': 'الْحَيُّ', 'urdu': 'الحی', 'meaning': 'زندہ'},
  {'arabic': 'الْقَيُّومُ', 'urdu': 'القیوم', 'meaning': 'قائم رکھنے والا'},
  {'arabic': 'الْوَاجِدُ', 'urdu': 'الواجد', 'meaning': 'پانے والا'},
  {'arabic': 'الْمَاجِدُ', 'urdu': 'الماجد', 'meaning': 'بزرگ'},
  {'arabic': 'الْوَاحِدُ', 'urdu': 'الواحد', 'meaning': 'ایک'},
  {'arabic': 'الْأَحَدُ', 'urdu': 'الاحد', 'meaning': 'بے نظیر'},
  {'arabic': 'الصَّمَدُ', 'urdu': 'الصمد', 'meaning': 'بے نیاز'},
  {'arabic': 'الْقَادِرُ', 'urdu': 'القادر', 'meaning': 'طاقت والا'},
  {'arabic': 'الْمُقْتَدِرُ', 'urdu': 'المقتدر', 'meaning': 'قدرت والا'},
  {'arabic': 'الْمُقَدِّمُ', 'urdu': 'المقدم', 'meaning': 'آگے کرنے والا'},
  {'arabic': 'الْمُؤَخِّرُ', 'urdu': 'المؤخر', 'meaning': 'پیچھے کرنے والا'},
  {'arabic': 'الْأَوَّلُ', 'urdu': 'الاول', 'meaning': 'پہلا'},
  {'arabic': 'الْآخِرُ', 'urdu': 'الآخر', 'meaning': 'آخری'},
  {'arabic': 'الظَّاهِرُ', 'urdu': 'الظاہر', 'meaning': 'ظاہر'},
  {'arabic': 'الْبَاطِنُ', 'urdu': 'الباطن', 'meaning': 'پوشیدہ'},
  {'arabic': 'الْوَالِي', 'urdu': 'الوالی', 'meaning': 'حاکم'},
  {'arabic': 'الْمُتَعَالِي', 'urdu': 'المتعالی', 'meaning': 'بلند تر'},
  {'arabic': 'الْبَرُّ', 'urdu': 'البر', 'meaning': 'نیکی کرنے والا'},
  {'arabic': 'التَّوَّابُ', 'urdu': 'التواب', 'meaning': 'توبہ قبول کرنے والا'},
  {'arabic': 'الْمُنْتَقِمُ', 'urdu': 'المنتقم', 'meaning': 'بدلہ لینے والا'},
  {'arabic': 'الْعَفُوُّ', 'urdu': 'العفو', 'meaning': 'معاف کرنے والا'},
  {'arabic': 'الرَّءُوفُ', 'urdu': 'الرؤف', 'meaning': 'شفقت کرنے والا'},
  {'arabic': 'مَالِكُ الْمُلْكِ', 'urdu': 'مالک الملک', 'meaning': 'بادشاہی کا مالک'},
  {'arabic': 'ذُو الْجَلَالِ وَالْإِكْرَامِ', 'urdu': 'ذوالجلال والاکرام', 'meaning': 'عظمت والا'},
  {'arabic': 'الْمُقْسِطُ', 'urdu': 'المقسط', 'meaning': 'انصاف کرنے والا'},
  {'arabic': 'الْجَامِعُ', 'urdu': 'الجامع', 'meaning': 'جمع کرنے والا'},
  {'arabic': 'الْغَنِيُّ', 'urdu': 'الغنی', 'meaning': 'مالک'},
  {'arabic': 'الْمُغْنِي', 'urdu': 'المغني', 'meaning': 'مالدار کرنے والا'},
  {'arabic': 'الْمَانِعُ', 'urdu': 'المانع', 'meaning': 'روکنے والا'},
  {'arabic': 'الضَّارُّ', 'urdu': 'الضار', 'meaning': 'تکلیف دینے والا'},
  {'arabic': 'النَّافِعُ', 'urdu': 'النافع', 'meaning': 'نفع دینے والا'},
  {'arabic': 'النُّورُ', 'urdu': 'النور', 'meaning': 'روشنی'},
  {'arabic': 'الْهَادِي', 'urdu': 'الہادی', 'meaning': 'ہدایت دینے والا'},
  {'arabic': 'الْبَدِيعُ', 'urdu': 'البدیع', 'meaning': 'نیا پیدا کرنے والا'},
  {'arabic': 'الْبَاقِي', 'urdu': 'الباقی', 'meaning': 'ہمیشہ رہنے والا'},
  {'arabic': 'الْوَارِثُ', 'urdu': 'الوارث', 'meaning': 'وارث'},
  {'arabic': 'الرَّشِيدُ', 'urdu': 'الرشید', 'meaning': 'راہ دکھانے والا'},
  {'arabic': 'الصَّبُورُ', 'urdu': 'الصبور', 'meaning': 'صبر کرنے والا'},
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
            'اللہ کے 99 نام',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: names.length,
          itemBuilder: (context, index) {
            final name = names[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.gold.withOpacity(0.4), width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name['arabic']!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepGreen,
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    name['urdu']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    name['meaning']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
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
 const List<Map<String, String>> names = [
  {'arabic': 'الرَّحْمَنُ', 'urdu': 'الرحمٰن', 'meaning': 'بہت مہربان'},
  {'arabic': 'الرَّحِيمُ', 'urdu': 'الرحیم', 'meaning': 'نہایت رحم والا'},
  {'arabic': 'الْمَلِكُ', 'urdu': 'الملک', 'meaning': 'بادشاہ'},
  {'arabic': 'الْقُدُّوسُ', 'urdu': 'القدوس', 'meaning': 'پاکیزہ'},
  {'arabic': 'السَّلَامُ', 'urdu': 'السلام', 'meaning': 'سلامتی والا'},
  {'arabic': 'الْمُؤْمِنُ', 'urdu': 'المؤمن', 'meaning': 'امن دینے والا'},
  {'arabic': 'الْمُهَيْمِنُ', 'urdu': 'المہیمن', 'meaning': 'نگہبان'},
  {'arabic': 'الْعَزِيزُ', 'urdu': 'العزیز', 'meaning': 'غالب'},
  {'arabic': 'الْجَبَّارُ', 'urdu': 'الجبار', 'meaning': 'زبردست'},
  {'arabic': 'الْمُتَكَبِّرُ', 'urdu': 'المتكبر', 'meaning': 'بڑائی والا'},
  {'arabic': 'الْخَالِقُ', 'urdu': 'الخالق', 'meaning': 'پیدا کرنے والا'},
  {'arabic': 'الْبَارِئُ', 'urdu': 'البارئ', 'meaning': 'بنانے والا'},
  {'arabic': 'الْمُصَوِّرُ', 'urdu': 'المصور', 'meaning': 'صورت بنانے والا'},
  {'arabic': 'الْغَفَّارُ', 'urdu': 'الغفار', 'meaning': 'بہت بخشنے والا'},
  {'arabic': 'الْقَهَّارُ', 'urdu': 'القهار', 'meaning': 'سب پر غالب'},
  {'arabic': 'الْوَهَّابُ', 'urdu': 'الوهاب', 'meaning': 'بہت عطا کرنے والا'},
  {'arabic': 'الرَّزَّاقُ', 'urdu': 'الرزاق', 'meaning': 'رزق دینے والا'},
  {'arabic': 'الْفَتَّاحُ', 'urdu': 'الفتاح', 'meaning': 'کھولنے والا'},
  {'arabic': 'الْعَلِيمُ', 'urdu': 'العلیم', 'meaning': 'سب جاننے والا'},
  {'arabic': 'الْقَابِضُ', 'urdu': 'القابض', 'meaning': 'تنگی کرنے والا'},
  {'arabic': 'الْبَاسِطُ', 'urdu': 'الباسط', 'meaning': 'کشادگی دینے والا'},
  {'arabic': 'الْخَافِضُ', 'urdu': 'الخافض', 'meaning': 'پست کرنے والا'},
  {'arabic': 'الرَّافِعُ', 'urdu': 'الرافع', 'meaning': 'بلند کرنے والا'},
  {'arabic': 'الْمُعِزُّ', 'urdu': 'المعز', 'meaning': 'عزت دینے والا'},
  {'arabic': 'الْمُذِلُّ', 'urdu': 'المذل', 'meaning': 'ذلیل کرنے والا'},
  {'arabic': 'السَّمِيعُ', 'urdu': 'السمیع', 'meaning': 'سننے والا'},
  {'arabic': 'الْبَصِيرُ', 'urdu': 'البصیر', 'meaning': 'دیکھنے والا'},
  {'arabic': 'الْحَكَمُ', 'urdu': 'الحکم', 'meaning': 'فیصلہ کرنے والا'},
  {'arabic': 'الْعَدْلُ', 'urdu': 'العدل', 'meaning': 'انصاف کرنے والا'},
  {'arabic': 'اللَّطِيفُ', 'urdu': 'اللطیف', 'meaning': 'مہربان'},
  {'arabic': 'الْخَبِيرُ', 'urdu': 'الخبیر', 'meaning': 'باخبر'},
  {'arabic': 'الْحَلِيمُ', 'urdu': 'الحلیم', 'meaning': 'بردبار'},
  {'arabic': 'الْعَظِيمُ', 'urdu': 'العظیم', 'meaning': 'بڑا'},
  {'arabic': 'الْغَفُورُ', 'urdu': 'الغفور', 'meaning': 'بخشنے والا'},
  {'arabic': 'الشَّكُورُ', 'urdu': 'الشکور', 'meaning': 'قدر کرنے والا'},
  {'arabic': 'الْعَلِيُّ', 'urdu': 'العلی', 'meaning': 'بلند'},
  {'arabic': 'الْكَبِيرُ', 'urdu': 'الکبیر', 'meaning': 'بہت بڑا'},
  {'arabic': 'الْحَفِيظُ', 'urdu': 'الحفیظ', 'meaning': 'حفاظت کرنے والا'},
  {'arabic': 'الْمُقِيتُ', 'urdu': 'المقیت', 'meaning': 'روزی دینے والا'},
  {'arabic': 'الْحَسِيبُ', 'urdu': 'الحسیب', 'meaning': 'حساب لینے والا'},
  {'arabic': 'الْجَلِيلُ', 'urdu': 'الجلیل', 'meaning': 'عظمت والا'},
  {'arabic': 'الْكَرِيمُ', 'urdu': 'الکریم', 'meaning': 'کرم کرنے والا'},
  {'arabic': 'الرَّقِيبُ', 'urdu': 'الرقیب', 'meaning': 'نگہداشت کرنے والا'},
  {'arabic': 'الْمُجِيبُ', 'urdu': 'المجیب', 'meaning': 'دعا قبول کرنے والا'},
  {'arabic': 'الْوَاسِعُ', 'urdu': 'الواسع', 'meaning': 'کشادگی والا'},
  {'arabic': 'الْحَكِيمُ', 'urdu': 'الحکیم', 'meaning': 'حکمت والا'},
  {'arabic': 'الْوَدُودُ', 'urdu': 'الودود', 'meaning': 'محبت کرنے والا'},
  {'arabic': 'الْمَجِيدُ', 'urdu': 'المجید', 'meaning': 'بزرگی والا'},
  {'arabic': 'الْبَاعِثُ', 'urdu': 'الباعث', 'meaning': 'اٹھانے والا'},
  {'arabic': 'الشَّهِيدُ', 'urdu': 'الشہید', 'meaning': 'گواہ'},
  {'arabic': 'الْحَقُّ', 'urdu': 'الحق', 'meaning': 'سچا'},
  {'arabic': 'الْوَكِيلُ', 'urdu': 'الوکیل', 'meaning': 'کارساز'},
  {'arabic': 'الْقَوِيُّ', 'urdu': 'القوی', 'meaning': 'طاقتور'},
  {'arabic': 'الْمَتِينُ', 'urdu': 'المتین', 'meaning': 'مضبوط'},
  {'arabic': 'الْوَلِيُّ', 'urdu': 'الولی', 'meaning': 'مددگار'},
  {'arabic': 'الْحَمِيدُ', 'urdu': 'الحمید', 'meaning': 'تعریف والا'},
  {'arabic': 'الْمُحْصِي', 'urdu': 'المحسی', 'meaning': 'گننے والا'},
  {'arabic': 'الْمُبْدِئُ', 'urdu': 'المبدئ', 'meaning': 'شروع کرنے والا'},
  {'arabic': 'الْمُعِيدُ', 'urdu': 'المعید', 'meaning': 'لوٹانے والا'},
  {'arabic': 'الْمُحْيِي', 'urdu': 'المحیی', 'meaning': 'زندگی دینے والا'},
  {'arabic': 'الْمُمِيتُ', 'urdu': 'الممیت', 'meaning': 'موت دینے والا'},
  {'arabic': 'الْحَيُّ', 'urdu': 'الحی', 'meaning': 'زندہ'},
  {'arabic': 'الْقَيُّومُ', 'urdu': 'القیوم', 'meaning': 'قائم رکھنے والا'},
  {'arabic': 'الْوَاجِدُ', 'urdu': 'الواجد', 'meaning': 'پانے والا'},
  {'arabic': 'الْمَاجِدُ', 'urdu': 'الماجد', 'meaning': 'بزرگ'},
  {'arabic': 'الْوَاحِدُ', 'urdu': 'الواحد', 'meaning': 'ایک'},
  {'arabic': 'الْأَحَدُ', 'urdu': 'الاحد', 'meaning': 'بے نظیر'},
  {'arabic': 'الصَّمَدُ', 'urdu': 'الصمد', 'meaning': 'بے نیاز'},
  {'arabic': 'الْقَادِرُ', 'urdu': 'القادر', 'meaning': 'طاقت والا'},
  {'arabic': 'الْمُقْتَدِرُ', 'urdu': 'المقتدر', 'meaning': 'قدرت والا'},
  {'arabic': 'الْمُقَدِّمُ', 'urdu': 'المقدم', 'meaning': 'آگے کرنے والا'},
  {'arabic': 'الْمُؤَخِّرُ', 'urdu': 'المؤخر', 'meaning': 'پیچھے کرنے والا'},
  {'arabic': 'الْأَوَّلُ', 'urdu': 'الاول', 'meaning': 'پہلا'},
  {'arabic': 'الْآخِرُ', 'urdu': 'الآخر', 'meaning': 'آخری'},
  {'arabic': 'الظَّاهِرُ', 'urdu': 'الظاہر', 'meaning': 'ظاہر'},
  {'arabic': 'الْبَاطِنُ', 'urdu': 'الباطن', 'meaning': 'پوشیدہ'},
  {'arabic': 'الْوَالِي', 'urdu': 'الوالی', 'meaning': 'حاکم'},
  {'arabic': 'الْمُتَعَالِي', 'urdu': 'المتعالی', 'meaning': 'بلند تر'},
  {'arabic': 'الْبَرُّ', 'urdu': 'البر', 'meaning': 'نیکی کرنے والا'},
  {'arabic': 'التَّوَّابُ', 'urdu': 'التواب', 'meaning': 'توبہ قبول کرنے والا'},
  {'arabic': 'الْمُنْتَقِمُ', 'urdu': 'المنتقم', 'meaning': 'بدلہ لینے والا'},
  {'arabic': 'الْعَفُوُّ', 'urdu': 'العفو', 'meaning': 'معاف کرنے والا'},
  {'arabic': 'الرَّءُوفُ', 'urdu': 'الرؤف', 'meaning': 'شفقت کرنے والا'},
  {'arabic': 'مَالِكُ الْمُلْكِ', 'urdu': 'مالک الملک', 'meaning': 'بادشاہی کا مالک'},
  {'arabic': 'ذُو الْجَلَالِ وَالْإِكْرَامِ', 'urdu': 'ذوالجلال والاکرام', 'meaning': 'عظمت والا'},
  {'arabic': 'الْمُقْسِطُ', 'urdu': 'المقسط', 'meaning': 'انصاف کرنے والا'},
  {'arabic': 'الْجَامِعُ', 'urdu': 'الجامع', 'meaning': 'جمع کرنے والا'},
  {'arabic': 'الْغَنِيُّ', 'urdu': 'الغنی', 'meaning': 'مالک'},
  {'arabic': 'الْمُغْنِي', 'urdu': 'المغني', 'meaning': 'مالدار کرنے والا'},
  {'arabic': 'الْمَانِعُ', 'urdu': 'المانع', 'meaning': 'روکنے والا'},
  {'arabic': 'الضَّارُّ', 'urdu': 'الضار', 'meaning': 'تکلیف دینے والا'},
  {'arabic': 'النَّافِعُ', 'urdu': 'النافع', 'meaning': 'نفع دینے والا'},
  {'arabic': 'النُّورُ', 'urdu': 'النور', 'meaning': 'روشنی'},
  {'arabic': 'الْهَادِي', 'urdu': 'الہادی', 'meaning': 'ہدایت دینے والا'},
  {'arabic': 'الْبَدِيعُ', 'urdu': 'البدیع', 'meaning': 'نیا پیدا کرنے والا'},
  {'arabic': 'الْبَاقِي', 'urdu': 'الباقی', 'meaning': 'ہمیشہ رہنے والا'},
  {'arabic': 'الْوَارِثُ', 'urdu': 'الوارث', 'meaning': 'وارث'},
  {'arabic': 'الرَّشِيدُ', 'urdu': 'الرشید', 'meaning': 'راہ دکھانے والا'},
  {'arabic': 'الصَّبُورُ', 'urdu': 'الصبور', 'meaning': 'صبر کرنے والا'},
];
// ============================================================
// DAILY PROBLEMS PAGE — روز مرہ مسائل اور ان کا حل
// ============================================================
class DailyProblemsPage extends StatelessWidget {
  const DailyProblemsPage({super.key});

  static const List<Map<String, dynamic>> problems = [
    {
      'title': 'پریشانی اور ٹینشن',
      'icon': Icons.sentiment_dissatisfied,
      'color': Color(0xFFC0392B),
      'ayah': 'إِنَّ مَعَ الْعُسْرِ يُسْرًا',
      'ayah_urdu': 'بے شک مشکل کے ساتھ آسانی ہے۔',
      'ayah_ref': 'سورۃ الشرح: 6',
      'hadith': 'جو شخص صبح اٹھے اور وہ امن میں ہو، جسم تندرست ہو، اور دن کا کھانا موجود ہو، تو گویا اسے پوری دنیا مل گئی۔',
      'hadith_ref': 'ترمذی: 2346',
    },
    {
      'title': 'رزق اور کاروبار',
      'icon': Icons.business_center,
      'color': Color(0xFFD4AF37),
      'ayah': 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ',
      'ayah_urdu': 'اور جو اللہ پر بھروسہ کرے، تو وہ اس کے لیے کافی ہے۔',
      'ayah_ref': 'سورۃ الطلاق: 3',
      'hadith': 'جس نے استغفار کو لازم کر لیا، اللہ اس کے ہر غم سے نجات کا راستہ نکال دے گا اور اسے وہاں سے رزق دے گا جہاں سے اسے گمان بھی نہ ہوگا۔',
      'hadith_ref': 'ابو داؤد: 1518',
    },
    {
      'title': 'شادی اور ازدواجی مسائل',
      'icon': Icons.family_restroom,
      'color': Color(0xFF8E44AD),
      'ayah': 'وَمِنْ آيَاتِهِ أَنْ خَلَقَ لَكُم مِّنْ أَنفُسِكُمْ أَزْوَاجًا لِّتَسْكُنُوا إِلَيْهَا وَجَعَلَ بَيْنَكُم مَّوَدَّةً وَرَحْمَةً',
      'ayah_urdu': 'اور اس کی نشانیوں میں سے یہ ہے کہ اس نے تمہارے لیے تمہاری ہی جنس سے جوڑے پیدا کیے تاکہ تم ان سے سکون حاصل کرو، اور اس نے تمہارے درمیان محبت اور رحمت رکھ دی۔',
      'ayah_ref': 'سورۃ الروم: 21',
      'hadith': 'عورتوں کے ساتھ اچھا سلوک کرو، کیونکہ وہ تمہاری ماں، بہن، بیٹیوں کی طرح ہیں۔',
      'hadith_ref': 'صحیح بخاری: 5186',
    },
    {
      'title': 'اولاد کی نعمت',
      'icon': Icons.child_care,
      'color': Color(0xFF2980B9),
      'ayah': 'رَبِّ هَبْ لِي مِنَ الصَّالِحِينَ',
      'ayah_urdu': 'اے میرے رب! مجھے نیک اولاد عطا فرما۔',
      'ayah_ref': 'سورۃ الصافات: 100',
      'hadith': 'بے شک اللہ تعالیٰ اپنے بندوں پر اس طرح مہربان ہے جیسے ایک ماں اپنی اولاد پر مہربان ہوتی ہے۔',
      'hadith_ref': 'صحیح بخاری: 5999',
    },
    {
      'title': 'بیماری اور شفا',
      'icon': Icons.local_hospital,
      'color': Color(0xFFE67E22),
      'ayah': 'وَإِذَا مَرِضْتُ فَهُوَ يَشْفِينِ',
      'ayah_urdu': 'اور جب میں بیمار ہوتا ہوں تو وہی مجھے شفا دیتا ہے۔',
      'ayah_ref': 'سورۃ الشعراء: 80',
      'hadith': 'اللہ نے جو بیماری بھی نازل کی ہے، اس کی دوا بھی نازل کی ہے۔',
      'hadith_ref': 'صحیح بخاری: 5678',
    },
    {
      'title': 'دشمن اور حسد',
      'icon': Icons.security,
      'color': Color(0xFF2E4053),
      'ayah': 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      'ayah_urdu': 'اللہ ہمیں کافی ہے اور وہ بہترین کارساز ہے۔',
      'ayah_ref': 'سورۃ آل عمران: 173',
      'hadith': 'جو شخص صبح و شام تین بار "بسم اللہ الذی لا یضر مع اسمہ شیء فی الارض ولا فی السماء وہو السمیع العلیم" پڑھے، اسے کوئی چیز نقصان نہیں پہنچا سکتی۔',
      'hadith_ref': 'ابو داؤد: 5088',
    },
    {
      'title': 'غم اور فکر',
      'icon': Icons.psychology_alt,
      'color': Color(0xFF1B4F72),
      'ayah': 'وَلَقَدْ نَعْلَمُ أَنَّكَ يَضِيقُ صَدْرُكَ بِمَا يَقُولُونَ',
      'ayah_urdu': 'اور ہم خوب جانتے ہیں کہ جو باتیں یہ لوگ کرتے ہیں، ان سے آپ کا دل تنگ ہوتا ہے۔',
      'ayah_ref': 'سورۃ الحجر: 97',
      'hadith': 'اے اللہ! میں تیری پناہ مانگتا ہوں فکر اور غم سے، کمزوری اور سستی سے، کنجوسی اور بزدلی سے۔',
      'hadith_ref': 'صحیح بخاری: 6369',
    },
    {
      'title': 'گناہوں کی معافی',
      'icon': Icons.self_improvement,
      'color': Color(0xFF6C3483),
      'ayah': 'قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ',
      'ayah_urdu': 'کہہ دو اے میرے بندو! جنہوں نے اپنی جانوں پر زیادتی کی ہے، اللہ کی رحمت سے مایوس نہ ہو۔',
      'ayah_ref': 'سورۃ الزمر: 53',
      'hadith': 'اللہ تعالیٰ فرماتا ہے: اے ابن آدم! جب تک تو مجھے پکارتا رہے گا اور مجھ سے امید رکھے گا، میں تجھے بخش دیتا رہوں گا۔',
      'hadith_ref': 'ترمذی: 3540',
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
            'روز مرہ مسائل اور ان کا حل',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: problems.length,
          itemBuilder: (context, index) {
            final problem = problems[index];
            return _ProblemTile(problem: problem);
          },
        ),
      ),
    );
  }
}

class _ProblemTile extends StatelessWidget {
  final Map<String, dynamic> problem;

  const _ProblemTile({required this.problem});

  @override
  Widget build(BuildContext context) {
    final Color color = problem['color'];
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProblemDetailPage(problem: problem),
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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(problem['icon'], color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  problem['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Icon(Icons.arrow_back_ios, color: color, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PROBLEM DETAIL PAGE — مسئلہ کی تفصیل
// ============================================================
class ProblemDetailPage extends StatelessWidget {
  final Map<String, dynamic> problem;

  const ProblemDetailPage({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    final Color color = problem['color'];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: color,
          title: Text(
            problem['title'],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // آیت کا کارڈ
              _buildTextCard(
                title: 'قرآن پاک کی روشنی میں',
                arabic: problem['ayah'],
                urdu: problem['ayah_urdu'],
                ref: problem['ayah_ref'],
                icon: Icons.menu_book,
                color: AppColors.deepGreen,
              ),
              const SizedBox(height: 16),
              // حدیث کا کارڈ
              _buildTextCard(
                title: 'حدیث مبارکہ کی روشنی میں',
                arabic: '',
                urdu: problem['hadith'],
                ref: problem['hadith_ref'],
                icon: Icons.auto_stories,
                color: AppColors.gold,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextCard({
    required String title,
    required String arabic,
    required String urdu,
    required String ref,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const Divider(height: 30),
          if (arabic.isNotEmpty) ...[
            Text(
              arabic,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontFamily: 'serif', height: 2.0, color: AppColors.darkText),
            ),
            const SizedBox(height: 15),
          ],
          Text(
            urdu,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.6),
          ),
          const SizedBox(height: 15),
          Text(
            'حوالہ: $ref',
            style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
