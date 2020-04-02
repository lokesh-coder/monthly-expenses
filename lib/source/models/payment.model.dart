class Payment {
  final String id;
  final String label;
  final int lastModifiedTime;
  final int createdTime;
  final int date;
  final bool isCredit;
  final double amount;
  final String categoryID;

  Payment({
    this.id,
    this.label,
    this.lastModifiedTime,
    this.createdTime,
    this.date,
    this.isCredit,
    this.amount,
    this.categoryID,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json["id"],
      label: json["label"],
      lastModifiedTime: json["lastModifiedTime"],
      createdTime: json["createdTime"],
      date: json["date"],
      isCredit: json["isCredit"],
      amount: json["amount"],
      categoryID: json["categoryID"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'label': label,
        'lastModifiedTime': lastModifiedTime,
        'date': date,
        'createdTime': createdTime,
        'isCredit': isCredit,
        'amount': amount,
        'categoryID': categoryID,
      };
}
