import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class CouponCenterScreen extends StatelessWidget {
  const CouponCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('coupon_center'))),
      body: ValueListenableBuilder(
        valueListenable: scope.engagementController.coupons,
        builder: (_, coupons, __) {
          if (coupons.isEmpty) {
            return Center(child: Text(loc.t('no_coupons')));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: coupons.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              final coupon = coupons[index];
              final expires = '${loc.t('expires_on')} '
                  '${coupon.expiresOn.month}/${coupon.expiresOn.day}';
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(label: Text('${coupon.discountPercent}%')),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              coupon.code,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            onPressed: () => scope.engagementController.toggleCoupon(coupon.code),
                            icon: Icon(
                              coupon.isApplied ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: coupon.isApplied
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).hintColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        coupon.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        expires,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).hintColor),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(coupon.isApplied ? loc.t('applied') : loc.t('tap_apply')),
                          ElevatedButton(
                            onPressed: () => scope.engagementController.toggleCoupon(coupon.code),
                            child: Text(
                              coupon.isApplied ? loc.t('remove') : loc.t('apply_coupon'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
