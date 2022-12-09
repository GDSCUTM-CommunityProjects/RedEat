class HistoryInfo {
  final int? id;
  final String name;
  final int calories;

  const HistoryInfo({
    this.id,
    required this.name,
    required this.calories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
    };
  }

  static HistoryInfo fromJson(Map<String, Object?> json) => HistoryInfo(
        id: json['id'] as int?,
        name: json['name'] as String,
        calories: json['calories'] as int,
      );
}