class Gift {
  final String id;
  final String name;
  final double price;
  final String recipient;
  final String occasion;
  final bool isPurchased;

  Gift({
    required this.id,
    required this.name,
    required this.price,
    required this.recipient,
    required this.occasion,
    this.isPurchased = false,
  });

  Gift copyWith({
    String? id,
    String? name,
    double? price,
    String? recipient,
    String? occasion,
    bool? isPurchased,
  }) {
    return Gift(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      recipient: recipient ?? this.recipient,
      occasion: occasion ?? this.occasion,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }
}
