class StudySession {
  final int? id;
  final int subjectId;
  final String startTime;
  final String endTime;
  final double duration;

  StudySession({
    this.id,
    required this.subjectId,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectId': subjectId,
      'startTime': startTime,
      'endTime': endTime,
      'duration': duration,
    };
  }

  factory StudySession.fromMap(Map<String, dynamic> map) {
    return StudySession(
      id: map['id'],
      subjectId: map['subjectId'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      duration: map['duration'],
    );
  }
}
