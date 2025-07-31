import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class EventOverviewSection extends StatefulWidget {
  const EventOverviewSection({super.key});

  @override
  State<EventOverviewSection> createState() => _EventOverviewSectionState();
}

class _EventOverviewSectionState extends State<EventOverviewSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            DarkModeColors.darkSurface,
            DarkModeColors.darkGray.withValues(alpha: 0.3),
            DarkModeColors.darkSurface,
          ],
        ),
      ),
      child: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(
              opacity: 1 - (_slideAnimation.value / 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Section title
                  Text(
                    'VISÃO GERAL DO EVENTO',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: DarkModeColors.neonCyan,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Prepare-se para uma experiência única no universo dos Mitsubishi Lancer',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: DarkModeColors.darkOnSurface
                              .withValues(alpha: 0.8),
                          fontWeight: FontWeight.w400,
                        ),
                  ),

                  const SizedBox(height: 60),

                  // Main content grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (isDesktop) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildEventInfo()),
                            const SizedBox(width: 40),
                            Expanded(child: _buildHighlights()),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildEventInfo(),
                            const SizedBox(height: 40),
                            _buildHighlights(),
                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 60),

                  // Social media section
                  _buildSocialSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventInfo() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DarkModeColors.darkGray.withValues(alpha: 0.6),
            DarkModeColors.lightGray.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: DarkModeColors.neonPurple.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: DarkModeColors.neonPurple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: DarkModeColors.neonPurple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'INFORMAÇÕES DO EVENTO',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: DarkModeColors.neonPurple,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildInfoItem(
            Icons.money_off,
            'ENTRADA GRATUITA',
            'Acesso livre para todos os apaixonados por carros',
            DarkModeColors.neonCyan,
          ),
          const SizedBox(height: 20),
          _buildInfoItem(
            Icons.card_giftcard,
            'SORTEIOS EXCLUSIVOS',
            'Concorra a peças, acessórios e muito mais',
            DarkModeColors.neonOrange,
          ),
          const SizedBox(height: 20),
          _buildInfoItem(
            Icons.groups,
            'COMUNIDADE ATIVA',
            'Conecte-se com outros entusiastas',
            DarkModeColors.neonCyan,
          ),
          const SizedBox(height: 20),
          _buildInfoItem(
            Icons.camera_alt,
            'EXPOSIÇÃO DE CARROS',
            'Os Lancers mais incríveis do Brasil',
            DarkModeColors.neonPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildHighlights() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DarkModeColors.darkGray.withValues(alpha: 0.6),
            DarkModeColors.lightGray.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: DarkModeColors.neonOrange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: DarkModeColors.neonOrange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.star,
                  color: DarkModeColors.neonOrange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'DESTAQUES',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: DarkModeColors.neonOrange,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildHighlightCard(
            'CARROS MODIFICADOS',
            'Exposição de Lancers modificados',
            '🏁',
          ),
          //const SizedBox(height: 16),
          // _buildHighlightCard(
          //   'SHOW DE SOM',
          //   'Demonstrações de áudio',
          //   '🔊',
          // ),
          const SizedBox(height: 16),
          _buildHighlightCard(
            'WORKSHOP TÉCNICO',
            'Dicas de modificação',
            '🔧',
          ),
          const SizedBox(height: 16),
          _buildHighlightCard(
            'FOOD TRUCKS',
            'Gastronomia variada',
            '🍔',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      IconData icon, String title, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          DarkModeColors.darkOnSurface.withValues(alpha: 0.8),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightCard(String title, String subtitle, String emoji) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkModeColors.lightGray.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: DarkModeColors.neonCyan.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: DarkModeColors.darkOnSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            DarkModeColors.darkOnSurface.withValues(alpha: 0.7),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DarkModeColors.neonCyan.withValues(alpha: 0.1),
            DarkModeColors.neonPurple.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: DarkModeColors.neonCyan.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'SIGA-NOS NAS REDES SOCIAIS',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: DarkModeColors.neonCyan,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'Fique por dentro de todas as novidades e atualizações do evento',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: DarkModeColors.darkOnSurface.withValues(alpha: 0.8),
                ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildSocialButton(
                'Instagram',
                Icons.camera_alt,
                DarkModeColors.neonPurple,
                () => _launchURL('https://instagram.com'),
              ),
              _buildSocialButton(
                'Facebook',
                Icons.facebook,
                Colors.blue,
                () => _launchURL('https://facebook.com'),
              ),
              _buildSocialButton(
                'YouTube',
                Icons.play_arrow,
                Colors.red,
                () => _launchURL('https://youtube.com'),
              ),
              _buildSocialButton(
                'WhatsApp',
                Icons.message,
                Colors.green,
                () => _launchURL('https://whatsapp.com'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
      String name, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: DarkModeColors.darkOnPrimary),
      label: Text(
        name,
        style: TextStyle(
          color: DarkModeColors.darkOnPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: DarkModeColors.darkOnPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
