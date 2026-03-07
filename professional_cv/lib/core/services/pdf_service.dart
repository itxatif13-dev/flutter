import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../features/cv/domain/entities/cv_entity.dart';

class PdfService {
  static Future<void> generateAndPrintCV(CVEntity cvData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(cvData.personalInfo.fullName,
                        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    pw.Text(cvData.personalInfo.jobTitle,
                        style: const pw.TextStyle(fontSize: 16)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(cvData.personalInfo.email),
                    pw.Text(cvData.personalInfo.phone),
                    pw.Text(cvData.personalInfo.location),
                  ],
                ),
              ],
            ),
          ),
          pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10)),
          pw.Header(level: 1, text: 'About Me'),
          pw.Paragraph(text: cvData.personalInfo.bio),
          pw.Header(level: 1, text: 'Experience'),
          ...cvData.experience.map((exp) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(exp.position, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(exp.period),
                    ],
                  ),
                  pw.Text(exp.company),
                  pw.Bullet(text: exp.description),
                  pw.SizedBox(height: 10),
                ],
              )),
          pw.Header(level: 1, text: 'Education'),
          ...cvData.education.map((edu) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(edu.degree, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(edu.period),
                    ],
                  ),
                  pw.Text(edu.institution),
                  pw.Text('GPA: ${edu.gpa}'),
                  pw.SizedBox(height: 10),
                ],
              )),
          pw.Header(level: 1, text: 'Skills'),
          pw.Text('Technical: ${cvData.skills.technical.map((s) => s.name).join(", ")}'),
          pw.Text('Soft Skills: ${cvData.skills.softSkills.map((s) => s.name).join(", ")}'),
          pw.Text('Languages: ${cvData.skills.languages.map((s) => s.name).join(", ")}'),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
