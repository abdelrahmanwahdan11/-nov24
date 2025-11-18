import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class ReferralsScreen extends StatefulWidget {
  const ReferralsScreen({super.key});

  @override
  State<ReferralsScreen> createState() => _ReferralsScreenState();
}

class _ReferralsScreenState extends State<ReferralsScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('referrals'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: scope.engagementController.referralCode,
              builder: (_, code, __) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(loc.t('invite_friends'),
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(loc.t('share_code')),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                                ),
                                child: Text(code, style: Theme.of(context).textTheme.titleLarge),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: code));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(loc.t('copied'))),
                                );
                              },
                              icon: const Icon(Icons.copy_outlined),
                              tooltip: loc.t('copy_code'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(loc.t('active_coupons'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: scope.engagementController.coupons,
                builder: (_, coupons, __) {
                  return ListView.separated(
                    itemCount: coupons.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) {
                      final coupon = coupons[index];
                      final isExpired = coupon.expiresOn.isBefore(DateTime.now());
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary.withOpacity(0.12),
                            child: Text('${coupon.discountPercent}%'),
                          ),
                          title: Text(coupon.code),
                          subtitle: Text('${coupon.description}\n${loc.t('expires')}: ${coupon.expiresOn.toLocal().toString().split(' ').first}'),
                          isThreeLine: true,
                          trailing: ElevatedButton(
                            onPressed: isExpired
                                ? null
                                : () {
                                    scope.engagementController.applyCoupon(coupon.code);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(loc.t('coupon_applied'))),
                                    );
                                  },
                            child: Text(coupon.isApplied ? loc.t('applied') : loc.t('apply')),
                          ),
                        ),
                      );
                    },
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
