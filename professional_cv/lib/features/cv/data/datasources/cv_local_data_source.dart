import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/cv_model.dart';

abstract class CVLocalDataSource {
  Future<CVModel> getCVData();
}

class CVLocalDataSourceImpl implements CVLocalDataSource {
  @override
  Future<CVModel> getCVData() async {
    final String response = await rootBundle.loadString('assets/data/cv_data.json');
    final data = await json.decode(response);
    return CVModel.fromJson(data);
  }
}
