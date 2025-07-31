import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/event_overview_section.dart';
import 'widgets/gallery_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/location_section.dart';
import 'widgets/partnership_section.dart';
import 'widgets/schedule_section.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _overviewKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();
  final GlobalKey _scheduleKey = GlobalKey();
  final GlobalKey _upcomingKey = GlobalKey();
  final GlobalKey _partnershipKey = GlobalKey();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Scaffold(
      endDrawer: !isDesktop ? _buildMobileDrawer() : null,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            CustomAppBar(
              onNavigate: _scrollToSection,
              homeKey: _homeKey,
              overviewKey: _overviewKey,
              galleryKey: _galleryKey,
              locationKey: _locationKey,
              scheduleKey: _scheduleKey,
              upcomingKey: _upcomingKey,
              partnershipKey: _partnershipKey,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                HeroSection(key: _homeKey),
                EventOverviewSection(key: _overviewKey),
                GallerySection(key: _galleryKey),
                LocationSection(key: _locationKey),
                ScheduleSection(key: _scheduleKey),
                // UpcomingEventsSection(key: _upcomingKey),
                PartnershipSection(key: _partnershipKey),
                const SizedBox(height: 100),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: DarkModeColors.darkAppBarBackground,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  DarkModeColors.neonCyan.withValues(alpha: 0.2),
                  DarkModeColors.neonPurple.withValues(alpha: 0.2),
                ],
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          DarkModeColors.neonCyan.withValues(alpha: 0.3),
                          DarkModeColors.neonPurple.withValues(alpha: 0.3),
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
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDrawerItem('Início', Icons.home, () {
                  Navigator.pop(context);
                  _scrollToSection(_homeKey);
                }),
                _buildDrawerItem('Evento', Icons.event, () {
                  Navigator.pop(context);
                  _scrollToSection(_overviewKey);
                }),
                _buildDrawerItem('Galeria', Icons.photo_library, () {
                  Navigator.pop(context);
                  _scrollToSection(_galleryKey);
                }),
                _buildDrawerItem('Local', Icons.location_on, () {
                  Navigator.pop(context);
                  _scrollToSection(_locationKey);
                }),
                _buildDrawerItem('Cronograma', Icons.schedule, () {
                  Navigator.pop(context);
                  _scrollToSection(_scheduleKey);
                }),
                _buildDrawerItem('Próximos', Icons.upcoming, () {
                  Navigator.pop(context);
                  _scrollToSection(_upcomingKey);
                }),
                _buildDrawerItem('Parceiros', Icons.handshake, () {
                  Navigator.pop(context);
                  _scrollToSection(_partnershipKey);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: DarkModeColors.neonCyan,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.w500,
              ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: DarkModeColors.lightGray.withValues(alpha: 0.1),
      ),
    );
  }
}
