import 'package:flutter/material.dart';

import '../../components/app_bar.dart';
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
  Widget get _welcome => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Hi,',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      Text('Welcome to LawMinds!',
          style: TextStyle(fontSize: 18, color: Colors.indigo)),
      Divider(color: Colors.indigo, thickness: 0.5),
      SizedBox(height: 20),
    ],
  );
}