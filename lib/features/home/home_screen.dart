import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/storage/local_storage.dart';
import '../../shared/widgets/animated_card.dart';
import '../../shared/widgets/slide_fade_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _greetingController;

  @override
  void initState() {
    super.initState();
    _greetingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _greetingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryBlue.withOpacity(0.1),
              Colors.white,
              AppTheme.accentOrange.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: _selectedIndex == 0
              ? _buildHomeTab()
              : _selectedIndex == 1
                  ? _buildStatsTab()
                  : _buildProfileTab(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Colors.white,
          elevation: 0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Accueil',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart),
              label: 'Statistiques',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.scanner),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scanner'),
              backgroundColor: AppTheme.accentGreen,
              elevation: 8,
            )
          : null,
    );
  }

  // DRAWER MENU COMPLET
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2196F3), Colors.white],
            stops: [0.3, 0.3],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Patient Test',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '+237 600 000 000',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            
            // ACCUEIL
            ListTile(
              leading: const Icon(Icons.home, color: AppTheme.primaryBlue),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            
            const Divider(),
            
            // SANTÉ
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'MA SANTÉ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
            ),
            
            ListTile(
              leading: const Icon(Icons.qr_code, color: AppTheme.primaryBlue),
              title: const Text('Mon QR Code'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.qr);
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.alarm, color: AppTheme.accentOrange),
              title: const Text('Mes Rappels'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.reminders);
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.folder, color: AppTheme.accentPurple),
              title: const Text('Mes Documents'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.documents);
              },
            ),
            
            const Divider(),
            
            // FAMILLE & PROCHES
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'FAMILLE & PROCHES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
            ),
            
            ListTile(
              leading: const Icon(Icons.family_restroom, color: AppTheme.accentGreen),
              title: const Text('Ma Famille'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.family);
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.people, color: AppTheme.primaryBlue),
              title: const Text('Mes Proches'),
              subtitle: const Text('Suivi médicaments', style: TextStyle(fontSize: 11)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.careContacts);
              },
            ),
            
            const Divider(),
            
            // PARAMÈTRES
            ListTile(
              leading: const Icon(Icons.bar_chart, color: Colors.grey),
              title: const Text('Statistiques'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 1);
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.grey),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
            
            const Divider(),
            
            // DÉCONNEXION
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Déconnexion',
                  style: TextStyle(color: Colors.red)),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Déconnexion'),
                    content: const Text('Voulez-vous vraiment vous déconnecter ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Déconnexion',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true) {
                  await LocalStorage.clearAll();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        // App Bar avec menu burger
        SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedBuilder(
                        animation: _greetingController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              _greetingController.value * 5 - 2.5,
                            ),
                            child: child,
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              '👋',
                              style: TextStyle(fontSize: 28),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Bonjour,',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Patient Test',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),

        // Contenu
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              
              // Actions rapides
              const Text(
                'Actions rapides',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  SlideFadeTransition(
                    delay: const Duration(milliseconds: 200),
                    child: _buildActionCard(
                      context,
                      'Mon QR Code',
                      Icons.qr_code,
                      AppTheme.primaryGradient,
                      AppRoutes.qr,
                    ),
                  ),
                  SlideFadeTransition(
                    delay: const Duration(milliseconds: 300),
                    child: _buildActionCard(
                      context,
                      'Rappels',
                      Icons.alarm,
                      AppTheme.warningGradient,
                      AppRoutes.reminders,
                    ),
                  ),
                  SlideFadeTransition(
                    delay: const Duration(milliseconds: 400),
                    child: _buildActionCard(
                      context,
                      'Documents',
                      Icons.folder_open,
                      const LinearGradient(
                        colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                      ),
                      AppRoutes.documents,
                    ),
                  ),
                  SlideFadeTransition(
                    delay: const Duration(milliseconds: 500),
                    child: _buildActionCard(
                      context,
                      'Mes Proches',
                      Icons.people,
                      AppTheme.successGradient,
                      AppRoutes.careContacts,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Gradient gradient,
    String route,
  ) {
    return AnimatedCard(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsTab() {
    return const Center(child: Text('Statistiques - En développement'));
  }

  Widget _buildProfileTab() {
    return const Center(child: Text('Profil - En développement'));
  }
}
