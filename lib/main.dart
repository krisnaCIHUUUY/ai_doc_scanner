import 'package:ai_doc_scanner/core/di/injection_container.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
    );
  }
}
