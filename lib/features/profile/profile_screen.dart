import 'package:flutter/material.dart';
import '../../core/data/mock_user.dart';
import '../../core/localization/app_localizations.dart';
import '../profile/settings_screen.dart';
import '../profile/order_history_screen.dart';
import '../../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final user = mockUser;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl), radius: 32),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(user.name), Text(user.email)])
          ],
        ),
        const SizedBox(height: 16),
        ListTile(
          title: Text(loc.t('orders')),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
          ),
        ),
        ListTile(
          title: Text(loc.t('settings')),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ),
        ),
        ListTile(
          title: Text(loc.t('about')),
          onTap: () => showAboutDialog(context: context, applicationName: loc.t('app_name')),
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () => AppScope.of(context).authController.logout(),
        ),
      ],
    );
  }
}
