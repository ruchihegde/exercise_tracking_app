import 'package:exercise_tracking_app/views/widgets/TemplateListItem.dart';
import 'package:flutter/material.dart';
import '../../services/TemplateService.dart';
import '../../viewmodels/TemplateViewModel.dart';
import 'package:provider/provider.dart';

enum TemplateTab { myTemplates, premade }

class TemplateList extends StatefulWidget {
  final bool isWorkout;

  const TemplateList({super.key, required this.isWorkout});


  @override
  State<TemplateList> createState() => _TemplateListState();
}

class _TemplateListState extends State<TemplateList> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TemplateViewModel>(context, listen: false).fetchTemplates();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final templateViewModel = Provider.of<TemplateViewModel>(context, listen: false);
    templateViewModel.setSearchQuery(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add control for when workout or not
    return Consumer<TemplateViewModel>(
      builder: (context, templateViewModel, child) {
        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search templates',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                )
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: SegmentedButton<TemplateTab>(
                  segments: const <ButtonSegment<TemplateTab>>[
                    ButtonSegment<TemplateTab>(
                      value: TemplateTab.myTemplates,
                      label: Text('My Templates'),
                    ),
                    ButtonSegment<TemplateTab>(
                      value: TemplateTab.premade,
                      label: Text('Premade Templates'),
                    )
                  ],
                  selected: {templateViewModel.currentTab},
                  onSelectionChanged: (Set<TemplateTab> newSelection) {
                    templateViewModel.setTab(newSelection.first);
                  },
                  showSelectedIcon: false,
                )
              ),
              const SizedBox(height: 10),
              Expanded(
                child: templateViewModel.filteredTemplates.isNotEmpty
                  ? ListView.builder(
                      itemCount: templateViewModel.filteredTemplates.length,
                      itemBuilder: (context, idx) {
                        final template = templateViewModel.filteredTemplates[idx];
                        return TemplateListItem(
                          template: template,
                          onTap: () => print('tapped ${template.name}'),
                          isWorkout: false,
                        );
                      }
                    )
                  : const Text('No Templates Found')
              )
            ],
          )
        );
      },
    );
  }
}