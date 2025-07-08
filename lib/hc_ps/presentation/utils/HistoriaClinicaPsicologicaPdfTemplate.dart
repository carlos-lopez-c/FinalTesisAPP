import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HistoriaClinicaPsicologicaPdfTemplate {
  static Future<String?> guardarYMostrarPdf(
    Map<String, dynamic> datos,
    BuildContext context,
    String cedula,
  ) async {
    try {
      final pdfBytes = await generarPdfPlantilla(datos);
      final dir = Directory('/storage/emulated/0/Documents');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      final filePath =
          '${dir.path}/AreaPsicologia_historiaClinicaAdultos_$cedula.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PDF guardado en: $filePath'),
          duration: const Duration(seconds: 5),
        ));
      }

      return file.path;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al guardar PDF: $e'),
          backgroundColor: Colors.red,
        ));
      }
      return null;
    }
  }

  static Future<Uint8List> generarPdfPlantilla(
      Map<String, dynamic> datos) async {
    final pdf = pw.Document();
    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
    );

    // Cargar la imagen
    final ByteData imageData =
        await rootBundle.load('assets/imagenes/san-miguel.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final pdfImage = pw.MemoryImage(imageBytes);

    // Calcular edad
    final edad = _calcularEdad(datos['fechaNacimiento']);

    // UN SOLO DOCUMENTO CONTINUO
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          // ENCABEZADO SOLO EN LA PRIMERA PÁGINA
          _headerG("", logoImage: pdfImage),
          pw.SizedBox(height: 15),
          _header("HISTORIA CLÍNICA PSICOLÓGICA ADULTOS"),
          pw.SizedBox(height: 15),

          // DATOS DE IDENTIFICACIÓN
          _section("DATOS DE IDENTIFICACIÓN", [
            "Fecha de evaluación: ${_formatDate(datos['fechaEvalucion'])}",
            "Nombre completo: ${datos['nombreCompleto'] ?? ''}",
            "Fecha de nacimiento: ${_formatDate(datos['fechaNacimiento'])}",
            "Edad: $edad",
            "Teléfono: ${datos['telefono'] ?? ''}",
            "Institución: ${datos['institucion'] ?? ''}",
            "Dirección: ${datos['direccion'] ?? ''}",
            "Remisión: ${datos['remision'] ?? ''}",
            "Final de cobertura: ${datos['cobertura'] ?? ''}",
            "Responsable: ${datos['responsable'] ?? ''}",
            // "Estructura familiar: ${datos['estructuraFamiliar'] ?? ''}",
            // "Curso: ${datos['curso'] ?? ''}",
          ]),

          // OBSERVACIONES
          _section(
              "OBSERVACIONES", [datos['observaciones'] ?? 'Sin observaciones']),

          // MOTIVO DE CONSULTA
          _section("MOTIVO DE CONSULTA",
              [datos['motivoConsulta'] ?? 'No especificado']),

          // DESENCADENANTES
          _section("DESENCADENANTES DEL MOTIVO DE CONSULTA",
              [datos['desencadenantesMotivoConsulta'] ?? 'No especificado']),

          // ANTECEDENTES FAMILIARES
          _section("ANTECEDENTES FAMILIARES",
              [datos['antecedenteFamiliares'] ?? 'No especificado']),

          // PRUEBAS APLICADAS
          _section("PRUEBAS APLICADAS",
              [datos['pruebasAplicadas'] ?? 'No especificado']),

          // IMPRESIÓN DIAGNÓSTICA
          _section("IMPRESIÓN DIAGNÓSTICA",
              [datos['impresionDiagnostica'] ?? 'No especificado']),

          // ÁREAS DE INTERVENCIÓN
          _section("ÁREAS DE INTERVENCIÓN",
              [datos['areasIntervecion'] ?? 'No especificado']),

          // INFORMACIÓN ADICIONAL
          _section("INFORMACIÓN ADICIONAL", [
            "Fecha de creación: ${_formatDate(datos['fechaCreacion'])}",
            "ID del paciente: ${datos['patientId'] ?? ''}",
          ]),
        ],
      ),
    );

    return pdf.save();
  }

  // ENCABEZADO CON IMAGEN CENTRADA
  static pw.Widget _headerG(String title, {pw.MemoryImage? logoImage}) {
    return pw.Center(
      child: pw.Container(
        constraints: pw.BoxConstraints(maxWidth: PdfPageFormat.a4.width - 40),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            if (logoImage != null)
              pw.Container(
                width: 180,
                height: 150,
                child: pw.Image(logoImage, fit: pw.BoxFit.contain),
              ),
            if (logoImage != null) pw.SizedBox(width: 15),
            pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'FUNDACION DE NIÑOS ESPECIALES',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '"SAN MIGUEL" FUNESAMI',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'HISTORIA CLÍNICA DE PSICOLOGÍA',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // SECCIÓN CON TÍTULO Y LÍNEAS
  static pw.Widget _header(String title) {
    return pw.Center(
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.red, // Color rojo
        ),
      ),
    );
  }

  static pw.Widget _section(String title, List<String> lines) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: pw.BoxDecoration(
            color: PdfColors.lightBlueAccent,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Text(
            title,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 6),
        ...lines.map((line) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              child: pw.Text(line, style: const pw.TextStyle(fontSize: 11)),
            )),
      ],
    );
  }

  static String _formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return 'No especificada';
    try {
      final date = DateTime.tryParse(isoDate);
      return date != null ? DateFormat('dd/MM/yyyy').format(date) : isoDate;
    } catch (_) {
      return isoDate;
    }
  }

  static String _calcularEdad(String? fechaNacimiento) {
    if (fechaNacimiento == null || fechaNacimiento.isEmpty)
      return 'No especificada';
    try {
      final birthDate = DateTime.parse(fechaNacimiento);
      final today = DateTime.now();
      final age = today.year - birthDate.year;

      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        return '${age - 1} años';
      }

      return '$age años';
    } catch (_) {
      return 'No especificada';
    }
  }
}
