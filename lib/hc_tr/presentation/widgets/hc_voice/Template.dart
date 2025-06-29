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
          _section("SINTOMATOLOGÍA", [
            "Fonestenia: ${datos['sintomologia']?['fonastenia'] ?? ''}",
            "Fonalgia (dolor al hablar): ${datos['sintomologia']?['fonalgia'] ?? ''}",
            "Tensión en fonación: ${_boolToSiNo(datos['sintomologia']?['tensionEnFonacion'])}",
            "Sensación de constricción en el cuello: ${_boolToSiNo(datos['sintomologia']?['sensacionDeConstriccionEnElCuello'])}",
            "Sensación de cuerpo extraño: ${_boolToSiNo(datos['sintomologia']?['sensacionDeCuerpoExtrano'])}",
            "Descarga posterior: ${_boolToSiNo(datos['sintomologia']?['descargaPosterior'])}",
            "Odinofagia: ${_boolToSiNo(datos['sintomologia']?['odinofagia'])}",
            "Extensión tonal reducida: ${_boolToSiNo(datos['sintomologia']?['extensionTonalReducida'])}",
            "Picor laríngeo: ${_boolToSiNo(datos['sintomologia']?['picorLaringeo'])}",
          ]),
          _section("ANTECEDENTES MÓRBIDOS", [
            "Existen problemas de voz en su familia ¿Cuáles?: ${datos['antecendentesMorbidos']?['problemasDeVozEnSuFamilia'] ?? ''}",
            "¿Presenta alguna enfermedad?: ${datos['antecendentesMorbidos']?['presentaAlgunaEnfermedad'] ?? ''}",
            "¿Sufre de estrés?: ${_boolToSiNo(datos['antecendentesMorbidos']?['sufreDeEstres'])}",
            "¿Las emociones dañan su voz?: ${datos['antecendentesMorbidos']?['lasEmocionesDananSuVoz'] ?? ''}",
            "¿Utiliza algún medicamento? ¿Cuáles?: ${datos['antecendentesMorbidos']?['medicamentosQueToma'] ?? ''}",
            "¿Ha sufrido accidentes, enfermedades graves, hospitalizaciones, etc?: ${datos['antecendentesMorbidos']?['accidentesOenfermedadesGravesQueHayaTenido'] ?? ''}",
            "¿Ha sido intervenido quirúrgicamente?¿Por qué?: ${datos['antecendentesMorbidos']?['haSidoIntervenidoQuirurgicamente'] ?? ''}",
            "¿Ha sido entubado?¿Por cuánto tiempo?: ${datos['antecendentesMorbidos']?['haSidoEntubado'] ?? ''}",
            "¿Ha consultado con otros profesionales?: ${datos['antecendentesMorbidos']?['haConsultadoConOtrosProfesionales'] ?? ''}",
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
            "Tose en exceso: ${_boolToSiNo(datos['abusoVocal']?['toseEnExceso'])}",
            "Grita en exceso: ${_boolToSiNo(datos['abusoVocal']?['gritaEnExceso'])}",
            "Habla mucho: ${_boolToSiNo(datos['abusoVocal']?['hablaMucho'])}",
            "Habla rápido: ${_boolToSiNo(datos['abusoVocal']?['hablaRapido'])}",
            "Imita voces: ${_boolToSiNo(datos['abusoVocal']?['imitaVoces'])}",
            "Habla con exceso de ruido: ${_boolToSiNo(datos['abusoVocal']?['hablaConExcesoDeRuido'])}",
            "Reduce el uso de la voz en resfríos: ${_boolToSiNo(datos['abusoVocal']?['reduceElUsoDeLaVozEnResfrios'])}",
            "Carraspea en exceso: ${_boolToSiNo(datos['abusoVocal']?['carraspeaEnExceso'])}",
            "Habla forzando la voz: ${_boolToSiNo(datos['abusoVocal']?['hablaForzandoLaVoz'])}",
            "Habla al mismo tiempo que otras personas: ${_boolToSiNo(datos['abusoVocal']?['hablaAlMismoTiempoQueOtrasPersonas'])}",
            "Habla con dientes, hombro y cuello apretado: ${_boolToSiNo(datos['abusoVocal']?['hablaConDientesHombroYCuelloApretados'])}",
          ]),
          _section("MAL USO VOCAL", [
            "Trata de hablar con un tono más agudo o grave que el suyo: ${_boolToSiNo(datos['malUsoVocal']?['trataDeHablarConUnTonoMasAgudoOGraveQueElSuyo'])}",
            "Trata de hablar con un volumen de voz más débil o alto de lo usual: ${_boolToSiNo(datos['malUsoVocal']?['trataDeHablarConUnVolumenMasDebilOAltoDeLoUsual'])}",
            "Canta fuera de registro: ${_boolToSiNo(datos['malUsoVocal']?['cantaFueraDeSuRegistro'])}",
            "Canta sin vocalizar: ${_boolToSiNo(datos['malUsoVocal']?['cantaSinVocalizar'])}",
          ]),
          _section("FACTORES EXTERNOS", [
            "Vive en ambiente de fumadores: ${_boolToSiNo(datos['factoresExternos']?['viveEnAmbienteDeFumadores'])}",
            "Trabaja en un ambiente ruidoso: ${_boolToSiNo(datos['factoresExternos']?['trabajaEnAmbienteRuidoso'])}",
            "Permanece en ambiente con aire acondicionado: ${_boolToSiNo(datos['factoresExternos']?['permaneceEnAmbientesConAireAcondicionado'])}",
            "Permanece en ambientes con poca ventilación: ${_boolToSiNo(datos['factoresExternos']?['permaneceEnAmbientesConPocaVentilacion'])}",
            "Se expone a cambios bruscos de temperatura: ${_boolToSiNo(datos['factoresExternos']?['seExponeACambiosBruscosDeTemperatura'])}",
          ]),
          _section("HÁBITOS GENERALES", [
            "Realiza reposo vocal: ${_boolToSiNo(datos['habitosGenerales']?['realizaReposoVocal'])}",
            "Cuánto tiempo: ${datos['habitosGenerales']?['cuantoTiempo'] ?? ''}",
            "Habla mucho tiempo sin beber líquido: ${_boolToSiNo(datos['habitosGenerales']?['hablaMuchoTiempoSinBebeLiquido'])}",
            "Asiste al otorrinolaringólogo: ${_boolToSiNo(datos['habitosGenerales']?['asisteAlOtorrinolaringologo'])}",
            "Consume alimentos muy condimentados: ${_boolToSiNo(datos['habitosGenerales']?['consumeAlimentosMuyCondimentados'])}",
            "Consume alimentos muy calientes o muy fríos: ${_boolToSiNo(datos['habitosGenerales']?['consumeAlimentosMuyCalientesOMuyFrios'])}",
            "Consume bebidas alcohólicas: ${_boolToSiNo(datos['habitosGenerales']?['consumeAlcohol'])}",
            "Fuma: ${_boolToSiNo(datos['habitosGenerales']?['consumeTabaco'])}",
            "Consume café: ${_boolToSiNo(datos['habitosGenerales']?['consumeCafe'])}",
            "Consume drogas: ${_boolToSiNo(datos['habitosGenerales']?['consumeDrogas'])}",
            "Utiliza ropa ajustada: ${_boolToSiNo(datos['habitosGenerales']?['utilizaRopaAjustada'])}",
            "Cuántas horas duerme: ${datos['habitosGenerales']?['horasDeSueno'] ?? ''}",
          ]),
          _section("USO LABORAL Y PROFESIONAL DE LA VOZ", [
            "Cuántas horas trabaja: ${datos['usoLaboralProfesionalDeLaVoz']?['horasDeTrabajo'] ?? ''}",
            "Cuál es su postura para trabajar: ${datos['usoLaboralProfesionalDeLaVoz']?['posturaParaTrabajar'] ?? ''}",
            "Utiliza su voz de forma prolongada durante la jornada laboral: ${datos['usoLaboralProfesionalDeLaVoz']?['utilizaSuVozDeFormaProlongada'] ?? ''}",
            "Realiza reposo vocal durante su jornada laboral: ${datos['usoLaboralProfesionalDeLaVoz']?['realizaReposoVocalDuranteLaJornadaLaboral'] ?? ''}",
            "Ingiere líquidos durante su trabajo: ${datos['usoLaboralProfesionalDeLaVoz']?['ingieroLiquidosDuranteLaJornadaLaboral'] ?? ''}",
            "Utiliza amplificación para cantar: ${datos['usoLaboralProfesionalDeLaVoz']?['utilizaAmplificacionParaCantar'] ?? ''}",
            "Asiste a clases con profesionales de la voz: ${datos['usoLaboralProfesionalDeLaVoz']?['asisteAClasesConProfesionalesDeLaVoz'] ?? ''}",
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
