import 'dart:io';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/filter_event.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/services/image_filter_service.dart';
import '../../domain/entities/document.dart';
import '../bloc/filter_bloc.dart';

class DocumentDetailPage extends StatelessWidget {
  final Document document;
  const DocumentDetailPage({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    // Provide the ImageFilterBloc to this page's widget tree
    return BlocProvider(
      create: (_) => sl<ImageFilterBloc>(),
      child: _DocumentDetailView(document: document),
    );
  }
}

class _DocumentDetailView extends StatelessWidget {
  final Document document;
  const _DocumentDetailView({required this.document});

  // Share/open the generated PDF. The share sheet also offers "Open with",
  // so a PDF viewer can be picked from there.
  Future<void> _sharePdf(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    // ML Kit may return the uri with a file:// scheme; XFile needs a plain path.
    final path = document.pdfPath.replaceFirst(RegExp(r'^file://'), '');
    if (path.isEmpty || !File(path).existsSync()) {
      messenger.showSnackBar(
        const SnackBar(content: Text('PDF tidak tersedia untuk dokumen ini.')),
      );
      return;
    }
    await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImageFilterBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(document.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Buka / Bagikan PDF',
            onPressed: () => _sharePdf(context),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Bagikan gambar',
            onPressed: () async {
              await SharePlus.instance.share(
                ShareParams(files: [XFile(document.imagePath)]),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reactive image display with loading overlay
            BlocBuilder<ImageFilterBloc, ImageFilterState>(
              builder: (context, state) {
                String displayPath = document.imagePath;
                bool loading = false;
                if (state is ImageFilterProcessing) loading = true;
                if (state is ImageFilterApplied) {
                  displayPath = state.filteredImagePath;
                }
                return Stack(
                  children: [
                    Image.file(File(displayPath)),
                    if (loading)
                      const Positioned.fill(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            // Filter selection row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => bloc.add(
                    ApplyFilter(
                      imagePath: document.imagePath,
                      filter: ImageFilter.original,
                    ),
                  ),
                  child: const Text('Original'),
                ),
                TextButton(
                  onPressed: () => bloc.add(
                    ApplyFilter(
                      imagePath: document.imagePath,
                      filter: ImageFilter.grayscale,
                    ),
                  ),
                  child: const Text('Grayscale'),
                ),
                TextButton(
                  onPressed: () => bloc.add(
                    ApplyFilter(
                      imagePath: document.imagePath,
                      filter: ImageFilter.highContrast,
                    ),
                  ),
                  child: const Text('High Contrast'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Chip(label: Text(document.category)),
            Text('Scanned: ${document.createdAt.toLocal()}'),
            const SizedBox(height: 16),
            const Text(
              'Extracted Text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(document.ocrText),
          ],
        ),
      ),
    );
  }
}
