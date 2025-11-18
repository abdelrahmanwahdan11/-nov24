import '../models/recall_alert.dart';

final List<RecallAlert> mockRecalls = [
  RecallAlert(
    id: 'recall-toner',
    productName: 'Hydra Mist Toner',
    lotCode: 'HM2304A',
    issue: 'Possible pump leakage on warm shelves.',
    action: 'Inspect the pump. If leaking, stop use and request replacement.',
    severity: 'medium',
    expiresAt: DateTime.now().add(const Duration(days: 20)),
    imageUrl:
        'https://images.pexels.com/photos/3738379/pexels-photo-3738379.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  RecallAlert(
    id: 'recall-mask',
    productName: 'Calm Barrier Mask',
    lotCode: 'CBM2309C',
    issue: 'Label misprint on usage frequency.',
    action: 'Use up to 2x weekly. Updated labels shipping soon.',
    severity: 'low',
    expiresAt: DateTime.now().add(const Duration(days: 45)),
    imageUrl:
        'https://images.pexels.com/photos/3735646/pexels-photo-3735646.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
  RecallAlert(
    id: 'recall-spf',
    productName: 'Daily Mineral SPF',
    lotCode: 'DMSF2310',
    issue: 'Batch underfills detected.',
    action: 'Check weight; if below 40ml, flag for replacement.',
    severity: 'high',
    expiresAt: DateTime.now().add(const Duration(days: 10)),
    imageUrl:
        'https://images.pexels.com/photos/7290166/pexels-photo-7290166.jpeg?auto=compress&cs=tinysrgb&w=800',
  ),
];
