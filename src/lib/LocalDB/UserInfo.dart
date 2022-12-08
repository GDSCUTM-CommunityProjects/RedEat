class UserInfo {
  final int id;
  final String name;
  final int weight;
  final int height;
  final int goalStatus;

  const UserInfo({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.goalStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'goalStatus': goalStatus,
    };
  }
}
