import 'package:exercise_tracking_app/models/ExerciseModel.dart';
import 'package:flutter/material.dart';
import '../models/TemplateModel.dart';
import '../services/TemplateService.dart';
import '../views/widgets/TemplateExerciseListItem.dart';
import '../views/widgets/TemplateList.dart';

class TemplateViewModel extends ChangeNotifier {
  List<Template> _allTemplates = <Template>[];
  int _highestTemplateId = -1;
  List<Template> _myTemplates = <Template>[];
  List<Template> _premadeTemplates = <Template>[];
  List<Template> filteredTemplates = <Template>[];
  final TemplateService _templateService = TemplateService();

  TemplateTab _currentTab = TemplateTab.myTemplates;
  String _searchQuery = '';

  TemplateTab get currentTab => _currentTab;
  String get searchQuery => _searchQuery;

  Future<void> fetchTemplates() async {
    _allTemplates = await _templateService.fetchTemplates();
    _highestTemplateId = _getHighestTemplateId();
    _myTemplates = getMyTemplates();
    _premadeTemplates = getPremadeTemplates();
    _updateFilteredTemplates();
    notifyListeners();
  }

  Future<void> saveTemplates(String title, List<TemplateExerciseListItem> exercises) async {
    
    notifyListeners();
  }

  void setTab(TemplateTab tab) {
    _currentTab = tab;
    _updateFilteredTemplates();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _updateFilteredTemplates();
    notifyListeners();
  }

  void _updateFilteredTemplates() {
    List<Template> templates = _currentTab == TemplateTab.myTemplates
        ? _myTemplates
        : _premadeTemplates;

    if (_searchQuery.isEmpty) {
      filteredTemplates = templates;
    }
    else {
      filteredTemplates = templates
          .where((template) => template.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  int _getHighestTemplateId() {
    return _allTemplates.reduce((cur, next) => cur.id > next.id ? cur : next).id;
  }

  List<Template> getMyTemplates() {
    return _allTemplates
      .where((template) => template.isPremade == false)
      .toList();
  }

  List<Template> getPremadeTemplates() {
    return _allTemplates
      .where((template) => template.isPremade == true)
      .toList();
  }

  // String _templateToJson(String title, List<TemplateExerciseListItem> exercises) {
  //   Map<String, dynamic> itemJson = {};
  //   itemJson.addAll({
  //     "id": _highestTemplateId + 1,
  //     "name": title,
  //     "isPremade": false,
  //   });
  //   List<Map<String, dynamic>> exercisesData = [];
  //   for (var exerciseItem in exercises) {
  //     Map<String, dynamic> setData = {};
  //     for (var curSet in exerciseItem.getSetValues()) {
  //       for (var trackedStat in exerciseItem.exercise.trackedStats) {
  //         switch(trackedStat.type) {
  //           case TrackableStat.weight:
              
  //             break;
  //           case TrackableStat.reps:
  //             break;
  //           case TrackableStat.time:
  //             break;
  //           case TrackableStat.distance:
  //             break;
  //         }
  //       }
  //     }
  //     // setData.add({
  //     //   "id": exercise.exercise.id,
  //     //   "name": exercise.exercise.name,

  //     // });
  //   }
  // }

}