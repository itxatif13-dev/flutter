class Student {
  final String name;
  final String university;
  final String studentId;
  final String email;
  final String address;
  final String department;

  Student({
    required this.name,
    required this.university,
    required this.studentId,
    required this.email,
    required this.address,
    required this.department,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'university': university,
        'studentId': studentId,
        'email': email,
        'address': address,
        'department': department,
      };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        name: json['name'] ?? '',
        university: json['university'] ?? '',
        studentId: json['studentId'] ?? '',
        email: json['email'] ?? '',
        address: json['address'] ?? '',
        department: json['department'] ?? '',
      );
}
