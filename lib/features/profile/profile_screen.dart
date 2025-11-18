import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/routing/app_router.dart';
import '../../main.dart';
import 'challenges_screen.dart';
import 'referrals_screen.dart';
import 'skin_report_screen.dart';
import 'subscriptions_screen.dart';
import 'settings_screen.dart';
import 'order_history_screen.dart';
import 'help_center_screen.dart';
import 'about_app_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    return ValueListenableBuilder(
      valueListenable: scope.authController.user,
      builder: (_, user, __) {
        final avatar = user?.avatarUrl ??
            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=800';
        final name = user?.name ?? loc.t('guest');
        final email = user?.email ?? 'guest@skin.app';
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(avatar), radius: 32),
                const SizedBox(width: 12),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(name), Text(email)])
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.bolt_outlined),
              title: Text(loc.t('skin_report')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SkinReportScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome_motion_outlined),
              title: Text(loc.t('challenges')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChallengesScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.monitor_heart_outlined),
              title: Text(loc.t('wellness_dashboard')),
              onTap: () => Navigator.pushNamed(context, AppRouter.wellnessDashboard),
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard_outlined),
              title: Text(loc.t('rewards')),
              onTap: () => Navigator.pushNamed(context, AppRouter.rewards),
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_number_outlined),
              title: Text(loc.t('coupon_center')),
              onTap: () => Navigator.pushNamed(context, AppRouter.couponCenter),
            ),
            ListTile(
              leading: const Icon(Icons.savings_outlined),
              title: Text(loc.t('budget_planner')),
              onTap: () => Navigator.pushNamed(context, AppRouter.budgetPlanner),
            ),
            ListTile(
              leading: const Icon(Icons.forum_outlined),
              title: Text(loc.t('coach_qna')),
              onTap: () => Navigator.pushNamed(context, AppRouter.coachQna),
            ),
            ListTile(
              leading: const Icon(Icons.flight_takeoff_outlined),
              title: Text(loc.t('travel_mode')),
              onTap: () => Navigator.pushNamed(context, AppRouter.travelMode),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(loc.t('glow_journal')),
              onTap: () => Navigator.pushNamed(context, AppRouter.journal),
            ),
            ListTile(
              leading: const Icon(Icons.edit_note_outlined),
              title: Text(loc.t('skin_diary')),
              onTap: () => Navigator.pushNamed(context, AppRouter.diary),
            ),
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: Text(loc.t('skin_goals')),
              onTap: () => Navigator.pushNamed(context, AppRouter.goals),
            ),
            ListTile(
              leading: const Icon(Icons.video_call_outlined),
              title: Text(loc.t('book_consultation')),
              onTap: () => Navigator.pushNamed(context, AppRouter.consultation),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_none_rounded),
              title: Text(loc.t('notifications')),
              onTap: () => Navigator.pushNamed(context, AppRouter.notifications),
            ),
            ListTile(
              leading: const Icon(Icons.place_outlined),
              title: Text(loc.t('addresses')),
              onTap: () => Navigator.pushNamed(context, AppRouter.addresses),
            ),
            ListTile(
              leading: const Icon(Icons.wallet_giftcard_outlined),
              title: Text(loc.t('referrals')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReferralsScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.autorenew_outlined),
              title: Text(loc.t('subscriptions')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SubscriptionsScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard_outlined),
              title: Text(loc.t('bundles')),
              onTap: () => Navigator.pushNamed(context, AppRouter.bundles),
            ),
            ListTile(
              leading: const Icon(Icons.quiz_outlined),
              title: Text(loc.t('skin_quiz')),
              onTap: () => Navigator.pushNamed(context, AppRouter.quiz),
            ),
            ListTile(
              leading: const Icon(Icons.library_books_outlined),
              title: Text(loc.t('ingredient_library')),
              onTap: () => Navigator.pushNamed(context, AppRouter.ingredientLibrary),
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety_outlined),
              title: Text(loc.t('patch_test')),
              onTap: () => Navigator.pushNamed(context, AppRouter.patchTest),
            ),
            ListTile(
              leading: const Icon(Icons.medical_services_outlined),
              title: Text(loc.t('sos_playbook')),
              onTap: () => Navigator.pushNamed(context, AppRouter.sosPlaybook),
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: Text(loc.t('shelf_life')),
              onTap: () => Navigator.pushNamed(context, AppRouter.shelfLife),
            ),
            ListTile(
              leading: const Icon(Icons.monitor_heart_outlined),
              title: Text(loc.t('skin_health')),
              onTap: () => Navigator.pushNamed(context, AppRouter.skinHealth),
            ),
            ListTile(
              leading: const Icon(Icons.auto_graph_rounded),
              title: Text(loc.t('skin_insights')),
              onTap: () => Navigator.pushNamed(context, AppRouter.skinInsights),
            ),
            ListTile(
              leading: const Icon(Icons.timeline_rounded),
              title: Text(loc.t('wellness_timeline')),
              onTap: () => Navigator.pushNamed(context, AppRouter.wellnessTimeline),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: Text(loc.t('reminders')),
              onTap: () => Navigator.pushNamed(context, AppRouter.reminders),
            ),
            ListTile(
              leading: const Icon(Icons.event_repeat_rounded),
              title: Text(loc.t('routine_planner')),
              onTap: () => Navigator.pushNamed(context, AppRouter.routine),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: Text(loc.t('routine_calendar')),
              onTap: () => Navigator.pushNamed(context, AppRouter.routineCalendar),
            ),
            ListTile(
              leading: const Icon(Icons.task_outlined),
              title: Text(loc.t('care_plan')),
              onTap: () => Navigator.pushNamed(context, AppRouter.carePlan),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: Text(loc.t('orders')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(loc.t('settings')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text(loc.t('help')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(loc.t('about')),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutAppScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(loc.t('logout')),
              onTap: () => scope.authController.logout(),
            ),
          ],
        );
      },
    );
  }
}
