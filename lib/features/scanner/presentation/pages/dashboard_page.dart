import 'dart:io';

import 'package:ai_doc_scanner/features/scanner/presentation/bloc/document_bloc.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/document_state.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/document_event.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/pages/document_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the BLoC and immediately load documents
      create: (_) => sl<DocumentBloc>()..add(LoadDocuments()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();
  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  final _searchController = TextEditingController();
  String? _selectedCategory;
  final _categories = ['Receipt', 'Invoice', 'ID Card', 'Academic'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Doc Scanner')),
      body: Column(
        children: [
          // Search bar dispatches SearchDocumentsEvent on every keystroke
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search documents...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (q) =>
                  context.read<DocumentBloc>().add(SearchDocuments(q)),
            ),
          ),
          // Category filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: _selectedCategory == null,
                  onSelected: (_) {
                    setState(() => _selectedCategory = null);
                    context.read<DocumentBloc>().add(FilterByCategory(null));
                  },
                ),
                ..._categories.map(
                  (c) => FilterChip(
                    label: Text(c),
                    selected: _selectedCategory == c,
                    onSelected: (_) {
                      setState(() => _selectedCategory = c);
                      context.read<DocumentBloc>().add(FilterByCategory(c));
                    },
                  ),
                ),
              ],
            ),
          ),
          // Document grid responds to BLoC state changes
          Expanded(
            child: BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
                if (state is DocumentLoading)
                  return const Center(child: CircularProgressIndicator());
                if (state is DocumentListError)
                  return Center(child: Text(state.message));
                if (state is DocumentLoaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemCount: state.documents.length,
                    itemBuilder: (context, i) {
                      final doc = state.documents[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DocumentDetailPage(document: doc),
                          ),
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.file(
                                  File(doc.imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(doc.title, overflow: TextOverflow.ellipsis),
                              Chip(label: Text(doc.category)),
                              Text(
                                doc.createdAt.toLocal().toString().substring(
                                  0,
                                  10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      // FAB triggers a new document scan
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<DocumentBloc>().add(ScanDocumentEvent()),
        child: const Icon(Icons.document_scanner),
      ),
    );
  }
}
