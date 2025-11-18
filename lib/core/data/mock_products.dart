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
];
