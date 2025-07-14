import 'package:flutter/material.dart';

class headerPSWidget extends StatelessWidget {
  final String textoDinamico;

  const headerPSWidget({
    Key? key,
    required this.textoDinamico,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/imagenes/san-miguel.png',
            width: 100,
            height: 115,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'FUNDACIÓN DE NIÑOS ESPECIALES',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '“SAN MIGUEL” FUNESAMI',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Acuerdo Ministerial 078-08',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'HISTORIA CLÍNICA PSICOLÓGICA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                textoDinamico,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 255, 0, 0),
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
