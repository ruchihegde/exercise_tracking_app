import 'package:flutter/material.dart';
import '../../models/TemplateModel.dart';

class TemplateListItem extends StatelessWidget {
  final Template template;
  final VoidCallback onTap;
  final bool isWorkout;
  
  const TemplateListItem({
    Key? key,
    required this.template,
    required this.onTap,
    required this.isWorkout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double horizontalPadding = width * 0.02;
    double height = MediaQuery.of(context).size.height;
    double verticalPadding = height * 0.02;

    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width * 0.80,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.accessibility_new_sharp,
                size: 50.0,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(template.description),
                  const SizedBox(height: 8),
                ],
              ),
              const Spacer(),
              isWorkout == true
                ? const Icon(
                    Icons.edit,
                    size: 24.0,
                  )
                : const Icon(
                    Icons.check,
                    size: 24.0,
                  ),
            ],
          ),
        ),
      )
    );
  }
}