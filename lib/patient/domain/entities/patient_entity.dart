import 'dart:convert';

class Patient {
  final String id;
  final String legalGuardianId;
  final String firstname;
  final String lastname;
  final DateTime birthdate;
  final String legalGuardian;
  final String dni;
  final List<String> disability;
  final String gender;
  final String relationshipRepresentativePatient;
  final String healthInsurance;
  final List<String> currentMedications;
  final List<String> allergies;
  final List<String> historyTreatmentsReceived;

  Patient({
    required this.id,
    required this.legalGuardianId,
    required this.firstname,
    required this.lastname,
    required this.birthdate,
    required this.legalGuardian,
    required this.dni,
    required this.disability,
    required this.gender,
    required this.relationshipRepresentativePatient,
    required this.healthInsurance,
    required this.currentMedications,
    required this.allergies,
    required this.historyTreatmentsReceived,
  });

  /// 🔹 **Factory constructor para convertir JSON a `Patient`**
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json["id"],
      legalGuardianId: json["legalGuardianId"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      birthdate: DateTime.parse(json["birthdate"]), // 🔹 Convertir a `DateTime`
      legalGuardian: json["legalGuardian"],
      dni: json["dni"],
      disability: List<String>.from(
          json["disability"]), // 🔹 Convertir lista dinámica a `List<String>`
      gender: json["gender"],
      relationshipRepresentativePatient:
          json["relationshipRepresentativePatient"],
      healthInsurance: json["healthInsurance"],
      currentMedications: List<String>.from(json["currentMedications"]),
      allergies: List<String>.from(json["allergies"]),
      historyTreatmentsReceived:
          List<String>.from(json["historyTreatmentsReceived"]),
    );
  }

  /// 🔹 **Método para convertir `Patient` a JSON**
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "legalGuardianId": legalGuardianId,
      "firstname": firstname,
      "lastname": lastname,
      "birthdate":
          birthdate.toIso8601String(), // 🔹 Convertir `DateTime` a String ISO
      "legalGuardian": legalGuardian,
      "dni": dni,
      "disability": disability,
      "gender": gender,
      "relationshipRepresentativePatient": relationshipRepresentativePatient,
      "healthInsurance": healthInsurance,
      "currentMedications": currentMedications,
      "allergies": allergies,
      "historyTreatmentsReceived": historyTreatmentsReceived,
    };
  }

  /// 🔹 **Método para convertir JSON String a `Patient`**
  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  /// 🔹 **Método para convertir `Patient` a JSON String**
  String toRawJson() => json.encode(toJson());

  /// 🔹 **Método `copyWith` para crear nuevas instancias con valores actualizados**
  Patient copyWith({
    String? id,
    String? legalGuardianId,
    String? firstname,
    String? lastname,
    DateTime? birthdate,
    String? legalGuardian,
    String? dni,
    List<String>? disability,
    String? gender,
    String? relationshipRepresentativePatient,
    String? healthInsurance,
    List<String>? currentMedications,
    List<String>? allergies,
    List<String>? historyTreatmentsReceived,
    String? observations,
  }) {
    return Patient(
      id: id ?? this.id,
      legalGuardianId: legalGuardianId ?? this.legalGuardianId,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      birthdate: birthdate ?? this.birthdate,
      legalGuardian: legalGuardian ?? this.legalGuardian,
      dni: dni ?? this.dni,
      disability: disability ?? this.disability,
      gender: gender ?? this.gender,
      relationshipRepresentativePatient: relationshipRepresentativePatient ??
          this.relationshipRepresentativePatient,
      healthInsurance: healthInsurance ?? this.healthInsurance,
      currentMedications: currentMedications ?? this.currentMedications,
      allergies: allergies ?? this.allergies,
      historyTreatmentsReceived:
          historyTreatmentsReceived ?? this.historyTreatmentsReceived,
    );
  }

  @override
  String toString() {
    return 'Patient(id: $id, firstname: $firstname, lastname: $lastname, dni: $dni, gender: $gender, healthInsurance: $healthInsurance)';
  }
}
