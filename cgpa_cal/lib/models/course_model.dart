class Course {
  String id;
  String courseName;
  int creditHours;
  double gradePoints;
  String grade;

  Course({
    required this.id,
    required this.courseName,
    required this.creditHours,
    required this.gradePoints,
    required this.grade,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseName': courseName,
        'creditHours': creditHours,
        'gradePoints': gradePoints,
        'grade': grade,
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'],
        courseName: json['courseName'],
        creditHours: json['creditHours'],
        gradePoints: json['gradePoints'],
        grade: json['grade'],
      );
}
