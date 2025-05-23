import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../providers/grounding_provider.dart';
import 'package:pdf/widgets.dart' as pw;

/// Displays a summary of all user observations.
class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(groundingProvider);
    final notifier = ref.read(groundingProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return ListTile(
                    title: Text(entry.sense),
                    subtitle: Text(entry.items.join(', ')),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    notifier.reset();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Restart'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Printing.layoutPdf(onLayout: (format) async {
                      final doc = pw.Document();
                      doc.addPage(
                        pw.Page(
                          build: (pw.Context context) {
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: entries
                                  .map((e) => pw.Text(
                                      '${e.sense}: ${e.items.join(', ')}'))
                                  .toList(),
                            );
                          },
                        ),
                      );
                      return doc.save();
                    });
                  },
                  child: const Text('Share as PDF'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
