import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/widgets/address_tile.dart';
import '../../core/models/address.dart';
import '../../main.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late CartController cartController;
  late ValueNotifier<List<Address>> addresses;
  Address? selectedAddress;
  String paymentMethod = 'visa';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = AppScope.of(context);
    cartController = scope.cartController;
    addresses = scope.engagementController.addresses;
    selectedAddress ??= addresses.value.isNotEmpty ? addresses.value.first : null;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('checkout'))),
      body: ValueListenableBuilder(
        valueListenable: addresses,
        builder: (_, list, __) {
          return StreamBuilder(
            stream: cartController.cartItemsStream,
            builder: (_, snapshot) {
              final items = snapshot.data ?? const [];
              return items.isEmpty
                  ? _EmptyCartPlaceholder(loc: loc)
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _SectionTitle(text: loc.t('select_address')),
                        const SizedBox(height: 8),
                        ...list.map(
                          (address) => Card(
                            child: AddressTile(
                              address: address,
                              selected: selectedAddress == address,
                              onTap: () => setState(() => selectedAddress = address),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () => _showAddAddressDialog(context, loc),
                            icon: const Icon(Icons.add_location_alt_outlined),
                            label: Text(loc.t('add_new_address')),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _SectionTitle(text: loc.t('choose_payment')),
                        Card(
                          child: Column(
                            children: [
                              RadioListTile<String>(
                                value: 'visa',
                                groupValue: paymentMethod,
                                onChanged: (v) => setState(() => paymentMethod = v!),
                                title: Text(loc.t('payment_visa')),
                                subtitle: const Text('•••• 4256'),
                              ),
                              RadioListTile<String>(
                                value: 'master',
                                groupValue: paymentMethod,
                                onChanged: (v) => setState(() => paymentMethod = v!),
                                title: Text(loc.t('payment_mastercard')),
                                subtitle: const Text('•••• 9812'),
                              ),
                              RadioListTile<String>(
                                value: 'apple',
                                groupValue: paymentMethod,
                                onChanged: (v) => setState(() => paymentMethod = v!),
                                title: Text(loc.t('payment_apple_pay')),
                              ),
                              RadioListTile<String>(
                                value: 'cash',
                                groupValue: paymentMethod,
                                onChanged: (v) => setState(() => paymentMethod = v!),
                                title: Text(loc.t('payment_cash')),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _SectionTitle(text: loc.t('order_summary')),
                        Card(
                          child: Column(
                            children: [
                              ...items.map(
                                (item) => ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item.product.imageUrl,
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(item.product.nameEn),
                                  subtitle:
                                      Text('x${item.quantity} • ${item.product.size ?? ''}'.trim()),
                                  trailing: Text(
                                    '${loc.t('currency')} ${item.total.toStringAsFixed(2)}',
                                  ),
                                ),
                              ),
                              StreamBuilder(
                                stream: cartController.cartSummaryStream,
                                builder: (_, summarySnap) {
                                  final summary = summarySnap.data;
                                  if (summary == null) return const SizedBox();
                                  return Column(
                                    children: [
                                      const Divider(),
                                      _SummaryRow(
                                        label: loc.t('subtotal'),
                                        value: summary.subtotal,
                                        currency: loc.t('currency'),
                                      ),
                                      _SummaryRow(
                                        label: loc.t('delivery_fee'),
                                        value: summary.delivery,
                                        currency: loc.t('currency'),
                                      ),
                                      _SummaryRow(
                                        label: loc.t('total'),
                                        value: summary.total,
                                        currency: loc.t('currency'),
                                        isBold: true,
                                      ),
                                      const SizedBox(height: 12),
                                      ElevatedButton.icon(
                                        onPressed: () => _submitOrder(context, loc),
                                        icon: const Icon(Icons.lock_outline),
                                        label: Text(loc.t('pay_now')),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          );
        },
      ),
    );
  }

  Future<void> _showAddAddressDialog(BuildContext context, AppLocalizations loc) async {
    final titleController = TextEditingController();
    final subtitleController = TextEditingController();
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(loc.t('new_address')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: loc.t('label')),
            ),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(labelText: loc.t('details')),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(loc.t('cancel'))),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isEmpty || subtitleController.text.isEmpty) return;
              addresses.value = [
                ...addresses.value,
                Address(
                  title: titleController.text,
                  subtitle: subtitleController.text,
                  mapImageUrl:
                      'https://images.pexels.com/photos/1117452/pexels-photo-1117452.jpeg?auto=compress&cs=tinysrgb&w=800',
                ),
              ];
              Navigator.pop(context);
            },
            child: Text(loc.t('save')),
          ),
        ],
      ),
    );
    setState(() {
      selectedAddress = addresses.value.isNotEmpty ? addresses.value.last : selectedAddress;
    });
  }

  Future<void> _submitOrder(BuildContext context, AppLocalizations loc) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(loc.t('order_success_title')),
        content: Text(loc.t('order_success_body')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.t('close')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cartController.clear();
              Navigator.pop(context);
            },
            child: Text(loc.t('continue_shopping')),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final String currency;
  final bool isBold;
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.currency,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('$currency ${value.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}

class _EmptyCartPlaceholder extends StatelessWidget {
  final AppLocalizations loc;
  const _EmptyCartPlaceholder({required this.loc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 64),
            const SizedBox(height: 12),
            Text(loc.t('empty_cart'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              loc.t('pull_refresh'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
