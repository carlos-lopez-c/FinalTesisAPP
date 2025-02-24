class CreateAppointments {
  String patientId;
  DateTime date;
  String appointmentTime;
  String medicalInsurance;
  String doctorId;
  String patient;
  String status;
  String specialtyTherapyId;
  String diagnosis;

  CreateAppointments({
    required this.patientId,
    required this.date,
    required this.appointmentTime,
    required this.medicalInsurance,
    required this.doctorId,
    required this.patient,
    required this.status,
    required this.specialtyTherapyId,
    required this.diagnosis,
  });

  CreateAppointments copyWith({
    String? patientId,
    DateTime? date,
    String? patient,
    String? status,
    String? appointmentTime,
    String? medicalInsurance,
    String? doctorId,
    String? specialtyTherapyId,
    String? diagnosis,
  }) {
    return CreateAppointments(
      patientId: patientId ?? this.patientId,
      date: date ?? this.date,
      patient: patient ?? this.patient,
      status: status ?? this.status,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      medicalInsurance: medicalInsurance ?? this.medicalInsurance,
      doctorId: doctorId ?? this.doctorId,
      specialtyTherapyId: specialtyTherapyId ?? this.specialtyTherapyId,
      diagnosis: diagnosis ?? this.diagnosis,
    );
  }

  //To Json
  Map<String, dynamic> toJson() {
    return {
      'patientID': patientId,
      'date':
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      'appointmentTime': appointmentTime,
      'medicalInsurance': medicalInsurance,
      'doctorID': doctorId,
      'patient': patient,
      'status': status,
      'specialtyTherapyId': specialtyTherapyId,
      'diagnosis': diagnosis,
    };
  }
}
