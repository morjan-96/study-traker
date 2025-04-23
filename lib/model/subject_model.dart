class Subject {
  final int? id;
  final String name;
  final double totalHours;

  Subject({this.id, required this.name, this.totalHours = 0});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'totalHours': totalHours};
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      name: map['name'],
      totalHours: map['totalHours'],
    );
  }
}
