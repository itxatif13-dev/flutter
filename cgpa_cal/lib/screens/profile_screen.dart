import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student_model.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isFirstTime;
  const ProfileScreen({super.key, this.isFirstTime = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _universityController;
  late TextEditingController _idController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _departmentController;

  @override
  void initState() {
    super.initState();
    final student = Provider.of<AppProvider>(context, listen: false).student;
    _nameController = TextEditingController(text: student?.name ?? '');
    _universityController = TextEditingController(text: student?.university ?? '');
    _idController = TextEditingController(text: student?.studentId ?? '');
    _emailController = TextEditingController(text: student?.email ?? '');
    _addressController = TextEditingController(text: student?.address ?? '');
    _departmentController = TextEditingController(text: student?.department ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _universityController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        name: _nameController.text.trim(),
        university: _universityController.text.trim(),
        studentId: _idController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        department: _departmentController.text.trim(),
      );
      Provider.of<AppProvider>(context, listen: false).updateStudent(student);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully!'),
          backgroundColor: AppConstants.accentColor,
          behavior: SnackBarBehavior.floating,
        ),
      );

      if (widget.isFirstTime) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(widget.isFirstTime ? 'Setup Profile' : 'Edit Profile', 
          style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: AppConstants.primaryGradient),
          ),
        ),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: !widget.isFirstTime,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.isFirstTime) ...[
                const Icon(Icons.account_circle, size: 80, color: AppConstants.primaryColor),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Welcome! Please set up your profile to continue.',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
              ],
              _buildSectionHeader('Personal Information'),
              const SizedBox(height: 16),
              _buildTextField(_nameController, 'Full Name', Icons.person),
              const SizedBox(height: 16),
              _buildTextField(_emailController, 'Email Address', Icons.email, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(_addressController, 'Home Address', Icons.home, maxLines: 2),
              const SizedBox(height: 24),
              _buildSectionHeader('Academic Details'),
              const SizedBox(height: 16),
              _buildTextField(_universityController, 'University Name', Icons.school),
              const SizedBox(height: 16),
              _buildTextField(_departmentController, 'Department', Icons.account_tree),
              const SizedBox(height: 16),
              _buildTextField(_idController, 'Student ID', Icons.badge),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                child: Text(widget.isFirstTime ? 'Finish Setup' : 'Save Changes', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              if (!widget.isFirstTime)
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Discard Changes', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppConstants.secondaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppConstants.primaryColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: (value) => (value == null || value.isEmpty) ? 'Required field' : null,
      ),
    );
  }
}
