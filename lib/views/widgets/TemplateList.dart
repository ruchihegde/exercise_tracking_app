import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum TemplateView { myTemplates, premade }

class TemplateList extends StatefulWidget {
  const TemplateList({super.key});


  @override
  State<TemplateList> createState() => _TemplateListState();
}

class _TemplateListState extends State<TemplateList> {

  TemplateView currentTab = TemplateView.myTemplates;
  TextEditingController searchController = TextEditingController();
  List<String> myTemplates = ['Template 1', 'Template 2', 'Template 3'];
  List<String> premadeTemplates = ['Premade 1', 'Premade 2', 'Premade 3'];
  List<String> filteredTemplates = [];

  @override
  void initState() {
    super.initState();
    filteredTemplates = myTemplates;
    searchController.addListener(_filterTemplates);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterTemplates);
    searchController.dispose();
    super.dispose();
  }

  int _getCurListCount () {
    return currentTab == TemplateView.myTemplates 
      ? myTemplates.length
      : premadeTemplates.length;
  }

  void _filterTemplates() {
    setState(() {
      List<String> templates = currentTab == TemplateView.myTemplates
          ? myTemplates
          : premadeTemplates;
      filteredTemplates = templates
          .where((template) =>
              template.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                labelText: 'Search',
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
            child: SegmentedButton<TemplateView>(
              segments: const <ButtonSegment<TemplateView>>[
                ButtonSegment<TemplateView>(
                  value: TemplateView.myTemplates,
                  label: Text('My Templates'),
                ),
                ButtonSegment<TemplateView>(
                  value: TemplateView.premade,
                  label: Text('Premade Templates'),
                )
              ],
              selected: {currentTab},
              onSelectionChanged: (Set<TemplateView> newSelection) {
                setState(() {
                  currentTab = newSelection.first;
                  _filterTemplates();
                });
              },
              showSelectedIcon: false,
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getCurListCount(),
              itemBuilder: (context, idx) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListTile(
                      leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
                      title: Text(
                        filteredTemplates[idx],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                );
              }
            ),
          )
        ],
      )
    );
  }
}