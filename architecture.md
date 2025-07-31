# LancerVerse - Arquitetura do Site do Evento Mitsubishi Lancer

## Visão Geral
Site moderno e futurista para evento do Mitsubishi Lancer com tema escuro, elementos brilhantes, acentos vibrantes e animações suaves. Desenvolvido em Flutter Web com foco em experiência imersiva e responsividade.

## Recursos Principais (MVP)
1. **Página Principal** - Destaque do evento com visuais impactantes
2. **Visão Geral do Evento** - Título, entrada gratuita, sorteios, redes sociais
3. **Galeria** - Fotos e vídeos de eventos anteriores e carros em destaque
4. **Localização** - Mapa interativo do local do evento
5. **Cronograma** - Data e horário das atividades
6. **Próximos Eventos** - Seção dedicada para futuros encontros do Lancer
7. **Navegação Responsiva** - AppBar com menu para todas as seções

## Estrutura Técnica

### Estrutura de Arquivos (11 arquivos)
```
lib/
├── main.dart (atualizado)
├── theme.dart (atualizado com cores futuristas)
├── home_page.dart (página principal)
├── widgets/
│   ├── custom_app_bar.dart
│   ├── hero_section.dart
│   ├── event_overview_section.dart
│   ├── gallery_section.dart
│   ├── location_section.dart
│   ├── schedule_section.dart
│   └── upcoming_events_section.dart
```

### Tema e Design
- **Cores**: Fundo escuro (#0A0A0A), acentos cyan/neon (#00FFFF), roxo futurista (#8B5CF6)
- **Tipografia**: Roboto com variações modernas
- **Animações**: Fade-in, slide-in, glow effects usando AnimationController
- **Responsividade**: LayoutBuilder para desktop/mobile

### Widgets Principais

#### 1. CustomAppBar
- Logo do evento
- Navegação horizontal (desktop) / drawer (mobile)
- Efeito transparente com blur

#### 2. HeroSection
- Imagem de fundo do Lancer com overlay
- Título dinâmico com animação de texto
- Botão CTA com efeito glow

#### 3. EventOverviewSection
- Cards com informações do evento
- Ícones sociais animados
- Badge "Entrada Gratuita"

#### 4. GallerySection
- Grid responsivo de imagens
- Modal para visualização expandida
- Filtros por categoria (fotos/vídeos)

#### 5. LocationSection
- Widget de mapa (simulado com imagem)
- Informações de endereço
- Botão para direções

#### 6. ScheduleSection
- Timeline vertical das atividades
- Cards com horários e descrições
- Indicadores visuais

#### 7. UpcomingEventsSection
- Lista de próximos eventos
- Cards com data e localização
- Botões de interesse

### Dados de Exemplo
- Eventos com datas, locais e descrições
- Galeria com imagens de Lancers e eventos
- Cronograma com atividades detalhadas
- Links para redes sociais

### Recursos de Performance
- Lazy loading para imagens
- Animações otimizadas
- Scroll suave entre seções
- Debounce em interações

### Responsividade
- Breakpoints: mobile (<768px), tablet (768-1024px), desktop (>1024px)
- Grid adaptativo
- Texto e espaçamento responsivos
- Menu colapsível

## Linguagem
Todo o conteúdo em **Português Brasileiro**, incluindo:
- Textos da interface
- Nomes de eventos
- Descrições
- Labels e botões