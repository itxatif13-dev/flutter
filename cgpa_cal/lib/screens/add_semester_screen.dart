import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/course_model.dart';
import '../models/semester_model.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import '../widgets/course_card.dart';

class AddSemesterScreen extends StatefulWidget {
  final Semester? semester;

  const AddSemesterScreen({super.key, this.semester});

  @override
  State<AddSemesterScreen> createState() => _AddSemesterScreenState();
}

class _AddSemesterScreenState extends State<AddSemesterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _semesterNameController = TextEditingController();
  final List<Course> _courses = [];
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.semester != null) {
      _semesterNameController.text = widget.semester!.semesterName;
      _courses.addAll(widget.semester!.courses.map((c) => Course(
            id: c.id,
            courseName: c.courseName,
            creditHours: c.creditHours,
            gradePoints: c.gradePoints,
            grade: c.grade,
          )));
    }
  }

  @override
  void dispose() {
    _semesterNameController.dispose();
    super.dispose();
  }

  double get _currentGPA {
    if (_courses.isEmpty) return 0.0;
    double totalPoints = 0;
    int totalCredits = 0;
    for (var course in _courses) {
      totalPoints += (course.creditHours * course.gradePoints);
      totalCredits += course.creditHours;
    }
    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  int get _totalCredits => _courses.fold(0, (sum, item) => sum + item.creditHours);

  void _showAddCourseDialog() {
    String? courseName;
    int selectedCredits = 3;
    double marks = 0.0;
    String currentCalculatedGrade = 'F';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Add New Course', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  prefixIcon: const Icon(Icons.book_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onChanged: (value) => courseName = value,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: selectedCredits,
                      decoration: InputDecoration(
                        labelText: 'Credits',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      items: AppConstants.creditHoursOptions.map((h) {
                        return DropdownMenuItem(value: h, child: Text('$h Credits'));
                      }).toList(),
                      onChanged: (value) => setModalState(() => selectedCredits = value!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Enter Marks (0-100)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        helperText: 'Auto-calculates Grade: $currentCalculatedGrade',
                        helperStyle: const TextStyle(color: AppConstants.primaryColor, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          marks = double.tryParse(value) ?? 0.0;
                          currentCalculatedGrade = AppConstants.getGrade(marks);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (courseName != null && courseName!.isNotEmpty) {
                    setState(() {
                      _courses.add(Course(
                        id: _uuid.v4(),
                        courseName: courseName!,
                        creditHours: selectedCredits,
                        gradePoints: AppConstants.gradePoints[currentCalculatedGrade]!,
                        grade: currentCalculatedGrade,
                      ));
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Add Course', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(widget.semester == null ? 'Add Semester' : 'Edit Semester', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: AppConstants.primaryGradient))),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _semesterNameController,
                decoration: InputDecoration(
                  labelText: 'Semester Name (e.g. Semester 1)',
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter semester name' : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Courses List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                TextButton.icon(
                  onPressed: _showAddCourseDialog,
                  icon: const Icon(Icons.add, color: AppConstants.primaryColor),
                  label: const Text('Add Course', style: TextStyle(color: AppConstants.primaryColor, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: _courses.isEmpty
                ? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.library_books_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      const Text('No courses added yet', style: TextStyle(color: Colors.grey)),
                    ],
                  ))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(
                        course: _courses[index],
                        onDelete: () => setState(() => _courses.removeAt(index)),
                      );
                    },
                  ),
          ),
          _buildSummarySection(),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Expected GPA', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                  Text(
                    _currentGPA.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppConstants.primaryColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Total Credits', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                  Text(
                    '$_totalCredits',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveSemester,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
            ),
            child: const Text('Save Semester', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _saveSemester() {
    if (_formKey.currentState!.validate()) {
      if (_courses.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add at least one course!')));
        return;
      }
      final semester = Semester(
        id: widget.semester?.id ?? _uuid.v4(),
        semesterName: _semesterNameController.text.trim(),
        gpa: _currentGPA,
        totalCredits: _totalCredits,
        courses: _courses,
      );
      final provider = Provider.of<AppProvider>(context, listen: false);
      if (widget.semester == null) provider.addSemester(semester);
      else provider.updateSemester(semester.id, semester);
      Navigator.pop(context);
    }
  }
}
