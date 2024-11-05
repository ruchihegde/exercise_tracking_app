import 'package:flutter/material.dart';
import './widgets/TemplateList.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: TemplateList()
      )
    );
  }
}