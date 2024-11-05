import 'package:flutter/material.dart';
import './widgets/TemplateView.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Card(
        child: TemplateList()
      )
    );
  }
}