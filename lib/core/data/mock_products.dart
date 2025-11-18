import '../models/product.dart';

final mockProducts = <Product>[
  Product(
    id: 'p1',
    nameEn: 'Rose Glow Serum',
    nameAr: 'سيروم توهج الورد',
    price: 35.5,
    size: '50ml',
    rating: 4.8,
    reviewsCount: 220,
    category: 'Face',
    imageUrl:
        'https://images.pexels.com/photos/965989/pexels-photo-965989.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'Brightens and hydrates with natural rose oils.',
    descriptionShortAr: 'يضيء ويرطب بتركيبة زيت الورد الطبيعية.',
    descriptionLongEn:
        'Our Rose Glow Serum blends hyaluronic acid with rose oil to deeply hydrate and bring a natural glow.',
    descriptionLongAr:
        'يمزج سيروم توهج الورد حمض الهيالورونيك مع زيت الورد لترطيب عميق ولمسة إشراق طبيعية.',
    tags: ['hydration', 'brightening', 'vegan'],
    isBestSeller: true,
    isNew: false,
    skinType: 'Dry',
  ),
  Product(
    id: 'p2',
    nameEn: 'Cocoa Body Butter',
    nameAr: 'زبدة جسم بالكاكاو',
    price: 24.0,
    size: '200ml',
    rating: 4.6,
    reviewsCount: 180,
    category: 'Body',
    imageUrl:
        'https://images.pexels.com/photos/3737592/pexels-photo-3737592.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'Silky butter for smooth and nourished skin.',
    descriptionShortAr: 'زبدة حريرية لبشرة ناعمة ومغذية.',
    descriptionLongEn:
        'Cocoa Body Butter melts on contact, sealing in moisture while leaving a soft, sweet aroma.',
    descriptionLongAr:
        'تذوب زبدة الجسم بالكاكاو عند الملامسة لتغلق الرطوبة مع ترك رائحة حلوة ناعمة.',
    tags: ['body', 'nourishing', 'winter'],
    isBestSeller: true,
    isNew: true,
    skinType: 'Normal',
  ),
  Product(
    id: 'p3',
    nameEn: 'Matcha Clay Mask',
    nameAr: 'قناع الطين بالشاي الأخضر',
    price: 29.9,
    size: '120ml',
    rating: 4.4,
    reviewsCount: 96,
    category: 'Face',
    imageUrl:
        'https://images.pexels.com/photos/3865794/pexels-photo-3865794.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'Detoxifying clay mask with matcha antioxidants.',
    descriptionShortAr: 'قناع طين مزيل للسموم مع مضادات أكسدة الماتشا.',
    descriptionLongEn:
        'Clear pores and calm redness with matcha, kaolin, and soothing chamomile extracts.',
    descriptionLongAr:
        'ينظف المسام ويهدئ الاحمرار بالماتشا والكاولين ومستخلصات البابونج المهدئة.',
    tags: ['detox', 'mask', 'calming'],
    isBestSeller: false,
    isNew: true,
    skinType: 'Oily',
  ),
  Product(
    id: 'p4',
    nameEn: 'Argan Hair Oil',
    nameAr: 'زيت الأرغان للشعر',
    price: 18.0,
    size: '90ml',
    rating: 4.7,
    reviewsCount: 310,
    category: 'Hair',
    imageUrl:
        'https://images.pexels.com/photos/3738341/pexels-photo-3738341.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'Adds shine and repairs split ends.',
    descriptionShortAr: 'يضيف لمعاناً ويعالج التقصف.',
    descriptionLongEn:
        'Cold-pressed argan oil enriched with vitamin E to protect and nourish hair strands.',
    descriptionLongAr:
        'زيت أرغان معصور على البارد غني بفيتامين E لحماية وتغذية خصلات الشعر.',
    tags: ['hair', 'repair', 'shine'],
    isBestSeller: true,
    isNew: false,
    skinType: 'All',
  ),
  Product(
    id: 'p5',
    nameEn: 'Niacinamide Essence',
    nameAr: 'إسنس النياسيناميد',
    price: 27.0,
    size: '100ml',
    rating: 4.5,
    reviewsCount: 145,
    category: 'Face',
    imageUrl:
        'https://images.pexels.com/photos/3735633/pexels-photo-3735633.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'Lightweight essence to smooth texture and refine pores.',
    descriptionShortAr: 'إسنس خفيف ينعم الملمس ويصغر المسام.',
    descriptionLongEn:
        'Balances oil, soothes redness, and layers well before serums for combination skin.',
    descriptionLongAr:
        'يوزن الدهون ويهدئ الاحمرار ويتماشى مع السيرومات للبشرة المختلطة.',
    tags: ['pores', 'balance', 'lightweight'],
    isBestSeller: false,
    isNew: true,
    skinType: 'Combination',
  ),
  Product(
    id: 'p6',
    nameEn: 'Ceramide Cloud Cream',
    nameAr: 'كريم السيراميد السحابي',
    price: 34.0,
    size: '60ml',
    rating: 4.9,
    reviewsCount: 260,
    category: 'Face',
    imageUrl:
        'https://images.pexels.com/photos/853843/pexels-photo-853843.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'Pillow-soft moisturizer that repairs the skin barrier.',
    descriptionShortAr: 'مرطب ناعم كالسحاب يصلح حاجز البشرة.',
    descriptionLongEn:
        'Packed with ceramides and peptides to keep moisture locked in through the night.',
    descriptionLongAr:
        'محمل بالسيراميد والببتيدات ليحفظ الرطوبة حتى الصباح.',
    tags: ['barrier', 'peptides', 'night'],
    isBestSeller: true,
    isNew: false,
    skinType: 'Dry',
  ),
  Product(
    id: 'p7',
    nameEn: 'Mineral SPF Veil 50',
    nameAr: 'واقي شمس معدني ٥٠',
    price: 22.0,
    size: '75ml',
    rating: 4.3,
    reviewsCount: 88,
    category: 'Face',
    imageUrl:
        'https://images.pexels.com/photos/672425/pexels-photo-672425.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'UVA/UVB protection with a soft matte finish.',
    descriptionShortAr: 'حماية من الأشعة مع لمسة مطفية خفيفة.',
    descriptionLongEn:
        'Non-nano zinc formula that blends quickly and sits well under makeup.',
    descriptionLongAr:
        'تركيبة زنك غير نانوية تمتزج سريعاً وتناسب المكياج.',
    tags: ['spf', 'mineral', 'daily'],
    isBestSeller: false,
    isNew: true,
    skinType: 'Sensitive',
  ),
  Product(
    id: 'p8',
    nameEn: 'Aloe Recovery Gel',
    nameAr: 'جل الألوفيرا المهدئ',
    price: 19.5,
    size: '150ml',
    rating: 4.2,
    reviewsCount: 132,
    category: 'Body',
    imageUrl:
        'https://images.pexels.com/photos/3735641/pexels-photo-3735641.jpeg?auto=compress&cs=tinysrgb&w=800',
    descriptionShortEn: 'Cooling gel for post-sun relief and hydration.',
    descriptionShortAr: 'جل مبرد لتهدئة البشرة بعد الشمس وترطيبها.',
    descriptionLongEn:
        'Lightweight aloe and panthenol blend that absorbs instantly without stickiness.',
    descriptionLongAr:
        'مزيج الألوفيرا والبانثينول يمتص فوراً بدون لزوجة.',
    tags: ['soothing', 'cooling', 'after-sun'],
    isBestSeller: false,
    isNew: false,
    skinType: 'All',
  ),
];
