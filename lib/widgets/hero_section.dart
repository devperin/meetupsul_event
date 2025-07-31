import 'package:flutter/material.dart';

import '../theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _textController;
  late Animation<double> _glowAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Container(
      height: screenHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            DarkModeColors.darkSurface,
            DarkModeColors.darkGray.withValues(alpha: 0.8),
            DarkModeColors.darkSurface,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background image with overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://pixabay.com/get/g8e5c59932a36d88c6520160168df8c6868cc8a2c77597e3c6baec80f8dfbd18c34b4174a3be3e4be39cd12c996b9aba6b63dac35f43c1307cb86857404d92f4d_1280.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      DarkModeColors.darkSurface.withValues(alpha: 0.7),
                      DarkModeColors.darkSurface.withValues(alpha: 0.4),
                      DarkModeColors.darkSurface.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Animated content
          Center(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(_textAnimation),
              child: FadeTransition(
                opacity: _textAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main title with glow effect
                    AnimatedBuilder(
                      animation: _glowAnimation,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(64),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(54, 0, 255, 255)
                                    .withValues(
                                        alpha: _glowAnimation.value * 0.5),
                                blurRadius: 30 * _glowAnimation.value,
                                spreadRadius: 5 * _glowAnimation.value,
                              ),
                            ],
                          ),
                          child: Text(
                            'MEETUP\nSUL',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                              color: const Color.fromARGB(255, 58, 39, 167),
                              fontWeight: FontWeight.w900,
                              fontSize: isDesktop ? 72 : 48,
                              height: 0.9,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color:
                                      const Color.fromARGB(157, 233, 101, 215)
                                          .withValues(alpha: 0.8),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Subtitle
                    Text(
                      'O MAIOR ENCONTRO DE LANCERS DO BRASIL',
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: DarkModeColors.darkOnTertiary,
                                fontWeight: FontWeight.bold,
                                fontSize: isDesktop ? 24 : 18,
                                letterSpacing: 1.0,
                              ),
                    ),

                    const SizedBox(height: 40),

                    // Event info
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            DarkModeColors.darkGray.withValues(alpha: 0.8),
                            DarkModeColors.lightGray.withValues(alpha: 0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              DarkModeColors.neonOrange.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: DarkModeColors.neonOrange,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '10 de Novembro• 2025',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: DarkModeColors.darkOnSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: DarkModeColors.neonOrange,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Space Adventure • BC',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: DarkModeColors.darkOnSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // CTA Buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildGlowButton(
                          'Fique por dentro',
                          DarkModeColors.neonCyan,
                          () {},
                        ),
                        _buildOutlineButton(
                          'Saiba Mais',
                          DarkModeColors.neonPurple,
                          () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating particles effect
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ParticlesPainter(_glowAnimation.value),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowButton(String text, Color color, VoidCallback onPressed) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: _glowAnimation.value * 0.4),
                blurRadius: 20 * _glowAnimation.value,
                spreadRadius: 2 * _glowAnimation.value,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: DarkModeColors.darkOnPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOutlineButton(String text, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final double animation;

  ParticlesPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DarkModeColors.neonCyan.withValues(alpha: 0.1 * animation)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 50; i++) {
      final x = (i * 37) % size.width;
      final y = (i * 23 + animation * 100) % size.height;
      final radius = (i % 3) + 1.0;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
