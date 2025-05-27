import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class HistoriaClinicaPdfTemplate {
  // Verifica permisos de almacenamiento en Android < 11 (opcional)
  static Future<bool> verificarPermisos() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }

  // Guarda el PDF en una ruta accesible de forma segura
  static Future<String?> guardarPdfPlantilla() async {
    try {
      final pdfBytes = await generarPdfPlantilla();

      // Ruta segura para Android 13+
      final dir = await getExternalStorageDirectory();
      if (dir == null) {
        print('No se pudo acceder al almacenamiento externo.');
        return null;
      }

      final folder = Directory('${dir.path}/TerapPS');
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final formatter = DateFormat('yyyyMMdd_HHmmss');
      final fileName =
          'historia_clinica_${formatter.format(DateTime.now())}.pdf';
      final filePath = '${folder.path}/$fileName';

      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      print('PDF guardado en: $filePath');
      return filePath;
    } catch (e) {
      print('Error al guardar el PDF: $e');
      return null;
    }
  }

  static Future<void> mostrarVistaPreviaPdf(BuildContext context) async {
    try {
      final pdfBytes = await generarPdfPlantilla();
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => Dialog(
            insetPadding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: PdfPreview(
                canChangeOrientation: false,
                canChangePageFormat: false,
                canDebug: false,
                pdfFileName: 'plantilla_historia_clinica.pdf',
                build: (format) => pdfBytes,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print('Error al mostrar el PDF: $e');
    }
  }

  static Future<bool> compartirPdfPlantilla() async {
    try {
      final pdfBytes = await generarPdfPlantilla();
      final fileName =
          'historia_clinica_${DateTime.now().millisecondsSinceEpoch}.pdf';
      return await Printing.sharePdf(bytes: pdfBytes, filename: fileName);
    } catch (e) {
      print('Error al compartir PDF: $e');
      return false;
    }
  }

  static Future<Uint8List> generarPdfPlantilla() async {
    final pdf = pw.Document();
    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
      italic: pw.Font.helveticaOblique(),
    );

    pdf.addPage(crearPortada(theme));
    return pdf.save();
  }

  static pw.Page crearPortada(pw.ThemeData theme) {
    final fecha = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      theme: theme,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(
            'HISTORIA CLÍNICA\nFecha: $fecha',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        );
      },
    );
  }
}
