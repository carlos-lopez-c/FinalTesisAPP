import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HistoriaClinicaPdfTemplate {
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
          '${dir.path}/AreaTerapia_historiaClinicaAdult_$cedula.pdf';
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

    final ByteData imageData =
        await rootBundle.load('assets/imagenes/san-miguel.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final pdfImage = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          _headerG("", logoImage: pdfImage),
          pw.SizedBox(height: 15),
          _header("HISTORIA CLÍNICA ADULTO"),
          pw.SizedBox(height: 15),
          _section("DATOS DE IDENTIFICACIÓN", [
            "Fecha de Evaluacion: ${_formatDate(datos['fechaEvalucion'])}",
            "Nombre completo: ${datos['nombreCompleto'] ?? ''}",
            "Lateralidad: ${datos['lateralidad'] ?? ''}",
          ]),
          _section("INDEPENDENCIA Y AUTONOMIA", [
            "Se alimenta solo(a) o necesita ayuda?: ${datos['independenciaAutonomia']?['seAlimentaSoloOConAyuda'] ?? 'No especificado'}",
            "Que tipo de ayuda necesita?: ${datos['independenciaAutonomia']?['queTipoDeAyudaNecesita'] ?? ''}",
            "Prepara sus propio alimentos?: ${_boolToSiNo(datos['independenciaAutonomia']?['preparaSusAlimentos'])}",
            "Por que?: ${datos['independenciaAutonomia']?['quePrepara'] ?? ''}",
            "Decide que comer?: ${_boolToSiNo(datos['independenciaAutonomia']?['decideQueComer'])}",
          ]),
          _section("EFICIENCIA", [
            "Consume la totalidad del alimento?: ${_boolToSiNo(datos['eficiencia']?['consumeLaTotalidadDeLosAlimentos'])}",
            "Que porcion consume?: ${datos['eficiencia']?['quePorcionConsume'] ?? ''}",
            "Has presentado perdidas de peso?: ${_boolToSiNo(datos['eficiencia']?['haPresentadoPerdidasImportantesDePesoEnElUltimoTiempo'])}",
            "Cuantos Kilos?: ${datos['eficiencia']?['cuantoPesoHaPerdido'] ?? ''}",
            "Manifiesta interes por alimentarse?: ${_boolToSiNo(datos['eficiencia']?['manifiestaInteresPorAlimentarse'])}",
            "Manifiesta rechazo o preferencias?: ${_boolToSiNo(datos['eficiencia']?['manifiestaRechazoOPreferenciasPorAlgunTipoDeAlimento'])}",
            "Que tipo de alimento?: ${datos['eficiencia']?['queTipoDeAlimento'] ?? ''}",
            "Que tipo de liquido consume?: ${datos['eficiencia']?['queTipoDeLiquidoConsumeHabitualmente'] ?? ''}",
            "Cuanto liquido consume al dia?: ${datos['eficiencia']?['cuantoLiquidoConsumeAlDia'] ?? ''}",
          ]),
          _section("SEGURIDAD", [
            "Se atora con su saliva?: ${_boolToSiNo(datos['seguridad']?['seAtoraConSuSaliva'])}",
            "Con que frecuencia?: ${datos['seguridad']?['conQueFrecuencia'] ?? ''}",
            "Tiene tos o ahogos cuando se alimenta?: ${_boolToSiNo(datos['seguridad']?['tieneTosOAhogosCuandoSeAlimentaOConsumeMedicamentos'])}",
            "Con que alimento/liquido/medicamento?: ${datos['seguridad']?['conQueAlimentosLiquidosMedicamentos'] ?? ''}",
            "Presenta dificultad para tomar liquidos?: ${_boolToSiNo(datos['seguridad']?['presentaAlgunaDificultadParaTomarLiquidosDeUnVaso'])}",
            "Presenta dificultad con sopas o granos?: ${_boolToSiNo(datos['seguridad']?['presentaDificultadConSopasOLosGranosPequenosComoArroz'])}",
            "Ha presentado neumonias?: ${_boolToSiNo(datos['seguridad']?['haPresentadoNeumonias'])}",
            "Con que frecuencia presento neumonias?: ${datos['seguridad']?['conQueFrecuenciaPresentoNeumonia'] ?? ''}",
            "Se queda con restos de alimento en la boca?: ${_boolToSiNo(datos['seguridad']?['seQuedaConRestosDeAlimentosEnLaBocaLuegoDeAlimentarse'])}",
            "Siente que el alimento se va hacia su nariz?: ${_boolToSiNo(datos['seguridad']?['sienteQueElAlimentoSeVaHaciaSuNariz'])}",
          ]),
          _section("PROCESO DE ALIMENTACIÓN", [
            "Se demora mas tiempo que el resto?: ${_boolToSiNo(datos['procesoDeAlimentacion']?['seDemoraMasTiempoQueElRestoDeLaFamiliaEnComer'])}",
            "Cuanto tiempo?: ${datos['procesoDeAlimentacion']?['cuantoTiempo'] ?? ''}",
            "Cree que come muy rapido?: ${_boolToSiNo(datos['procesoDeAlimentacion']?['creeUstedQueComeMuyRapido'])}",
            "Suele realizar alguna otra actividad mientras come?: ${_boolToSiNo(datos['procesoDeAlimentacion']?['sueleRealizarAlgunaOtraActividadMientrasCome'])}",
            "Que otra actividad?: ${datos['procesoDeAlimentacion']?['queOtraActividad'] ?? ''}",
          ]),
          _section("SALUD BUCAL", [
            "Cuenta con todas sus piezas dentales?: ${_boolToSiNo(datos['saludBocal']?['cuentaConTodasSusPiezasDentales'])}",
            "Por que?: ${datos['saludBocal']?['porQueNoCuentaConTodasSusPiezasDentales'] ?? ''}",
            "Utiliza placa dental?: ${_boolToSiNo(datos['saludBocal']?['utilizaPlacaDental'])}",
            "Se realiza aseo bucal despues de cada comida?: ${_boolToSiNo(datos['saludBocal']?['seRealizaAseoBucalDespuesDeCadaComida'])}",
            "Con que frecuencia se lava los dientes?: ${datos['saludBocal']?['conQueFrecuenciaSeLavaLosDientes'] ?? ''}",
            "Asiste regularmente a controles dentales?: ${_boolToSiNo(datos['saludBocal']?['asisteRegularmenteAControlesDentales'])}",
            "Con que frecuencia?: ${datos['saludBocal']?['conQueFrecuenciaAsisteAControlesDentales'] ?? ''}",
            "Tiene alguna molestia o dolor dentro de su boca?: ${_boolToSiNo(datos['saludBocal']?['tieneAlgunaMolestiaODolorDentroDeSuBoca'])}",
            "Que molestia o dolor presenta?: ${datos['saludBocal']?['queMolestiaODolor'] ?? ''}",
          ]),
        ],
      ),
    );

    return pdf.save();
  }

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
                  'HISTORIA CLÍNICA DE TERAPIAS',
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

  static pw.Widget _header(String title) {
    return pw.Center(
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.red,
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

  static String _boolToSiNo(dynamic value) {
    if (value == true) return 'SI';
    if (value == false) return 'NO';
    return '';
  }
}
