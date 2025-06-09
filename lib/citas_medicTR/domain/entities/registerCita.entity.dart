class CreateAppointments {
  String? id;
  String patientId;
  DateTime date;
  String? doctor;
  String appointmentTime;
  String medicalInsurance;
  String doctorId;
  String patient;
  String status;
  String specialtyTherapyId;
  String diagnosis;

  CreateAppointments({
    required this.patientId,
    this.id,
    this.doctor,
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
    String? id,
    String? patientId,
    DateTime? date,
    String? doctor,
    String? patient,
    String? status,
    String? appointmentTime,
    String? medicalInsurance,
    String? doctorId,
    String? specialtyTherapyId,
    String? diagnosis,
  }) {
    return CreateAppointments(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      date: date ?? this.date,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
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
      'id': id,
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
