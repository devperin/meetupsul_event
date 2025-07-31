import 'package:flutter/material.dart';

import '../theme.dart';

class ScheduleSection extends StatefulWidget {
  const ScheduleSection({super.key});

  @override
  State<ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _scheduleItems = [
    {
      'time': '09:00',
      'title': 'Abertura do Evento',
      'description': 'Credenciamento e início das atividades',
      'icon': Icons.login,
      'color': DarkModeColors.neonCyan,
      'isHighlight': false,
    },
    {
      'time': '11:00',
      'title': 'Exposição de Veículos',
      'description': 'Showcars e competições',
      'icon': Icons.directions_car,
      'color': DarkModeColors.neonOrange,
      'isHighlight': true,
    },
    {
      'time': '14:00',
      'title': 'Atividades Principais',
      'description': 'Workshop e arrancada',
      'icon': Icons.speed,
      'color': DarkModeColors.neonPurple,
      'isHighlight': true,
    },
    {
      'time': '18:00',
      'title': 'Encerramento',
      'description': 'Premiação e confraternização',
      'icon': Icons.celebration,
      'color': DarkModeColors.neonCyan,
      'isHighlight': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
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
        vertical: 60,
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
      child: Column(
        children: [
          // Section title
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
                )),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'CRONOGRAMA DO EVENTO',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: DarkModeColors.neonCyan,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '10 de Novembro de 2025 • Segunda',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: DarkModeColors.darkOnSurface
                                  .withValues(alpha: 0.8),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              DarkModeColors.neonOrange.withValues(alpha: 0.2),
                              DarkModeColors.neonPurple.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: DarkModeColors.neonOrange
                                .withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Space Adventure',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: DarkModeColors.neonOrange,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 60),

          // Timeline
          _buildTimeline(isDesktop),
        ],
      ),
    );
  }

  Widget _buildTimeline(bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop) {
          return _buildDesktopTimeline();
        } else {
          return _buildMobileTimeline();
        }
      },
    );
  }

  Widget _buildDesktopTimeline() {
    return Column(
      children: _scheduleItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLeft = index % 2 == 0;

        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final delay = index * 0.1.clamp(0.0, 0.3);
            final startInterval = (0.2 + delay).clamp(0.0, 0.7);
            final endInterval = (0.7 + delay).clamp(startInterval + 0.1, 1.0);
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(isLeft ? -0.5 : 0.5, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  startInterval,
                  endInterval,
                  curve: Curves.easeOut,
                ),
              )),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    startInterval,
                    endInterval,
                    curve: Curves.easeOut,
                  ),
                ),
                child: _buildTimelineItem(item, index, isLeft: isLeft),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildMobileTimeline() {
    return Column(
      children: _scheduleItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final delay = index * 0.08.clamp(0.0, 0.4);
            final startInterval = (0.2 + delay).clamp(0.0, 0.8);
            final endInterval = (0.8 + delay).clamp(startInterval + 0.1, 1.0);
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  startInterval,
                  endInterval,
                  curve: Curves.easeOut,
                ),
              )),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    startInterval,
                    endInterval,
                    curve: Curves.easeOut,
                  ),
                ),
                child: _buildTimelineItem(item, index, isLeft: false),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> item, int index,
      {bool isLeft = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    final isLast = index == _scheduleItems.length - 1;

    if (isDesktop) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            // Left side content
            if (isLeft) ...[
              Expanded(
                child: _buildTimelineCard(item),
              ),
              const SizedBox(width: 30),
            ] else ...[
              const Expanded(child: SizedBox()),
              const SizedBox(width: 30),
            ],

            // Center timeline
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item['color'],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: item['color'].withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Icon(
                    item['icon'],
                    color: DarkModeColors.darkOnPrimary,
                    size: 20,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          item['color'],
                          item['color'].withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Right side content
            if (!isLeft) ...[
              const SizedBox(width: 30),
              Expanded(
                child: _buildTimelineCard(item),
              ),
            ] else ...[
              const SizedBox(width: 30),
              const Expanded(child: SizedBox()),
            ],
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item['color'],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: item['color'].withValues(alpha: 0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    item['icon'],
                    color: DarkModeColors.darkOnPrimary,
                    size: 18,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          item['color'],
                          item['color'].withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20),
            // Content
            Expanded(
              child: _buildTimelineCard(item),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTimelineCard(Map<String, dynamic> item) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: item['isHighlight']
            ? LinearGradient(
                colors: [
                  item['color'].withValues(alpha: 0.15),
                  DarkModeColors.darkGray.withValues(alpha: 0.8),
                ],
              )
            : LinearGradient(
                colors: [
                  DarkModeColors.darkGray.withValues(alpha: 0.6),
                  DarkModeColors.lightGray.withValues(alpha: 0.4),
                ],
              ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item['isHighlight']
              ? item['color'].withValues(alpha: 0.5)
              : DarkModeColors.neonCyan.withValues(alpha: 0.2),
          width: item['isHighlight'] ? 2 : 1,
        ),
        boxShadow: item['isHighlight']
            ? [
                BoxShadow(
                  color: item['color'].withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: item['color'],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item['time'],
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: DarkModeColors.darkOnPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 12),

          // Title
          Text(
            item['title'],
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: item['isHighlight']
                      ? item['color']
                      : DarkModeColors.darkOnSurface,
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            item['description'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: DarkModeColors.darkOnSurface.withValues(alpha: 0.8),
                  height: 1.4,
                ),
          ),

          // Highlight indicator
          if (item['isHighlight'])
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: item['color'],
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'DESTAQUE DO EVENTO',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: item['color'],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
