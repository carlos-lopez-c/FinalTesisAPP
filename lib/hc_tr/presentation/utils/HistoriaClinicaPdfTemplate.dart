import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importación necesaria para rootBundle
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
          '${dir.path}/AreaTerapia_historiaClinicaGeneral_$cedula.pdf';
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

    // Calcular edad si no viene
    final edad = datos['edad'] ?? _calcularEdad(datos['fechaNacimiento']);

    // PÁGINA 1 - Información básica y antecedentes personales
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          _headerG("", logoImage: pdfImage),
          pw.SizedBox(height: 15),
          _header("HISTORIA CLÍNICA GENERAL"),
          pw.SizedBox(height: 15),
          _section("DATOS DE IDENTIFICACIÓN", [
            "Fecha de entrevista: ${_formatDate(datos['fechaEntrevista'])}",
            "Nombre completo: ${datos['nombreCompleto'] ?? ''}",
            "Sexo: ${datos['sexo'] ?? ''}",
            "Fecha de nacimiento: ${_formatDate(datos['fechaNacimiento'])}",
            "Edad: $edad",
            "Escolaridad: ${datos['escolaridad'] ?? ''}",
            "Institución: ${datos['nombreDeInstitucion'] ?? ''} (${datos['tipoDeInstitucion'] ?? ''})",
            "Domicilio: ${datos['domicilio'] ?? ''}",
            "Teléfono: ${datos['telefono'] ?? ''}",
            "Correo electrónico: ${datos['email'] ?? ''}",
            "Entrevistado por: ${datos['entrevistadoPor'] ?? ''}",
            "Remitido por: ${datos['remitidoPor'] ?? ''}",
          ]),
          _section("MOTIVO DE CONSULTA",
              [datos['motivoDeConsulta'] ?? 'No especificado']),
          _section("CARACTERIZACIÓN DEL PROBLEMA",
              [datos['caracterizacionDelProblema'] ?? 'No especificado']),
        ],
      ),
    );

    // PÁGINA 2 - Antecedentes personales
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          _header("ANTECEDENTES PERSONALES"),
          pw.SizedBox(height: 10),
          _sectionWithBooleans(
              "Durante el embarazo", datos['antecedentesPersonales'] ?? {}, [
            'deseado|Embarazo deseado',
            'automedicacion|Automedicación',
            'depresion|Depresión',
            'estres|Estrés',
            'ansiedad|Ansiedad',
            'traumatismo|Traumatismo',
            'radiaciones|Radiaciones',
            'medicina|Medicación',
            'riesgoDeAborto|Riesgo de aborto',
            'maltratoFisico|Maltrato físico',
            'consumoDeDrogas|Consumo de drogas',
            'consumoDeAlcohol|Consumo de alcohol',
            'consumoDeTabaco|Consumo de tabaco',
            'hipertension|Hipertensión',
            'dietaBalanceada|Dieta balanceada',
          ]),
        ],
      ),
    );

    // PÁGINA 3 - Antecedentes perinatales
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          final perinatales = datos['antecedentesPerinatales'] ?? {};
          final alNacerNecesito = perinatales['alNacerNecesito'] ?? {};
          final alNacerPresento = perinatales['alNacerPresento'] ?? {};

          return [
            _header("ANTECEDENTES PERINATALES"),
            pw.SizedBox(height: 10),
            _section("Datos del parto", [
              "Duración de la gestación: ${perinatales['duracionDeLaGestacion'] ?? ''}",
              "Lugar de atención: ${perinatales['lugarDeAtencion'] ?? ''}",
              "Tipo de parto: ${perinatales['tipoDeParto'] ?? ''}",
              "Duración del parto: ${perinatales['duracionDelParto'] ?? ''}",
              "Presentación: ${perinatales['presentacion'] ?? ''}",
              "Lloró al nacer: ${_boolToSiNo(perinatales['lloroAlNacer'])}",
              "Sufrimiento fetal: ${_boolToSiNo(perinatales['sufrimientoFetal'])}",
            ]),
            _section("Al nacer necesitó", [
              "Incubadora: ${_boolToSiNo(alNacerNecesito['incubadora'])}",
              "Oxígeno: ${_boolToSiNo(alNacerNecesito['oxigeno'])}",
              "Tiempo: ${alNacerNecesito['tiempo'] ?? 'No especificado'}",
            ]),
            _sectionWithBooleans("Al nacer presentó", alNacerPresento, [
              'cianosis|Cianosis',
              'ictericia|Ictericia',
              'malformaciones|Malformaciones',
              'circulacionDelCordonEnElCuello|Circulación del cordón en el cuello',
              'sufrimientoFetal|Sufrimiento fetal',
            ]),
            _section("Medidas al nacer", [
              "Peso: ${alNacerPresento['peso'] ?? ''} kg",
              "Talla: ${alNacerPresento['talla'] ?? ''} cm",
              "Perímetro cefálico: ${alNacerPresento['perimetroCefalico'] ?? ''} cm",
              "APGAR: ${alNacerPresento['apgar'] ?? ''}",
            ]),
            _section("Observaciones",
                [perinatales['observaciones'] ?? 'Sin observaciones']),
          ];
        },
      ),
    );

    // PÁGINA 4 - Antecedentes postnatales (Alimentación y desarrollo motor)
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          final postnatales = datos['antecedentesPerinatales']
                  ?['antecedentesPostnatales'] ??
              {};
          final alimentacion = postnatales['alimentacion'] ?? {};
          final motorGrueso = postnatales['desarrolloMotorGrueso'] ?? {};
          final reflejos = postnatales['reflejosPrimitivos'] ?? {};

          return [
            _header("ANTECEDENTES POSTNATALES"),
            pw.SizedBox(height: 10),
            _sectionWithBooleans("Alimentación", alimentacion, [
              'materna|Lactancia materna',
              'artificial|Lactancia artificial',
              'maticacion|Masticación adecuada',
            ]),
            _sectionWithBooleans("Desarrollo motor grueso", motorGrueso, [
              'controlCefalico|Control cefálico',
              'gateo|Gateo',
              'marcha|Marcha',
              'sedestacion|Sedestación',
              'sincinesias|Sincinesias',
              'subeBajaGradas|Sube/baja gradas',
              'rotacionPies|Rotación de pies',
            ]),
            _sectionWithBooleans("Reflejos primitivos", reflejos, [
              'palmar|Palmar',
              'moro|Moro',
              'presion|Presión',
              'deBusqueda|De búsqueda',
              'banbiski|Babinski',
            ]),
          ];
        },
      ),
    );

    // PÁGINA 5 - Desarrollo motor fino y especificaciones
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          final postnatales = datos['antecedentesPerinatales']
                  ?['antecedentesPostnatales'] ??
              {};
          final motorFino = postnatales['desarrolloMotorFino'] ?? {};
          final especificaciones = postnatales['especificaciones'] ?? {};

          return [
            _header("DESARROLLO MOTOR FINO Y CONDUCTAS"),
            pw.SizedBox(height: 10),
            _sectionWithBooleans("Desarrollo motor fino", motorFino, [
              'pinzaDigital|Pinza digital',
              'garabateo|Garabateo',
              'sostenerObjetos|Sostener objetos',
              'problemasAlimenticios|Problemas alimenticios',
              'garabato|Garabato',
              'ticsMotores|Tics motores',
              'ticsVocales|Tics vocales',
              'conductasProblematicas|Conductas problemáticas',
              'sonrisaSocial|Sonrisa social',
              'movimientosEstereotipados|Movimientos estereotipados',
              'manipulaPermanentementeUnObjeto|Manipula permanentemente un objeto',
              'balanceos|Balanceos',
              'juegoRepetitivo|Juego repetitivo',
              'tendenciaARutinas|Tendencia a rutinas',
              'caminaSinSentido|Camina sin sentido',
              'problemaDeSueno|Problema de sueño',
              'reiteraTemasFavoritos|Reitera temas favoritos',
              'caminaEnPuntitas|Camina en puntitas',
              'irritabilidad|Irritabilidad',
              'manipulaPermanentementeAlgo|Manipula permanentemente algo',
              'iniciaYMantieneConversaciones|Inicia y mantiene conversaciones',
              'ecolalia|Ecolalia',
              'conocimientoDeAlgunTema|Conocimiento profundo de algún tema',
              'lenguajeLiteral|Lenguaje literal',
              'miraALosOjos|Mira a los ojos',
              'otrosSistemasDeComunicacion|Otros sistemas de comunicación',
              'selectivoEnLaComida|Selectivo en la comida',
              'intencionComunicativa|Intención comunicativa',
              'interesRestringido|Interés restringido',
              'angustiaSinCausa|Angustia sin causa',
              'preferenciaPorAlgunAlimento|Preferencia por algún alimento',
              'sonidosExtranos|Sonidos extraños',
              'hablaComoAdulto|Habla como adulto',
              'frioParaHablar|Frío para hablar',
              'pensamientosObsesivos|Pensamientos obsesivos',
              'cambioDeCaracterExtremo|Cambio de carácter extremo',
              'ingenuo|Ingenuo',
              'torpezaMotriz|Torpeza motriz',
              'frioEmocional|Frío emocional',
              'pocosAmigos|Pocos amigos',
              'juegoImaginativo|Juego imaginativo',
            ]),
            _section("ESPECIFICACIONES MÉDICAS", [
              "Hospitalizaciones: ${especificaciones['intensionComunicativaHospitalizaciones'] ?? 'No'}",
              "Traumatismo: ${especificaciones['traumatismo'] ?? 'No'}",
              "Infecciones: ${especificaciones['infecciones'] ?? 'No'}",
              "Reacciones peculiares a vacunas: ${especificaciones['reaccionesPeculiaresVacunas'] ?? 'No'}",
              "Desnutrición u obesidad: ${especificaciones['desnutricionOObesidad'] ?? 'No'}",
              "Cirugías: ${especificaciones['cirugias'] ?? 'No'}",
              "Convulsiones: ${especificaciones['convulsiones'] ?? 'No'}",
              "Medicación: ${especificaciones['medicacion'] ?? 'No'}",
              "Síndromes: ${especificaciones['sindromes'] ?? 'No'}",
              "Estudios diagnósticos: ${especificaciones['diagnosticStudies'] ?? 'No'}",
              "Observaciones: ${especificaciones['observaciones'] ?? 'Sin observaciones'}",
            ]),
          ];
        },
      ),
    );

    // PÁGINA 6 - Hábitos personales y aspectos sociales
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          final habitosPersonales = datos['antecedentesPerinatales']
                  ?['antecedentesPostnatales']?['habitosPersonales'] ??
              {};
          final comportamiento =
              habitosPersonales['comportamientoGeneral'] ?? {};
          final socializacion =
              habitosPersonales['aspectosSocializacion'] ?? {};
          final datosFamiliares = habitosPersonales['datosFamiliares'] ?? {};
          final integracionSensorial =
              habitosPersonales['integracionSensorial'] ?? {};

          return [
            _header("HÁBITOS PERSONALES Y ASPECTOS SOCIALES"),
            pw.SizedBox(height: 10),
            _sectionWithBooleans("Cuando se enoja", habitosPersonales, [
              'berrinches|Hace berrinches',
              'insulta|Insulta',
              'llora|Llora',
              'grita|Grita',
              'agrede|Agrede',
              'seEncierra|Se encierra',
              'pideAyuda|Pide ayuda',
              'pegaALosPadres|Pega a los padres',
            ]),
            _section("Información académica", [
              "Aptitudes e intereses escolares: ${habitosPersonales['aptitudesEInteresesEscolares'] ?? ''}",
              "Rendimiento general escolaridad: ${habitosPersonales['rendimientoGeneralEscolaridad'] ?? ''}",
            ]),
            _sectionWithBooleans("Comportamiento general", comportamiento, [
              'agresivo|Agresivo',
              'pasivo|Pasivo',
              'destructor|Destructor',
              'sociable|Sociable',
              'hipercinetico|Hipercinético',
              'empatia|Empatía',
              'interesesPeculiares|Intereses peculiares',
              'interesPorInteraccion|Interés por interacción',
            ]),
            _section("Quién vive en casa",
                [habitosPersonales['quienViveEnCasa'] ?? 'No especificado']),
            _sectionWithBooleans(
                "Integración sensorial", integracionSensorial, [
              'vista|Vista',
              'oido|Oído',
              'tacto|Tacto',
              'gustoYolfato|Gusto y olfato',
            ]),
          ];
        },
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

  static pw.Widget _sectionWithBooleans(
      String title, Map<String, dynamic> data, List<String> fields) {
    final List<String> lines = [];
    final List<String> activeFields = [];
    final List<String> inactiveFields = [];

    for (final field in fields) {
      final parts = field.split('|');
      final key = parts[0];
      final label = parts.length > 1 ? parts[1] : key;
      final value = data[key];

      if (value == true) {
        activeFields.add(label);
      } else if (value == false) {
        inactiveFields.add(label);
      }
    }

    if (activeFields.isNotEmpty) {
      lines.add("Presenta: ${activeFields.join(', ')}");
    }

    if (inactiveFields.isNotEmpty) {
      lines.add("No presenta: ${inactiveFields.join(', ')}");
    }

    if (lines.isEmpty) {
      lines.add("Sin información disponible");
    }

    return _section(title, lines);
  }

  static String _boolToSiNo(dynamic value) {
    if (value == true) return 'Sí';
    if (value == false) return 'No';
    return 'No especificado';
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

  static String _booleanGroupToString(Map<String, dynamic> grupo) {
    final activos = grupo.entries
        .where((e) => e.value == true)
        .map((e) => _humanizeFieldName(e.key))
        .toList();
    return activos.isEmpty ? 'Sin antecedentes relevantes' : activos.join(', ');
  }

  static String _humanizeFieldName(String fieldName) {
    // Convierte nombres de campos en texto legible
    final map = {
      'deseado': 'Embarazo deseado',
      'automedicacion': 'Automedicación',
      'depresion': 'Depresión',
      'estres': 'Estrés',
      'ansiedad': 'Ansiedad',
      'traumatismo': 'Traumatismo',
      'radiaciones': 'Radiaciones',
      'medicina': 'Medicación',
      'riesgoDeAborto': 'Riesgo de aborto',
      'maltratoFisico': 'Maltrato físico',
      'consumoDeDrogas': 'Consumo de drogas',
      'consumoDeAlcohol': 'Consumo de alcohol',
      'consumoDeTabaco': 'Consumo de tabaco',
      'hipertension': 'Hipertensión',
      'dietaBalanceada': 'Dieta balanceada',
    };

    return map[fieldName] ?? fieldName;
  }
}
