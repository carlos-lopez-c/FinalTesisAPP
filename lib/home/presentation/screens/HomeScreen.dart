import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/ListaCitasTR.dart';
import 'package:h_c_1/hc_ps/presentation/screens/PsicologiaTab.dart';
import 'package:h_c_1/hc_tr/presentation/screens/TerapiaTab.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Usuario no autenticado'),
        ),
      );
    }

    final role = authState.user!.role;
    final nameComplete = authState.user!.userInformation!.firstName +
        ' ' +
        authState.user!.userInformation!.lastName;
    print(nameComplete);
    // Verificar el rol del usuario y asignar tabs dinámicamente
    List<Tab> tabs = [];
    List<Widget> tabViews = [];

    if (role == ('Therapy')) {
      tabs = [
        const Tab(icon: Icon(Icons.home), text: "Inicio"),
        const Tab(icon: Icon(Icons.folder), text: "Historias Clínicas"),
        const Tab(icon: Icon(Icons.calendar_today), text: "Citas"),
      ];

      tabViews = [
        HomeContent(name: nameComplete),
        Terapiatab(),
        ListaCitasTR(),
      ];
    } else if (role == ('Psicology')) {
      tabs = [
        const Tab(icon: Icon(Icons.home), text: "Inicio"),
        const Tab(icon: Icon(Icons.folder), text: "Historias Clínicas"),
        const Tab(icon: Icon(Icons.calendar_today), text: "Citas"),
      ];

      tabViews = [
        HomeContent(name: nameComplete),
        PsicologiaTab(),
        ListaCitasTR(),
      ];
    } else {
      return const Scaffold(
        body: Center(
          child: Text('Acceso denegado. No tienes un rol asignado.'),
        ),
      );
    }

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F8FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'FUNESAMI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );
  }
}

// Pantalla de contenido principal (Home)
class HomeContent extends StatelessWidget {
  final String name;
  const HomeContent({Key? key, this.name = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Encabezado con logo y título
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/imagenes/san-miguel.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Fundación de niños especiales',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SAN MIGUEL - FUNESAMI',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1976D2),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Mensaje de bienvenida
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Bienvenido/a $name',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF1976D2),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sistema de gestión de citas e historias clínicas',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Botón de cambio de contraseña
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () => context.push('/change-password'),
                icon: const Icon(Icons.lock_reset, color: Colors.white),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Cambiar Contraseña',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
              ),
            ),
            const SizedBox(height: 25),
            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '© Desarrollado por ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Carlos Eduardo López Candelejo',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1976D2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
