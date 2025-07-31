import 'package:flutter/material.dart';

import '../theme.dart';

class PartnershipSection extends StatefulWidget {
  const PartnershipSection({super.key});

  @override
  State<PartnershipSection> createState() => _PartnershipSectionState();
}

class _PartnershipSectionState extends State<PartnershipSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  // Lista de parceiros dos clubes Lancer
  final List<Map<String, String>> _partners = [
    {
      'name': 'Lancer Club RS',
      'location': 'Rio Grande do Sul',
      'contact': '@lancerclubrs',
    },
    {
      'name': 'Mitsubishi Evolution BR',
      'location': 'São Paulo',
      'contact': '@evobrasiloficial',
    },
    {
      'name': 'Lancer Sul Meetup',
      'location': 'Santa Catarina',
      'contact': '@lancersulmeetup',
    },
    {
      'name': 'Evo & Lancer Paraná',
      'location': 'Paraná',
      'contact': '@evolancerpr',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
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
                        'SEJA UM PARCEIRO',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: DarkModeColors.neonOrange,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Junte-se à nossa comunidade e faça parte do maior evento de Lancers',
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

          // Partnership form and info
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildPartnershipForm()),
                const SizedBox(width: 40),
                Expanded(child: _buildPartnersSection()),
              ],
            )
          else
            Column(
              children: [
                _buildPartnershipForm(),
                const SizedBox(height: 40),
                _buildPartnersSection(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPartnershipForm() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.5, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
          )),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
            ),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    DarkModeColors.darkGray.withValues(alpha: 0.8),
                    DarkModeColors.lightGray.withValues(alpha: 0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: DarkModeColors.neonOrange.withValues(alpha: 0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: DarkModeColors.neonOrange.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: DarkModeColors.neonOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.handshake,
                            color: DarkModeColors.darkOnPrimary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Torne-se Parceiro',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: DarkModeColors.neonOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Envie seu e-mail e entraremos em contato para discutir oportunidades de parceria.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: DarkModeColors.darkOnSurface
                                .withValues(alpha: 0.8),
                            height: 1.5,
                          ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'E-mail para contato',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: DarkModeColors.darkOnSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: DarkModeColors.darkOnSurface),
                      decoration: InputDecoration(
                        hintText: 'seu.email@exemplo.com',
                        hintStyle: TextStyle(
                          color: DarkModeColors.darkOnSurface
                              .withValues(alpha: 0.5),
                        ),
                        filled: true,
                        fillColor:
                            DarkModeColors.lightGray.withValues(alpha: 0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color:
                                DarkModeColors.neonCyan.withValues(alpha: 0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color:
                                DarkModeColors.neonCyan.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: DarkModeColors.neonOrange,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: DarkModeColors.neonOrange,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu e-mail';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Por favor, insira um e-mail válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _isSubmitting ? null : _submitPartnershipRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DarkModeColors.neonOrange,
                          foregroundColor: DarkModeColors.darkOnPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isSubmitting
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: DarkModeColors.darkOnPrimary,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text('ENVIANDO...'),
                                ],
                              )
                            : const Text(
                                'ENVIAR SOLICITAÇÃO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPartnersSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.5, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
          )),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        DarkModeColors.neonCyan.withValues(alpha: 0.1),
                        DarkModeColors.neonPurple.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: DarkModeColors.neonCyan.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: DarkModeColors.neonCyan,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.group,
                          color: DarkModeColors.darkOnPrimary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Parceiros dos Clubes Lancer',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: DarkModeColors.neonCyan,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ...List.generate(_partners.length, (index) {
                  final partner = _partners[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          DarkModeColors.darkGray.withValues(alpha: 0.6),
                          DarkModeColors.lightGray.withValues(alpha: 0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: DarkModeColors.neonPurple.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partner['name']!,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: DarkModeColors.neonPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: DarkModeColors.darkOnSurface
                                  .withValues(alpha: 0.7),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              partner['location']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: DarkModeColors.darkOnSurface
                                        .withValues(alpha: 0.7),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.alternate_email,
                              color: DarkModeColors.neonCyan,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              partner['contact']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: DarkModeColors.neonCyan,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitPartnershipRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: DarkModeColors.neonCyan,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Solicitação enviada com sucesso! Entraremos em contato em breve.',
                    style: TextStyle(color: DarkModeColors.darkOnSurface),
                  ),
                ),
              ],
            ),
            backgroundColor: DarkModeColors.darkGray,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 4),
          ),
        );

        _emailController.clear();
      }
    }
  }
}
