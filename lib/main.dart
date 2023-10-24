import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'utils/prefs.dart';
import 'utils/routes.dart';

Future<void> main() async {
  String initialRoute = (await Prefs.getIsLogin()) ? Routes.dashboard : Routes.login;
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'LawMinds',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        routes: Routes.routes,
        initialRoute: initialRoute,
      ),
    );
  }
}