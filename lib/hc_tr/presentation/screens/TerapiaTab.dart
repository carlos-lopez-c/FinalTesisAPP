import 'package:flutter/material.dart';
import '/hc_tr/presentation/screens/hc_anam_adult.dart';
import '/hc_tr/presentation/screens/hc_anam_voz.dart';
import '/hc_tr/presentation/screens/hc_general_screen.dart';
import '/shared/header.dart';
// import 'hc_ninos_screen.dart';

class Terapiatab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 16),
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
                      '"SAN MIGUEL" FUNESAMI',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF1976D2),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'MENÚ DE HISTORIAS CLÍNICAS DEL ÁREA DE TERAPIAS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Tarjetas de opciones
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MenuCard(
                    imagePath: 'assets/imagenes/historia-clinica.png',
                    title: 'Historia Clínica General',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HcTrGeneral()),
                    ),
                  ),
                  const SizedBox(width: 24),
                  _MenuCard(
                    imagePath: 'assets/imagenes/adult.png',
                    title: 'Anamnesis Alimentaria Adultos',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HcTrAnamAdult()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Tarjeta de Anamnesis de voz
              Center(
                child: _MenuCard(
                  imagePath: 'assets/imagenes/voz.png',
                  title: 'Anamnesis de voz',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HcTrAnamVoz()),
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

class _MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
