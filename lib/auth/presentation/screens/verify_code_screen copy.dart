import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/CustomCard.dart';
import '/../shared/header.dart';

class VerifyCodeScreen extends ConsumerWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomCard(
      child: Column(
        children: [
          Header(
            imagePath: 'assets/imagenes/san-miguel.png',
            title: 'Fundación de niños especiales',
            subtitle: '"SAN MIGUEL" FUNESAMI',
            item:
                'Verifique su correo electrónico para completar el proceso desde allí.',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
