class Dealocation {
  final String id;
  final String dealocationReason;
  final String employeeName;

  Dealocation({
    required this.id,
    required this.dealocationReason,
    required this.employeeName,
  });

  //to/from map
  factory Dealocation.fromMap(Map<String, dynamic> map) {
    return Dealocation(
      id: map['id'],
      dealocationReason: map['comment'],
      employeeName: map['employeeName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dealocationReason': dealocationReason,
      'employeeName': employeeName,
    };
  }
}
