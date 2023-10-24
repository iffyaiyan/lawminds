import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/app_bar.dart';
import '../../providers/user.dart';
import 'widget/topic.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcome,
            const TopicWidget(),
          ],
        ),
      ),
    );
  }

  //widget functions
  Widget get _welcome => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Hi ${context.watch<UserProvider>().name}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      const Text('Welcome to LawMinds!',
          style: TextStyle(fontSize: 18, color: Colors.indigo)),
      const Divider(color: Colors.indigo, thickness: 0.5),
      const SizedBox(height: 20),
    ],
  );
}