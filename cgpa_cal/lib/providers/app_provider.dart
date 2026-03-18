import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student_model.dart';
import '../models/semester_model.dart';

class AppProvider with ChangeNotifier {
  Student? _student;
  List<Semester> _semesters = [];
  bool _isLoading = true;

  Student? get student => _student;
  List<Semester> get semesters => _semesters;
  bool get isLoading => _isLoading;

  AppProvider() {
    loadData();
  }

  void updateStudent(Student student) {
    _student = student;
    saveData();
    notifyListeners();
  }

  void addSemester(Semester semester) {
    _semesters.add(semester);
    saveData();
    notifyListeners();
  }

  void updateSemester(String id, Semester semester) {
    final index = _semesters.indexWhere((s) => s.id == id);
    if (index != -1) {
      _semesters[index] = semester;
      saveData();
      notifyListeners();
    }
  }

  void deleteSemester(String id) {
    _semesters.removeWhere((s) => s.id == id);
    saveData();
    notifyListeners();
  }

  double calculateCGPA() {
    if (_semesters.isEmpty) return 0.0;
    double totalGradePoints = 0;
    int totalCreditsAll = 0;

    for (var semester in _semesters) {
      totalGradePoints += (semester.gpa * semester.totalCredits);
      totalCreditsAll += semester.totalCredits;
    }

    return totalCreditsAll > 0 ? totalGradePoints / totalCreditsAll : 0.0;
  }

  int getTotalCredits() {
    return _semesters.fold(0, (sum, item) => sum + item.totalCredits);
  }

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    final studentJson = prefs.getString('student');
    if (studentJson != null) {
      _student = Student.fromJson(jsonDecode(studentJson));
    }

    final semestersJson = prefs.getString('semesters');
    if (semestersJson != null) {
      final List<dynamic> decoded = jsonDecode(semestersJson);
      _semesters = decoded.map((item) => Semester.fromJson(item)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_student != null) {
      prefs.setString('student', jsonEncode(_student!.toJson()));
    }
    prefs.setString('semesters', jsonEncode(_semesters.map((s) => s.toJson()).toList()));
  }
}
