import 'package:flutter/material.dart';

import 'app/rentflow_app.dart';

// Keep the standard Flutter template name available to existing entry points.
class MyApp extends RentFlowApp {
  const MyApp({super.key});
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RentFlowApp());
}
