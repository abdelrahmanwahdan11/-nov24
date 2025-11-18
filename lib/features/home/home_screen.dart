import 'package:flutter/material.dart';
import '../../core/controllers/cart_controller.dart';
import '../../core/controllers/favorites_controller.dart';
import '../../core/controllers/product_controller.dart';
import '../../core/data/mock_products.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/product_card.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/app_skeleton.dart';
import '../../core/widgets/product_3d_card.dart';
import '../../core/widgets/search_bar.dart';
import '../../core/routing/app_router.dart';
import '../../core/data/mock_articles.dart';
import '../../core/data/mock_bundles.dart';

class HomeScreen extends StatefulWidget {
  final ProductController controller;
  final FavoritesController favoritesController;
  final CartController cartController;
  const HomeScreen({super.key, required this.controller, required this.favoritesController, required this.cartController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: widget.controller.refreshHomeData,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(loc.t('home')),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, AppRouter.search),
                  icon: const Icon(Icons.search)),
              IconButton(onPressed: () => Navigator.pushNamed(context, AppRouter.compare), icon: const Icon(Icons.balance))
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSearchBar(onTap: () => Navigator.pushNamed(context, AppRouter.search)),
                  const SizedBox(height: 12),
                  SectionHeader(title: loc.t('wellness_hub')),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _WellnessCard(
                        title: loc.t('bundles'),
                        icon: Icons.card_giftcard_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.bundles),
                      ),
                      _WellnessCard(
                        title: loc.t('take_quiz'),
                        icon: Icons.quiz_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.quiz),
                      ),
                      _WellnessCard(
                        title: loc.t('plan_routine'),
                        icon: Icons.event_repeat_rounded,
                        onTap: () => Navigator.pushNamed(context, AppRouter.routine),
                      ),
                      _WellnessCard(
                        title: loc.t('track_rewards'),
                        icon: Icons.card_giftcard_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.rewards),
                      ),
                      _WellnessCard(
                        title: loc.t('skin_diary'),
                        icon: Icons.edit_note_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.diary),
                      ),
                      _WellnessCard(
                        title: loc.t('skin_goals'),
                        icon: Icons.flag_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.goals),
                      ),
                      _WellnessCard(
                        title: loc.t('book_consultation'),
                        icon: Icons.video_call_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.consultation),
                      ),
                      _WellnessCard(
                        title: loc.t('glow_journal'),
                        icon: Icons.menu_book_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.journal),
                      ),
                      _WellnessCard(
                        title: loc.t('referrals'),
                        icon: Icons.wallet_giftcard_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.referrals),
                      ),
                      _WellnessCard(
                        title: loc.t('coupon_center'),
                        icon: Icons.confirmation_number_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.couponCenter),
                      ),
                      _WellnessCard(
                        title: loc.t('subscriptions'),
                        icon: Icons.autorenew_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.subscriptions),
                      ),
                      _WellnessCard(
                        title: loc.t('skin_report'),
                        icon: Icons.bolt_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.skinReport),
                      ),
                      _WellnessCard(
                        title: loc.t('challenges'),
                        icon: Icons.auto_awesome_motion_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.challenges),
                      ),
                      _WellnessCard(
                        title: loc.t('wellness_dashboard'),
                        icon: Icons.monitor_heart_outlined,
                        onTap: () => Navigator.pushNamed(context, AppRouter.wellnessDashboard),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SectionHeader(title: loc.t('best_products')),
                  SizedBox(
                    height: 220,
                    child: StreamBuilder<List<dynamic>>(
                      stream: widget.controller.homeBestProductsStream,
                      builder: (_, snapshot) {
                        final data = snapshot.data;
                        if (data == null) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (_, __) => const AppSkeleton(width: 160, height: 200),
                          );
                        }
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (_, index) {
                            final product = data[index];
                            return SizedBox(
                              width: 180,
                              child: Product3DCard(product: product),
                            );
                          },
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 16),
                SectionHeader(title: loc.t('curated_sets')),
                const SizedBox(height: 8),
                SizedBox(
                  height: 190,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockBundles.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, index) {
                      final bundle = mockBundles[index];
                      return InkWell(
                        onTap: () => Navigator.pushNamed(context, AppRouter.bundles),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 240,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(bundle.imageUrl),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.background.withOpacity(0.25),
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Chip(label: Text('${loc.t('currency')} ${bundle.price.toStringAsFixed(0)}')),
                              const Spacer(),
                              Text(bundle.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700)),
                              Text(bundle.subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Theme.of(context).hintColor)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SectionHeader(title: loc.t('glow_journal')),
                const SizedBox(height: 8),
                SizedBox(
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: mockArticles.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, index) {
                        final article = mockArticles[index];
                        return SizedBox(
                          width: 220,
                          child: _WellnessCard(
                            title: article.localizedTitle(Localizations.localeOf(context).languageCode),
                            icon: Icons.menu_book_outlined,
                            onTap: () => Navigator.pushNamed(context, AppRouter.articleDetails, arguments: article),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionHeader(title: loc.t('recommended')),
                  StreamBuilder<List<dynamic>>(
                    stream: widget.controller.homeRecommendedStream,
                    builder: (_, snapshot) {
                      final list = snapshot.data;
                      if (list == null) {
                        return Column(
                          children: const [
                            AppSkeleton(height: 140),
                            SizedBox(height: 12),
                            AppSkeleton(height: 140),
                          ],
                        );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                        itemBuilder: (_, index) {
                          final product = list[index];
                          return ProductCard(
                            product: product,
                            onTap: () => Navigator.pushNamed(context, AppRouter.productDetails, arguments: product),
                            onFavorite: () => widget.favoritesController.toggleFavorite(product),
                            onAdd: () => widget.cartController.addToCart(product, 1),
                            onCompare: () => widget.controller.toggleCompareSelection(product),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WellnessCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const _WellnessCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
