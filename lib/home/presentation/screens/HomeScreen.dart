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
        HomeContent(
            name: authState.user!.userInformation!.firstName +
                ' ' +
                authState.user!.userInformation!.lastName),
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
        HomeContent(),
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
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
            ),
          ],
          bottom: TabBar(
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
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.push('/change-password');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Cambiar Contraseña',
                      style: TextStyle(fontSize: 20))),
              const SizedBox(height: 2),
              Text(
                'Fundación de niños especiales',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'SAN MIGUEL - FUNESAMI',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenido/a  ' '$name',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'al sistema de gestión de citas e historias clínicas',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Image.asset(
            'assets/imagenes/san-miguel.png', // Ruta de la imagen
            width: 250,
            height: 400,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '© Desarrollado por ',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'Carlos Eduardo López Candelejo',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
