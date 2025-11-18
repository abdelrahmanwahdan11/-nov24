import '../models/article.dart';

final mockArticles = <Article>[
  const Article(
    id: 'a1',
    titleEn: 'Layering actives the gentle way',
    titleAr: 'كيفية استخدام المواد الفعالة بلطف',
    summaryEn: 'A dermatologist-inspired routine to combine exfoliants with hydration.',
    summaryAr: 'روتين مستوحى من أطباء الجلد لدمج المقشرات مع الترطيب بأمان.',
    imageUrl:
        'https://images.pexels.com/photos/3738367/pexels-photo-3738367.jpeg?auto=compress&cs=tinysrgb&w=800',
    minutesRead: 4,
    tag: 'Routine',
  ),
  const Article(
    id: 'a2',
    titleEn: 'Night repair rituals to try',
    titleAr: 'طقوس إصلاح البشرة الليلية',
    summaryEn: 'Soothe redness and wake up glowing with these barrier-loving steps.',
    summaryAr: 'اهدئي الاحمرار واستيقظي بإشراقة مع خطوات تدعم الحاجز الواقي.',
    imageUrl:
        'https://images.pexels.com/photos/6621460/pexels-photo-6621460.jpeg?auto=compress&cs=tinysrgb&w=800',
    minutesRead: 3,
    tag: 'Night',
  ),
  const Article(
    id: 'a3',
    titleEn: 'SPF myths to stop believing',
    titleAr: 'خرافات الواقي الشمسي التي يجب التوقف عن تصديقها',
    summaryEn: 'From reapplication timing to indoor protection, here is what matters.',
    summaryAr: 'من توقيت إعادة التطبيق إلى الحماية داخل المنزل، هذه أهم النقاط.',
    imageUrl:
        'https://images.pexels.com/photos/3738345/pexels-photo-3738345.jpeg?auto=compress&cs=tinysrgb&w=800',
    minutesRead: 5,
    tag: 'SPF',
  ),
];
