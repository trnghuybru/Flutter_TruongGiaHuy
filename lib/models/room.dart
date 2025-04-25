class Room {
  final int id;
  final String tenantName;
  final String phoneNumber;
  final String startDate;
  final String paymentType;
  final String note;
  bool isSelected;

  Room({
    required this.id,
    required this.tenantName,
    required this.phoneNumber,
    required this.startDate,
    required this.paymentType,
    required this.note,
    this.isSelected = false,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      tenantName: json['tenant_name'],
      phoneNumber: json['phone_number'],
      startDate: json['start_date'],
      paymentType: json['payment_type'],
      note: json['note'] ?? "",
    );
  }
}
