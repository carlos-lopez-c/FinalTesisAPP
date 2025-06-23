import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HistoriaClinicaVozPdfTemplate {
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
      final filePath = '${dir.path}/AreaTerapia_historiaClinicaVoz_$cedula.pdf';
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
          _header("HISTORIA CLINICA DE VOZ"),
          pw.SizedBox(height: 15),
          _section("DATOS DE IDENTIFICACION", [
            "Fecha de Evaluacion: ${_formatDate(datos['fechaDeEvaluacion'])}",
            "Nombre completo: ${datos['nombreCompleto'] ?? ''}",
            "Fecha de nacimiento: ${_formatDate(datos['fechaNacimiento'])}",
            "Estado civil: ${datos['estadoCivil'] ?? ''}",
            "Ocupacion actual: ${datos['ocupacionActual'] ?? ''}",
            "Direccion: ${datos['direccion'] ?? ''}",
            "Telefono de contacto: ${datos['telefonoDeContacto'] ?? ''}",
            "Derivado por: ${datos['derivadoPor'] ?? ''}",
            "Razon de derivacion: ${datos['razonDeDerivacion'] ?? ''}",
            "Diagnostico ORL: ${datos['diagnosticoORL'] ?? ''}",
          ]),
          _section("HISTORIA CLINICA", [
            "Motivo de consulta: ${datos['historiaClinica']?['motivoDeConsulta'] ?? ''}",
            "Es la primera vez que tiene esta dificultad?: ${datos['historiaClinica']?['esLaPrimeraVezQueTieneEstaDificultad'] ?? ''}",
            "Desde cuando tiene esta dificultad?: ${datos['historiaClinica']?['desdeCuandoTieneEstaDificultad'] ?? ''}",
            "Forma de inicio: ${datos['historiaClinica']?['formaDeInicio'] ?? ''}",
            "A que lo atribuye?: ${datos['historiaClinica']?['aQueLoAtribuye'] ?? ''}",
            "Como lo afecta?: ${datos['historiaClinica']?['comoLoAfecta'] ?? ''}",
            "Cuando se agrava?: ${datos['historiaClinica']?['cuandoSeAgrava'] ?? ''}",
            "Como ha sido su evolucion?: ${datos['historiaClinica']?['comoHaSidoSuEvolucion'] ?? ''}",
            "Momento del dia con mayor dificultad: ${datos['historiaClinica']?['momentoDelDiaConMayorDificultad'] ?? ''}",
            "En que situaciones aparecen molestias?: ${datos['historiaClinica']?['enQueSituacionesAparecenMolestias'] ?? ''}",
          ]),
          _section("SINTOMATOLOGIA", [
            "Fonastenia: ${datos['sintomologia']?['fonastenia'] ?? ''}",
            "Fonalgia: ${datos['sintomologia']?['fonalgia'] ?? ''}",
          ]),
          _section("ANTECEDENTES MORBIDOS", [
            "Hay problemas de voz en su familia?: ${datos['antecendentesMorbidos']?['problemasDeVozEnSuFamilia'] ?? ''}",
            "Presenta alguna enfermedad?: ${datos['antecendentesMorbidos']?['presentaAlgunaEnfermedad'] ?? ''}",
            "Las emociones danan su voz?: ${datos['antecendentesMorbidos']?['lasEmocionesDananSuVoz'] ?? ''}",
            "Medicamentos que toma: ${datos['antecendentesMorbidos']?['medicamentosQueToma'] ?? ''}",
            "Accidentes o enfermedades graves: ${datos['antecendentesMorbidos']?['accidentesOenfermedadesGravesQueHayaTenido'] ?? ''}",
            "Ha sido intervenido quirurgicamente?: ${datos['antecendentesMorbidos']?['haSidoIntervenidoQuirurgicamente'] ?? ''}",
            "Ha sido entubado?: ${datos['antecendentesMorbidos']?['haSidoEntubado'] ?? ''}",
            "Ha consultado con otros profesionales?: ${datos['antecendentesMorbidos']?['haConsultadoConOtrosProfesionales'] ?? ''}",
          ]),
          _section("ANTECEDENTES TERAPEUTICOS", [
            "Ha recibido tratamiento foniatrico?: ${_boolToSiNo(datos['antecedentesTerapeuticos']?['haRecibidoTratamientoFoniatico'])}",
            "Cuando?: ${datos['antecedentesTerapeuticos']?['cuando'] ?? ''}",
            "Cuanto tiempo?: ${datos['antecedentesTerapeuticos']?['cuantoTiempo'] ?? ''}",
            "Con que profesional?: ${datos['antecedentesTerapeuticos']?['conQueProfesional'] ?? ''}",
            "Cual fue el resultado?: ${datos['antecedentesTerapeuticos']?['cualFueElResultado'] ?? ''}",
            "Ha recibido tratamiento logopedico?: ${_boolToSiNo(datos['antecedentesTerapeuticos']?['haRecibidoTratamientoLogopedico'])}",
            "Cuando?: ${datos['antecedentesTerapeuticos']?['cuandoLogopedico'] ?? ''}",
            "Cuanto tiempo?: ${datos['antecedentesTerapeuticos']?['cuantoTiempoLogopedico'] ?? ''}",
            "Con que profesional?: ${datos['antecedentesTerapeuticos']?['conQueProfesionalLogopedico'] ?? ''}",
            "Cual fue el resultado?: ${datos['antecedentesTerapeuticos']?['cualFueElResultadoLogopedico'] ?? ''}",
          ]),
          _section("ABUSO VOCAL", [
            "Grita frecuentemente?: ${_boolToSiNo(datos['abusoVocal']?['gritaFrecuentemente'])}",
            "Habla en ambientes ruidosos?: ${_boolToSiNo(datos['abusoVocal']?['hablaEnAmbientesRuidosos'])}",
            "Habla por telefono frecuentemente?: ${_boolToSiNo(datos['abusoVocal']?['hablaPorTelefonoFrecuentemente'])}",
            "Canta frecuentemente?: ${_boolToSiNo(datos['abusoVocal']?['cantaFrecuentemente'])}",
            "Hace imitaciones?: ${_boolToSiNo(datos['abusoVocal']?['haceImitaciones'])}",
            "Habla mucho?: ${_boolToSiNo(datos['abusoVocal']?['hablaMucho'])}",
            "Habla rapido?: ${_boolToSiNo(datos['abusoVocal']?['hablaRapido'])}",
            "Tose frecuentemente?: ${_boolToSiNo(datos['abusoVocal']?['toseFrecuentemente'])}",
            "Se aclara la garganta frecuentemente?: ${_boolToSiNo(datos['abusoVocal']?['seAclaraLaGargantaFrecuentemente'])}",
            "Llora frecuentemente?: ${_boolToSiNo(datos['abusoVocal']?['lloraFrecuentemente'])}",
            "Rie frecuentemente?: ${_boolToSiNo(datos['abusoVocal']?['rieFrecuentemente'])}",
            "Hace deporte?: ${_boolToSiNo(datos['abusoVocal']?['haceDeporte'])}",
            "Que deporte?: ${datos['abusoVocal']?['queDeporte'] ?? ''}",
            "Con que frecuencia?: ${datos['abusoVocal']?['conQueFrecuencia'] ?? ''}",
          ]),
          _section("MAL USO VOCAL", [
            "Habla con tension?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConTension'])}",
            "Habla con respiracion inadecuada?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConRespiracionInadecuada'])}",
            "Habla con postura inadecuada?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConPosturaInadecuada'])}",
            "Habla con tono inadecuado?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConTonoInadecuado'])}",
            "Habla con intensidad inadecuada?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConIntensidadInadecuada'])}",
            "Habla con ritmo inadecuado?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConRitmoInadecuado'])}",
            "Habla con articulacion inadecuada?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConArticulacionInadecuada'])}",
            "Habla con resonancia inadecuada?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConResonanciaInadecuada'])}",
            "Habla con coordinacion inadecuada?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConCoordinacionInadecuada'])}",
            "Habla con fonacion inadecuada?: ${_boolToSiNo(datos['malUsoVocal']?['hablaConFonacionInadecuada'])}",
          ]),
          _section("FACTORES EXTERNOS", [
            "Fuma?: ${_boolToSiNo(datos['factoresExternos']?['fuma'])}",
            "Cuantos cigarrillos al dia?: ${datos['factoresExternos']?['cuantosCigarrillosAlDia'] ?? ''}",
            "Desde cuando?: ${datos['factoresExternos']?['desdeCuando'] ?? ''}",
            "Bebe alcohol?: ${_boolToSiNo(datos['factoresExternos']?['bebeAlcohol'])}",
            "Que tipo?: ${datos['factoresExternos']?['queTipo'] ?? ''}",
            "Con que frecuencia?: ${datos['factoresExternos']?['conQueFrecuencia'] ?? ''}",
            "Consume drogas?: ${_boolToSiNo(datos['factoresExternos']?['consumeDrogas'])}",
            "Que tipo?: ${datos['factoresExternos']?['queTipoDroga'] ?? ''}",
            "Con que frecuencia?: ${datos['factoresExternos']?['conQueFrecuenciaDroga'] ?? ''}",
            "Esta expuesto a polvo?: ${_boolToSiNo(datos['factoresExternos']?['estaExpuestoAPolvo'])}",
            "Esta expuesto a humo?: ${_boolToSiNo(datos['factoresExternos']?['estaExpuestoAHumo'])}",
            "Esta expuesto a productos quimicos?: ${_boolToSiNo(datos['factoresExternos']?['estaExpuestoAProductosQuimicos'])}",
            "Esta expuesto a cambios de temperatura?: ${_boolToSiNo(datos['factoresExternos']?['estaExpuestoACambiosDeTemperatura'])}",
            "Esta expuesto a aire acondicionado?: ${_boolToSiNo(datos['factoresExternos']?['estaExpuestoAAireAcondicionado'])}",
            "Esta expuesto a calefaccion?: ${_boolToSiNo(datos['factoresExternos']?['estaExpuestoACalefaccion'])}",
          ]),
          _section("HABITOS GENERALES", [
            "Cuanto tiempo duerme?: ${datos['habitosGenerales']?['cuantoTiempo'] ?? ''}",
            "Horas de sueno: ${datos['habitosGenerales']?['horasDeSueno'] ?? ''}",
            "Duerme bien?: ${_boolToSiNo(datos['habitosGenerales']?['duermeBien'])}",
            "Tiene problemas para dormir?: ${_boolToSiNo(datos['habitosGenerales']?['tieneProblemasParaDormir'])}",
            "Que problemas?: ${datos['habitosGenerales']?['queProblemas'] ?? ''}",
            "Toma medicamentos para dormir?: ${_boolToSiNo(datos['habitosGenerales']?['tomaMedicamentosParaDormir'])}",
            "Que medicamentos?: ${datos['habitosGenerales']?['queMedicamentos'] ?? ''}",
            "Tiene una dieta equilibrada?: ${_boolToSiNo(datos['habitosGenerales']?['tieneUnaDietaEquilibrada'])}",
            "Bebe suficiente agua?: ${_boolToSiNo(datos['habitosGenerales']?['bebeSuficienteAgua'])}",
            "Cuanta agua bebe al dia?: ${datos['habitosGenerales']?['cuantaAguaBebeAlDia'] ?? ''}",
            "Hace ejercicio?: ${_boolToSiNo(datos['habitosGenerales']?['haceEjercicio'])}",
            "Que tipo de ejercicio?: ${datos['habitosGenerales']?['queTipoDeEjercicio'] ?? ''}",
            "Con que frecuencia?: ${datos['habitosGenerales']?['conQueFrecuenciaEjercicio'] ?? ''}",
            "Tiene estres?: ${_boolToSiNo(datos['habitosGenerales']?['tieneEstres'])}",
            "Que tipo de estres?: ${datos['habitosGenerales']?['queTipoDeEstres'] ?? ''}",
            "Como maneja el estres?: ${datos['habitosGenerales']?['comoManejaElEstres'] ?? ''}",
          ]),
          _section("USO LABORAL Y PROFESIONAL DE LA VOZ", [
            "Horas de trabajo: ${datos['usoLaboralProfesionalDeLaVoz']?['horasDeTrabajo'] ?? ''}",
            "Postura para trabajar: ${datos['usoLaboralProfesionalDeLaVoz']?['posturaParaTrabajar'] ?? ''}",
            "Utiliza su voz de forma prolongada?: ${datos['usoLaboralProfesionalDeLaVoz']?['utilizaSuVozDeFormaProlongada'] ?? ''}",
            "Realiza reposo vocal durante la jornada laboral?: ${datos['usoLaboralProfesionalDeLaVoz']?['realizaReposoVocalDuranteLaJornadaLaboral'] ?? ''}",
            "Ingiere liquidos durante la jornada laboral?: ${datos['usoLaboralProfesionalDeLaVoz']?['ingieroLiquidosDuranteLaJornadaLaboral'] ?? ''}",
            "Utiliza amplificacion para cantar?: ${datos['usoLaboralProfesionalDeLaVoz']?['utilizaAmplificacionParaCantar'] ?? ''}",
            "Asiste a clases con profesionales de la voz?: ${datos['usoLaboralProfesionalDeLaVoz']?['asisteAClasesConProfesionalesDeLaVoz'] ?? ''}",
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
                  'HISTORIA CLINICA DE TERAPIAS',
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
