import 'package:flutter/material.dart';

import '../theme.dart';

class CustomAppBar extends StatelessWidget {
  final Function(GlobalKey) onNavigate;
  final GlobalKey homeKey;
  final GlobalKey overviewKey;
  final GlobalKey galleryKey;
  final GlobalKey locationKey;
  final GlobalKey scheduleKey;
  final GlobalKey upcomingKey;
  final GlobalKey partnershipKey;

  const CustomAppBar({
    super.key,
    required this.onNavigate,
    required this.homeKey,
    required this.overviewKey,
    required this.galleryKey,
    required this.locationKey,
    required this.scheduleKey,
    required this.upcomingKey,
    required this.partnershipKey,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return SliverAppBar(
      expandedHeight: 0,
      pinned: true,
      backgroundColor:
          DarkModeColors.darkAppBarBackground.withValues(alpha: 0.95),
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  DarkModeColors.neonCyan.withValues(alpha: 0.2),
                  DarkModeColors.neonPurple.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: DarkModeColors.neonCyan.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Text(
              '⚡ MEETUPSUL',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: DarkModeColors.neonCyan,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
        ],
      ),
      actions: [
        if (isDesktop) ...[
          _buildNavButton(context, 'Início', () => onNavigate(homeKey)),
          _buildNavButton(context, 'Evento', () => onNavigate(overviewKey)),
          _buildNavButton(context, 'Galeria', () => onNavigate(galleryKey)),
          _buildNavButton(context, 'Local', () => onNavigate(locationKey)),
          _buildNavButton(context, 'Cronograma', () => onNavigate(scheduleKey)),
          _buildNavButton(context, 'Próximos', () => onNavigate(upcomingKey)),
          _buildNavButton(
              context, 'Parceiros', () => onNavigate(partnershipKey)),
          const SizedBox(width: 16),
        ] else ...[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: DarkModeColors.neonCyan,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNavButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: DarkModeColors.darkOnSurface,
          overlayColor: DarkModeColors.neonCyan.withValues(alpha: 0.1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
