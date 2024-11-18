import 'package:flutter/material.dart';

class ExerciseTileListItem extends StatelessWidget {
  final int setNumber;
  final TextEditingController repsController;
  final TextEditingController weightController;
  final ValueChanged<String?>? onUnitChanged;
  final bool isEditable;

  const ExerciseTileListItem({
    super.key,
    required this.setNumber,
    required this.repsController,
    required this.weightController,
    required this.onUnitChanged,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text('$setNumber. '),
          Expanded(
            child: TextField(
              enabled: isEditable,
              decoration: const InputDecoration(
                hintText: 'Reps',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Weight',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: DropdownButtonFormField(
              value: 'lbs', // Default value
              items: const [
                DropdownMenuItem(value: 'lbs', child: Text('lbs')),
                DropdownMenuItem(value: 'kgs', child: Text('kgs')),
              ],
              onChanged: onUnitChanged,
            ),
          ),
        ],
      ),
    );
  }
}
