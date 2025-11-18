import '../models/ingredient.dart';

const mockIngredients = [
  Ingredient(
    id: 'ing1',
    nameEn: 'Niacinamide',
    nameAr: 'نياسيناميد',
    summaryEn: 'Balances oil, brightens tone, and soothes redness.',
    summaryAr: 'يوازن الدهون، يوحّد اللون، ويهدئ الاحمرار.',
    benefitsEn: [
      'Helps fade dark spots over time',
      'Refines the look of pores',
      'Supports a healthy barrier',
    ],
    benefitsAr: [
      'يساعد على تخفيف البقع الداكنة تدريجياً',
      'يحسن مظهر المسام',
      'يدعم حاجز البشرة الصحي',
    ],
    cautionEn: 'Start at low percentages if sensitive and pair with moisturizer.',
    cautionAr: 'ابدئي بتركيز منخفض للبشرة الحساسة مع مرطب مرافق.',
    concerns: ['brightening', 'soothing', 'oil_control'],
    imageUrl:
        'https://images.pexels.com/photos/3738367/pexels-photo-3738367.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  Ingredient(
    id: 'ing2',
    nameEn: 'Retinol',
    nameAr: 'ريتينول',
    summaryEn: 'Vitamin A derivative that boosts cell turnover for smoother skin.',
    summaryAr: 'مشتق فيتامين أ يسرّع تجدد الخلايا لبشرة أكثر نعومة.',
    benefitsEn: [
      'Softens fine lines and texture',
      'Encourages clearer-looking pores',
      'Supports collagen over time',
    ],
    benefitsAr: [
      'يخفف الخطوط الرفيعة والملمس غير المتجانس',
      'يشجع على مسام أنقى',
      'يدعم الكولاجين مع الوقت',
    ],
    cautionEn: 'Introduce slowly (1-2x/week), always pair with SPF and moisturizer.',
    cautionAr: 'استخدميه تدريجياً (1-2 مرات أسبوعياً) مع واقي شمس ومرطب.',
    concerns: ['anti_aging', 'texture'],
    imageUrl:
        'https://images.pexels.com/photos/5938645/pexels-photo-5938645.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  Ingredient(
    id: 'ing3',
    nameEn: 'Hyaluronic Acid',
    nameAr: 'حمض الهيالورونيك',
    summaryEn: 'Draws and retains moisture for plump, dewy skin.',
    summaryAr: 'يجذب ويحافظ على الترطيب لبشرة ممتلئة ومشرقة.',
    benefitsEn: [
      'Immediate surface hydration',
      'Comforts tight or dehydrated skin',
      'Layers well with most actives',
    ],
    benefitsAr: [
      'يرطب البشرة فوراً',
      'يريح البشرة المشدودة أو الجافة',
      'يتماشى مع أغلب المواد الفعالة',
    ],
    cautionEn: 'Seal with moisturizer to avoid evaporation in dry climates.',
    cautionAr: 'اختمي بمرطب لتجنب تبخر الماء في الجو الجاف.',
    concerns: ['hydration', 'barrier'],
    imageUrl:
        'https://images.pexels.com/photos/3738368/pexels-photo-3738368.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  Ingredient(
    id: 'ing4',
    nameEn: 'Salicylic Acid',
    nameAr: 'حمض الساليسيليك',
    summaryEn: 'Oil-soluble exfoliant that sweeps inside pores to unclog.',
    summaryAr: 'مقشّر يذوب في الدهون ينظف داخل المسام.',
    benefitsEn: [
      'Targets congestion and blackheads',
      'Helps reduce future breakouts',
      'Smooths uneven texture',
    ],
    benefitsAr: [
      'يستهدف الاحتقان والرؤوس السوداء',
      'يقلل من الحبوب المستقبلية',
      'ينعم الملمس غير المتجانس',
    ],
    cautionEn: 'Avoid over-exfoliating; start 2-3 times per week.',
    cautionAr: 'تجنبي التقشير المفرط؛ ابدئي 2-3 مرات أسبوعياً.',
    concerns: ['acne', 'texture', 'oil_control'],
    imageUrl:
        'https://images.pexels.com/photos/5938574/pexels-photo-5938574.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  Ingredient(
    id: 'ing5',
    nameEn: 'Centella Asiatica',
    nameAr: 'سنتيلا اسياتيكا',
    summaryEn: 'Calms redness and reinforces the skin barrier.',
    summaryAr: 'يهدئ الاحمرار ويقوي حاجز البشرة.',
    benefitsEn: [
      'Soothes post-exfoliation discomfort',
      'Supports barrier recovery',
      'Great for sensitive routines',
    ],
    benefitsAr: [
      'يخفف الانزعاج بعد التقشير',
      'يدعم تعافي الحاجز',
      'مثالي للبشرة الحساسة',
    ],
    cautionEn: 'Layer after actives; patch test if highly sensitive.',
    cautionAr: 'طبقيها بعد المواد الفعالة؛ اختبريها على جزء صغير للبشرة الحساسة جداً.',
    concerns: ['soothing', 'barrier'],
    imageUrl:
        'https://images.pexels.com/photos/3865796/pexels-photo-3865796.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  Ingredient(
    id: 'ing6',
    nameEn: 'Azelaic Acid',
    nameAr: 'حمض الأزيليك',
    summaryEn: 'Multitasking gentle acid for clarity, tone, and calm.',
    summaryAr: 'حمض لطيف متعدد المهام للصفاء وتوحيد اللون والتهدئة.',
    benefitsEn: [
      'Targets redness and visible spots',
      'Supports clearer-looking pores',
      'Works well in AM or PM routines',
    ],
    benefitsAr: [
      'يستهدف الاحمرار والبقع الظاهرة',
      'يدعم صفاء المسام',
      'يعمل صباحاً أو مساءً',
    ],
    cautionEn: 'Pair with moisturizer; reduce use if tingling persists.',
    cautionAr: 'استخدميه مع مرطب؛ خففي الاستخدام إذا استمر الوخز.',
    concerns: ['brightening', 'soothing', 'acne'],
    imageUrl:
        'https://images.pexels.com/photos/7796406/pexels-photo-7796406.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
];
