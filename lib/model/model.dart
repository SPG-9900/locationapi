class Transporter {
  final double searchScore;
  final String transporterId;
  final String transporterName;
  final String logo;

  Transporter({
    required this.searchScore,
    required this.transporterId,
    required this.transporterName,
    required this.logo,
  });

  factory Transporter.fromJson(Map<String, dynamic> json) {
    return Transporter(
      searchScore: json['@search.score'] ?? 0.0,
      transporterId: json['transporter_id'] ?? '',
      transporterName: json['transporter_name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}
