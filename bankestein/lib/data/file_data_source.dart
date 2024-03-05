import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

abstract class FileDataSource {
  static Future<void> exportAndSave(String accountName, String iban) async {
    // créer un document
    final pdf = pw.Document();

    // ajouter une page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Relevé d\'Identité Bancaire',
                  style: pw.TextStyle(
                    fontSize: 50,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Divider(),
                pw.SizedBox(height: 20),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 20),
                  child: pw.Wrap(
                    alignment: pw.WrapAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Account Name :',
                        style: pw.TextStyle(
                            fontSize: 30, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        accountName,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 20),
                  child: pw.Wrap(
                    alignment: pw.WrapAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'IBAN :',
                        style: pw.TextStyle(
                            fontSize: 30, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        iban,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final Directory? directory = await getDownloadsDirectory();
    final String? path = directory?.path;

    final file = File('$path/rib.pdf');

    await file.writeAsBytes(await pdf.save());

    if (await file.exists()) {
      print('Le fichier existe.');
      OpenFile.open(file.path);
    } else {
      print('Le fichier n\'existe pas.');
    }
  }
}
