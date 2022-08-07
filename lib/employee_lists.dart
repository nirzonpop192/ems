import 'package:cloud_firestore/cloud_firestore.dart';

class AgEmployeesInProject {
  final String id;
  final String fullName;
  final String firstName;
  final String lastName;
  final String address;

  final int? number;
  final String? role;
  final String? speciality;
  final bool? hasTrackLicense;
  final bool? hasMechanicSkills;
  

  final String? yrke;
  final int? nr;
  final String? kolonne1;
  final String? licence;
  final String ? language;

  final DateTime startDate;
  DateTime? endDate;
  int? groupId;
  int? xLedgerKey;
  String? shift;

  AgEmployeesInProject({
    required this.id,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.address,

    required this.number,
    required this.role,
    required this.speciality,
    required this.hasMechanicSkills,
    required this.hasTrackLicense,

    required this.yrke,
    required this.nr,
    required this.kolonne1,
    required this.licence,
    required this.language,

    required this.startDate,
  });

  bool get hasLeft => (endDate != null);
  bool get hasShift => (shift != null);

  static AgEmployeesInProject fromFirebase(
      var fbId, Map<String, dynamic> fbData) {
    AgEmployeesInProject newUser = AgEmployeesInProject(
      id: fbId,
      fullName: fbData['fullName'],
      firstName: fbData['firstName'],
      lastName: fbData['surName'],
      address: fbData['address'],
      number: fbData['agNumber'],
      role: fbData['agRole'],
      speciality: fbData['agSpeciality'],
      hasMechanicSkills: fbData['hasMechanicSkills'],
      hasTrackLicense: fbData['hasTrackLicense'],
      yrke: fbData['yrke'],
      nr: fbData['nr'],
      kolonne1: fbData['kolonne1'],
      licence: fbData['licence'],
      language: fbData['licence'],

      startDate: (fbData['startDate'] as Timestamp).toDate(),
    );
    newUser.endDate = (fbData['endDate'] == null)
        ? null
        : (fbData['endDate'] as Timestamp).toDate();
    newUser.groupId = (fbData['group'] == null) ? 0 : fbData['group'];
    newUser.xLedgerKey =
        (fbData['xledgerKey'] == null) ? 0 : fbData['xledgerKey'];
    newUser.shift = fbData['shift'];
    return newUser;
  }

  @override
  String toString() {
    return "AgEmployeesInProject {\n"
        "  id: $id\n"
        "  fullName: $fullName\n"
        "  firstName: $firstName\n"
        "  lastName: $lastName\n"
        "  address: $address\n"

        " yrker: $yrke\n"
        " nr: $nr\n"
        " kolonne1: $kolonne1\n"
        " licence: $licence\n"
        " language: $language\n"

        "  startDate: $startDate\n"
        "  endDate: $endDate\n"
        "  groupId: $groupId\n"
        "  xLedgerKey: $xLedgerKey\n"
        "  shift: $shift\n"
        "}";
  }
}



getShift(test) {
  if (test == "Dag 1") {
    final Stream<QuerySnapshot> agTunnelEmployeesShift = FirebaseFirestore
        .instance
        .collection("employees")
        .where('shift', isEqualTo: "Dag 1")
        .where('endDate', isEqualTo: null)
        .orderBy('surName')
        .snapshots();
    return agTunnelEmployeesShift;
  } else if (test == "Natt 1") {
    final Stream<QuerySnapshot> agTunnelEmployeesShift = FirebaseFirestore
        .instance
        .collection("employees")
        .where('shift', isEqualTo: "Natt 1")
        .where('endDate', isEqualTo: null)
        .orderBy('surName')
        .snapshots();
    return agTunnelEmployeesShift;
  } else if (test == "Dag 2") {
    final Stream<QuerySnapshot> agTunnelEmployeesShift = FirebaseFirestore
        .instance
        .collection("employees")
        .where('shift', isEqualTo: "Dag 2")
        .where('endDate', isEqualTo: null)
        .orderBy('surName')
        .snapshots();
    return agTunnelEmployeesShift;
  } else if (test == "Natt 2") {
    final Stream<QuerySnapshot> agTunnelEmployeesShift = FirebaseFirestore
        .instance
        .collection("employees")
        .where('shift', isEqualTo: "Natt 2")
        .where('endDate', isEqualTo: null)
        .orderBy('surName')
        .snapshots();
    return agTunnelEmployeesShift;
  } else {
    return "Fail";
  }
}

getShiftCollection(test) {
  if (test == "Dag 1") {
    final collectionShift = FirebaseFirestore.instance
        .collection("projects")
        .doc("zyi6jwxZ6IRug6PzuaUs")
        .collection("Dag 1");
    return collectionShift;
  } else if (test == "Natt 1") {
    final collectionShift = FirebaseFirestore.instance
        .collection("projects")
        .doc("zyi6jwxZ6IRug6PzuaUs")
        .collection("Natt 1");
    return collectionShift;
  } else if (test == "Dag 2") {
    final collectionShift = FirebaseFirestore.instance
        .collection("projects")
        .doc("zyi6jwxZ6IRug6PzuaUs")
        .collection("Dag 2");
    return collectionShift;
  } else if (test == "Natt 2") {
    final collectionShift = FirebaseFirestore.instance
        .collection("projects")
        .doc("zyi6jwxZ6IRug6PzuaUs")
        .collection("Natt 2");
    return collectionShift;
  } else {
    return "Fail";
  }
}
