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
          '${dir.path}/AreaPsicologia_historiaClinicaNinos_$cedula.pdf';
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
          _headerG("HISTORIA CLÍNICA DE NIÑOS - ÁREA DE PSICOLOGÍA",
              logoImage: pdfImage),
          pw.SizedBox(height: 15),
          _header("HISTORIA CLÍNICA DE NIÑOS - ÁREA DE PSICOLOGÍA"),
          pw.SizedBox(height: 15),

          // DATOS DE IDENTIFICACIÓN
          _section("DATOS DE IDENTIFICACIÓN", [
            "Fecha de evaluación: " + _formatDate(datos['fechaEvaluacion']),
            "Nombre completo: ${datos['nombreCompleto'] ?? ''}",
            "Fecha de nacimiento: ${_formatDate(datos['fechaNacimiento'])}",
            "Edad: $edad",
            "Teléfono: ${datos['telefono'] ?? ''}",
            "Institución: ${datos['institucion'] ?? ''}",
            "Dirección: ${datos['direccion'] ?? ''}",
            "Remisión: ${datos['remision'] ?? ''}",
            "Final de cobertura: ${datos['cobertura'] ?? ''}",
            "Responsable: ${datos['responsable'] ?? ''}",
          ]),

          // Sección 2: Motivo de consulta
          _section("2. MOTIVO DE CONSULTA",
              [datos['motivoConsulta'] ?? 'No especificado']),

          // Sección 3: Desencadenantes de motivo de consulta
          _section("3. DESENCADENANTES DE MOTIVO DE CONSULTA",
              [datos['desencadenantesMotivoConsulta'] ?? 'No especificado']),

          // Sección 4: Antecedentes familiares (campos amplios uno debajo del otro)
          _section("4. ANTECEDENTES FAMILIARES", [
            "Datos de embarazo y parto: ${datos['datosEmbarazoParto'] ?? ''}",
            "Desarrollo psicomotor: ${datos['datosPsicomotor'] ?? ''}",
            "Desarrollo del lenguaje: ${datos['desarrolloLenguaje'] ?? ''}",
            "Desarrollo intelectual: ${datos['desarrolloIntelectual'] ?? ''}",
            "Desarrollo socio-afectivo: ${datos['desarrolloSocioAfectivo'] ?? ''}",
          ]),

          // Sección 5: Antecedentes y estructura familiar
          _section("5. ANTECEDENTES Y ESTRUCTURA FAMILIAR",
              [datos['estructuraFamiliar'] ?? '']),

          // Sección 6: Pruebas aplicadas
          _section("6. PRUEBAS APLICADAS", [datos['pruebasAplicadas'] ?? '']),

          // Sección 7: Impresión diagnóstica
          _section("7. IMPRESIÓN DIAGNÓSTICA",
              [datos['impresionDiagnostica'] ?? '']),

          // Sección 8: Áreas de intervención
          _section(
              "8. ÁREAS DE INTERVENCIÓN", [datos['areasIntervencion'] ?? '']),
        ],
      ),
    );

    return pdf.save();
  }

  static Future<Uint8List> generarPdfPlantillaAdulto(
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
    final edad = datos['edad'] ?? _calcularEdad(datos['fechaNacimiento']);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          _headerG("HISTORIA CLÍNICA DE ADULTOS - ÁREA DE PSICOLOGÍA",
              logoImage: pdfImage),
          pw.SizedBox(height: 15),
          _header("HISTORIA CLÍNICA DE ADULTOS - ÁREA DE PSICOLOGÍA"),
          pw.SizedBox(height: 15),

          // DATOS DE IDENTIFICACIÓN
          _section("DATOS DE IDENTIFICACIÓN", [
            "Fecha de evaluación: " +
                _formatDate(
                    datos['fechaEvalucion'] ?? datos['fechaEvaluacion']),
            "Nombre completo: ${datos['nombreCompleto'] ?? ''}",
            "Fecha de nacimiento: ${_formatDate(datos['fechaNacimiento'])}",
            "Edad: $edad",
            "Teléfono: ${datos['telefono'] ?? ''}",
            "Institución: ${datos['institucion'] ?? ''}",
            "Dirección: ${datos['direccion'] ?? ''}",
            "Remisión: ${datos['remision'] ?? ''}",
            "Final de cobertura: ${datos['cobertura'] ?? ''}",
            "Responsable: ${datos['responsable'] ?? ''}",
          ]),

          // Sección 2: Motivo de consulta
          _section("2. MOTIVO DE CONSULTA",
              [datos['motivoConsulta'] ?? 'No especificado']),

          // Sección 3: Desencadenantes de motivo de consulta
          _section("3. DESENCADENANTES DE MOTIVO DE CONSULTA",
              [datos['desencadenantesMotivoConsulta'] ?? 'No especificado']),

          // Sección 4: Antecedentes familiares (campo amplio)
          _section("4. ANTECEDENTES FAMILIARES",
              [datos['antecedenteFamiliares'] ?? '']),

          // Sección 5: Antecedentes y estructura familiar
          _section("5. ANTECEDENTES Y ESTRUCTURA FAMILIAR",
              [datos['estructuraFamiliar'] ?? '']),

          // Sección 6: Pruebas aplicadas
          _section("6. PRUEBAS APLICADAS", [datos['pruebasAplicadas'] ?? '']),

          // Sección 7: Impresión diagnóstica
          _section("7. IMPRESIÓN DIAGNÓSTICA",
              [datos['impresionDiagnostica'] ?? '']),

          // Sección 8: Áreas de intervención
          _section(
              "8. ÁREAS DE INTERVENCIÓN", [datos['areasIntervecion'] ?? '']),
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
