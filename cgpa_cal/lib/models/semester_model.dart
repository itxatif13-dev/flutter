import 'course_model.dart';

class Semester {
  String id;
  String semesterName;
  double gpa;
  int totalCredits;
  List<Course> courses;

  Semester({
    required this.id,
    required this.semesterName,
    required this.gpa,
    required this.totalCredits,
    required this.courses,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'semesterName': semesterName,
        'gpa': gpa,
        'totalCredits': totalCredits,
        'courses': courses.map((x) => x.toJson()).toList(),
      };

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        id: json['id'],
        semesterName: json['semesterName'],
        gpa: (json['gpa'] as num).toDouble(),
        totalCredits: json['totalCredits'],
        courses: List<Course>.from(json['courses'].map((x) => Course.fromJson(x))),
      );
}
