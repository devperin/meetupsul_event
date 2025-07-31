import 'package:flutter/material.dart';

import '../theme.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedFilter = 'Todos';

  final List<String> _filters = ['Todos', 'Fotos', 'Vídeos'];

  final List<Map<String, dynamic>> _galleryItems = [
    {
      'url':
          'https://pixabay.com/get/g8e5c59932a36d88c6520160168df8c6868cc8a2c77597e3c6baec80f8dfbd18c34b4174a3be3e4be39cd12c996b9aba6b63dac35f43c1307cb86857404d92f4d_1280.jpg',
      'type': 'Fotos',
      'title': 'Lancer Evolution X',
      'description': 'Destaque do último evento',
    },
    {
      'url':
          'https://pixabay.com/get/g7935a947ff69bfe88fc0e3bcdc7369b7c79ebc5e012302b09b294c29778cff8ca26293b37f4da7fbbd73dfe80596b4605040d5e53bc9ce88d233930c5f43727c_1280.jpg',
      'type': 'Fotos',
      'title': 'Competição de Arrancada',
      'description': 'Adrenalina pura na pista',
    },
    {
      'url':
          'https://pixabay.com/get/g11c88d2f457d0438904cb72b70ad772307926751334b365975afd452e7886f70212b576bb022daaede5280b3480d5704fd4efe74defa35e1a5466d1c2a491d0a_1280.jpg',
      'type': 'Fotos',
      'title': 'Encontro da Comunidade',
      'description': 'Centenas de Lancers reunidos',
    },
    {
      'url':
          'https://pixabay.com/get/ga4be5498580d14a291a71662777f0fa879edaabed87b929ff6d6caed0f6fc13e1c19e37f9d3c3e1d26a77196d5f921325749a810d2707d9a3a75cb9de7a5326e_1280.jpg',
      'type': 'Vídeos',
      'title': 'Noite de Arrancada',
      'description': 'Melhores momentos em vídeo',
    },
    {
      'url':
          'https://pixabay.com/get/g9ac4b6c9e7e03ca02709611f96af20b0b7d166fa7203cba5499f13cc9921642d1a6a6e2cd53ade8b525e5e3c26d87b2320a7246b79659db55603dd4849a9999a_1280.jpg',
      'type': 'Fotos',
      'title': 'Modificações Extremas',
      'description': 'Trabalhos personalizados',
    },
    {
      'url':
          'https://pixabay.com/get/g2cb06bd93d4cf56b6cc721a6fef60f3f90af703286ee3c56ae63f08e3ddd1eba4b5054b4d030f274820cda15417ef69150acefa7a1491449a964da86396342b8_1280.jpg',
      'type': 'Vídeos',
      'title': 'Workshop Técnico',
      'description': 'Dicas dos especialistas',
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
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredItems {
    if (_selectedFilter == 'Todos') return _galleryItems;
    return _galleryItems
        .where((item) => item['type'] == _selectedFilter)
        .toList();
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
            DarkModeColors.darkGray.withValues(alpha: 0.5),
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
                  curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                )),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'GALERIA DE MOMENTOS',
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
                        'Reviva os melhores momentos dos nossos eventos anteriores',
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

          const SizedBox(height: 50),

          // Filter buttons
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
                )),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
                  ),
                  child: _buildFilterButtons(),
                ),
              );
            },
          ),

          const SizedBox(height: 50),

          // Gallery grid
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                )),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                  ),
                  child: _buildGalleryGrid(isDesktop),
                ),
              );
            },
          ),

          const SizedBox(height: 50),

          // Ver Galeria Completa Button
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                )),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                  ),
                  child: _buildViewAllButton(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: _filters.map((filter) {
        final isSelected = _selectedFilter == filter;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          DarkModeColors.neonCyan,
                          DarkModeColors.neonPurple,
                        ],
                      )
                    : null,
                color: isSelected
                    ? null
                    : DarkModeColors.lightGray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : DarkModeColors.neonCyan.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: DarkModeColors.neonCyan.withValues(alpha: 0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Text(
                filter,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? DarkModeColors.darkOnPrimary
                          : DarkModeColors.darkOnSurface,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGalleryGrid(bool isDesktop) {
    final crossAxisCount = isDesktop ? 3 : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return _buildGalleryItem(item, index);
      },
    );
  }

  Widget _buildGalleryItem(Map<String, dynamic> item, int index) {
    return GestureDetector(
      onTap: () => _showImageModal(item),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (index * 100)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: DarkModeColors.neonCyan.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: DarkModeColors.neonPurple.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.network(
                  item['url'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: DarkModeColors.lightGray.withValues(alpha: 0.3),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: DarkModeColors.neonCyan,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
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

                // Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        DarkModeColors.darkSurface.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),

                // Content
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          if (item['type'] == 'Vídeos')
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: DarkModeColors.neonOrange,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: DarkModeColors.darkOnPrimary,
                                size: 16,
                              ),
                            ),
                          if (item['type'] == 'Vídeos')
                            const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: DarkModeColors.neonCyan,
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['description'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: DarkModeColors.darkOnSurface
                                  .withValues(alpha: 0.8),
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Hover effect
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _showImageModal(item),
                      child: Container(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageModal(Map<String, dynamic> item) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: DarkModeColors.neonCyan,
                      size: 30,
                    ),
                  ),
                ),

                // Image
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item['url'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Info
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: DarkModeColors.darkGray.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: DarkModeColors.neonCyan.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        item['title'],
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: DarkModeColors.neonCyan,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['description'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: DarkModeColors.darkOnSurface
                                  .withValues(alpha: 0.8),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewAllButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: DarkModeColors.neonPurple.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () => _showFullGallery(),
          icon: Icon(
            Icons.photo_library,
            color: DarkModeColors.darkOnPrimary,
          ),
          label: const Text(
            'VER GALERIA COMPLETA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: DarkModeColors.neonPurple,
            foregroundColor: DarkModeColors.darkOnPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  void _showFullGallery() {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog.fullscreen(
        backgroundColor: DarkModeColors.darkSurface,
        child: FullGalleryModal(galleryItems: _galleryItems),
      ),
    );
  }
}

class FullGalleryModal extends StatefulWidget {
  final List<Map<String, dynamic>> galleryItems;

  const FullGalleryModal({super.key, required this.galleryItems});

  @override
  State<FullGalleryModal> createState() => _FullGalleryModalState();
}

class _FullGalleryModalState extends State<FullGalleryModal> {
  String _selectedFilter = 'Todos';
  final List<String> _filters = ['Todos', 'Fotos', 'Vídeos'];

  List<Map<String, dynamic>> get _filteredItems {
    if (_selectedFilter == 'Todos') return widget.galleryItems;
    return widget.galleryItems
        .where((item) => item['type'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Scaffold(
      backgroundColor: DarkModeColors.darkSurface,
      appBar: AppBar(
        backgroundColor: DarkModeColors.darkAppBarBackground,
        title: Row(
          children: [
            Icon(
              Icons.photo_library,
              color: DarkModeColors.neonPurple,
            ),
            const SizedBox(width: 12),
            Text(
              'Galeria Completa - Fotos e Vídeos',
              style: TextStyle(
                color: DarkModeColors.neonPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: DarkModeColors.neonCyan,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Filter buttons
          Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                DarkModeColors.neonCyan,
                                DarkModeColors.neonPurple,
                              ],
                            )
                          : null,
                      color: isSelected
                          ? null
                          : DarkModeColors.lightGray.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : DarkModeColors.neonCyan.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected
                            ? DarkModeColors.darkOnPrimary
                            : DarkModeColors.darkOnSurface,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Gallery grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : 20,
                vertical: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 4 : 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return _buildFullGalleryItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullGalleryItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _showImageModal(item),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: DarkModeColors.neonCyan.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: DarkModeColors.neonPurple.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              Image.network(
                item['url'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: DarkModeColors.lightGray.withValues(alpha: 0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: DarkModeColors.neonCyan,
                      ),
                    ),
                  );
                },
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

              // Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      DarkModeColors.darkSurface.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Row(
                  children: [
                    if (item['type'] == 'Vídeos')
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: DarkModeColors.neonOrange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: DarkModeColors.darkOnPrimary,
                          size: 16,
                        ),
                      ),
                    if (item['type'] == 'Vídeos') const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: TextStyle(
                          color: DarkModeColors.neonCyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
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
        ),
      ),
    );
  }

  void _showImageModal(Map<String, dynamic> item) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: DarkModeColors.neonCyan,
                      size: 30,
                    ),
                  ),
                ),

                // Image
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item['url'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Info
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: DarkModeColors.darkGray.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: DarkModeColors.neonCyan.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                          color: DarkModeColors.neonCyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: DarkModeColors.darkOnSurface
                              .withValues(alpha: 0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
