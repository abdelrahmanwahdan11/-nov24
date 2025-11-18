import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/controllers/onboarding_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/routing/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingController controller = OnboardingController();
  final pages = [
    (
      'https://images.pexels.com/photos/3764016/pexels-photo-3764016.jpeg?auto=compress&cs=tinysrgb&w=800',
      'Natural glow',
      'Hydrate and brighten with botanical serums.',
    ),
    (
      'https://images.pexels.com/photos/3738384/pexels-photo-3738384.jpeg?auto=compress&cs=tinysrgb&w=800',
      'Body care ritual',
      'Smooth textures inspired by spa experiences.',
    ),
    (
      'https://images.pexels.com/photos/3738157/pexels-photo-3738157.jpeg?auto=compress&cs=tinysrgb&w=800',
      'Hair nourishment',
      'Shine and strength from pure oils.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller.startAutoScroll(pages.length);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (i) => controller.onPageChanged(i, pages.length),
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final item = pages[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(item.$1, fit: BoxFit.cover),
                      Container(color: Colors.black.withOpacity(0.35)),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.$2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: Colors.white))
                                .animate()
                                .fadeIn()
                                .slideY(begin: .3, end: 0),
                            const SizedBox(height: 12),
                            Text(item.$3,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.white70))
                                .animate()
                                .fadeIn()
                                .slideY(begin: .4, end: 0),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () async {
                                await controller.markSeen();
                                if (!mounted) return;
                                Navigator.pushReplacementNamed(context, AppRouter.login);
                              },
                              child: Text(loc.t('next')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<int>(
              valueListenable: controller.pageIndex,
              builder: (_, value, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pages.length, (index) {
                    final active = value == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.all(4),
                      width: active ? 16 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: active
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  }),
                );
              },
            ),
            TextButton(
              onPressed: () async {
                await controller.markSeen();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, AppRouter.login);
                }
              },
              child: Text(loc.t('skip')),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
