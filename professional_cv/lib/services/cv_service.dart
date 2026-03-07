import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/cv_model.dart';

class CVService {
  Future<CVData> loadCVData() async {
    try {
      final String response = await rootBundle.loadString('assets/data/cv_data.json');
      final data = json.decode(response);
      return CVData.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load CV data: $e');
    }
  }
}
