class HistoryInfo {
  final int id;
  final String name;
  final int calories;

  const HistoryInfo({
    required this.id,
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
}