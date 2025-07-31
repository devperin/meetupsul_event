import 'package:flutter/material.dart';

import '../theme.dart';

class UpcomingEventsSection extends StatefulWidget {
  const UpcomingEventsSection({super.key});

  @override
  State<UpcomingEventsSection> createState() => _UpcomingEventsSectionState();
}

class _UpcomingEventsSectionState extends State<UpcomingEventsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _upcomingEvents = [
    {
      'title': 'Lancer Meet Rio',
      'date': '22 de Janeiro, 2025',
      'location': 'Autódromo de Jacarepaguá - RJ',
      'description':
          'Primeiro encontro de Lancers do ano no Rio de Janeiro com competições de arrancada e exposição.',
      'price': 'Entrada Gratuita',
      'image':
          'https://pixabay.com/get/g8e5c59932a36d88c6520160168df8c6868cc8a2c77597e3c6baec80f8dfbd18c34b4174a3be3e4be39cd12c996b9aba6b63dac35f43c1307cb86857404d92f4d_1280.jpg',
      'highlights': ['Drag Race', 'Show de Som', 'Workshop'],
      'color': DarkModeColors.neonCyan,
    },
    {
      'title': 'Evolution Track Day',
      'date': '15 de Março, 2025',
      'location': 'Autódromo de Goiânia - GO',
      'description':
          'Dia de pista exclusivo para Mitsubishi Lancer Evolution com instruções profissionais.',
      'price': 'R\$ 150,00',
      'image':
          'https://pixabay.com/get/g7935a947ff69bfe88fc0e3bcdc7369b7c79ebc5e012302b09b294c29778cff8ca26293b37f4da7fbbd73dfe80596b4605040d5e53bc9ce88d233930c5f43727c_1280.jpg',
      'highlights': ['Track Day', 'Instrução', 'Cronometragem'],
      'color': DarkModeColors.neonOrange,
    },
    {
      'title': 'Lancer Fest Nordeste',
      'date': '10 de Maio, 2025',
      'location': 'Kartódromo Ayrton Senna - PE',
      'description':
          'Festival dos Lancers do Nordeste com exposição, competições e muito entretenimento.',
      'price': 'Entrada Gratuita',
      'image':
          'https://pixabay.com/get/g11c88d2f457d0438904cb72b70ad772307926751334b365975afd452e7886f70212b576bb022daaede5280b3480d5704fd4efe74defa35e1a5466d1c2a491d0a_1280.jpg',
      'highlights': ['Festival', 'Competições', 'Música'],
      'color': DarkModeColors.neonPurple,
    },
    {
      'title': 'Sul Evolution Meeting',
      'date': '25 de Julho, 2025',
      'location': 'Autódromo de Tarumã - RS',
      'description':
          'Encontro dos Lancers da região Sul com atividades especiais e premiações incríveis.',
      'price': 'R\$ 50,00',
      'image':
          'https://pixabay.com/get/ga4be5498580d14a291a71662777f0fa879edaabed87b929ff6d6caed0f6fc13e1c19e37f9d3c3e1d26a77196d5f921325749a810d2707d9a3a75cb9de7a5326e_1280.jpg',
      'highlights': ['Premiação', 'Exposição', 'Networking'],
      'color': DarkModeColors.neonCyan,
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
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            DarkModeColors.darkSurface,
            DarkModeColors.darkGray.withValues(alpha: 0.6),
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
                        'PRÓXIMOS EVENTOS',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: DarkModeColors.neonPurple,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Não perca os próximos encontros da comunidade Lancer pelo Brasil',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: DarkModeColors.darkOnSurface
                                  .withValues(alpha: 0.8),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 60),

          // Events grid
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                )),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                  ),
                  child: _buildEventsGrid(isDesktop),
                ),
              );
            },
          ),

          const SizedBox(height: 60),

          // Newsletter signup
          _buildNewsletterSection(),
        ],
      ),
    );
  }

  Widget _buildEventsGrid(bool isDesktop) {
    if (isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemCount: _upcomingEvents.length,
        itemBuilder: (context, index) {
          return _buildEventCard(_upcomingEvents[index], index);
        },
      );
    } else {
      return Column(
        children: _upcomingEvents.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildEventCard(entry.value, entry.key),
          );
        }).toList(),
      );
    }
  }

  Widget _buildEventCard(Map<String, dynamic> event, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: event['color'].withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: event['color'].withValues(alpha: 0.1),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.network(
                  event['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: DarkModeColors.lightGray.withValues(alpha: 0.3),
                      child: Icon(
                        Icons.error_outline,
                        color: DarkModeColors.neonOrange,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),

              // Overlay gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        DarkModeColors.darkSurface.withValues(alpha: 0.7),
                        DarkModeColors.darkSurface.withValues(alpha: 0.95),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: event['price'].contains('Gratuita')
                              ? DarkModeColors.neonCyan
                              : DarkModeColors.neonOrange,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: (event['price'].contains('Gratuita')
                                      ? DarkModeColors.neonCyan
                                      : DarkModeColors.neonOrange)
                                  .withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(
                          event['price'],
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: DarkModeColors.darkOnPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),

                      const Spacer(),

                      // Event details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['title'],
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: event['color'],
                                  fontWeight: FontWeight.bold,
                                ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: DarkModeColors.darkOnSurface
                                    .withValues(alpha: 0.8),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                event['date'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: DarkModeColors.darkOnSurface
                                          .withValues(alpha: 0.8),
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: DarkModeColors.darkOnSurface
                                    .withValues(alpha: 0.8),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  event['location'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: DarkModeColors.darkOnSurface
                                            .withValues(alpha: 0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Text(
                            event['description'],
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: DarkModeColors.darkOnSurface
                                          .withValues(alpha: 0.9),
                                      height: 1.3,
                                    ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),

                          // Highlights
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children:
                                event['highlights'].map<Widget>((highlight) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: event['color'].withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        event['color'].withValues(alpha: 0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  highlight,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: event['color'],
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 16),

                          // Action button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _showEventDetails(event),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: event['color'],
                                foregroundColor: DarkModeColors.darkOnPrimary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'SAIBA MAIS',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsletterSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
          )),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    DarkModeColors.neonPurple.withValues(alpha: 0.1),
                    DarkModeColors.neonCyan.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: DarkModeColors.neonPurple.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: DarkModeColors.neonPurple,
                    size: 48,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'FIQUE POR DENTRO',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: DarkModeColors.neonPurple,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Receba notificações sobre novos eventos, competições e novidades da comunidade Lancer',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: DarkModeColors.darkOnSurface
                              .withValues(alpha: 0.8),
                          height: 1.4,
                        ),
                  ),

                  const SizedBox(height: 32),

                  // Newsletter form (simulated)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Digite seu e-mail',
                            hintStyle: TextStyle(
                              color: DarkModeColors.darkOnSurface
                                  .withValues(alpha: 0.6),
                            ),
                            filled: true,
                            fillColor:
                                DarkModeColors.lightGray.withValues(alpha: 0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: DarkModeColors.neonPurple
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: DarkModeColors.neonPurple
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: DarkModeColors.neonPurple,
                                width: 2,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: DarkModeColors.darkOnSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Obrigado! Você será notificado sobre os próximos eventos.'),
                                  backgroundColor: DarkModeColors.neonPurple,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DarkModeColors.neonPurple,
                              foregroundColor: DarkModeColors.darkOnPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'CADASTRAR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: DarkModeColors.darkGray.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: event['color'].withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event['title'],
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: event['color'],
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: DarkModeColors.darkOnSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                event['description'],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          DarkModeColors.darkOnSurface.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Interesse registrado em ${event['title']}!'),
                      backgroundColor: event['color'],
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: event['color'],
                  foregroundColor: DarkModeColors.darkOnPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'DEMONSTRAR INTERESSE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
