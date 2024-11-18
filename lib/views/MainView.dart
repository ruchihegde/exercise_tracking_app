import 'package:exercise_tracking_app/views/HomeView.dart';
import 'package:exercise_tracking_app/views/StatsView.dart';
import 'package:exercise_tracking_app/views/TemplatesView.dart';
import 'package:exercise_tracking_app/views/WorkoutView.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget> [
          const HomeView(),
          const WorkoutView(isLive: true),
          const TemplatesView(),
          const StatsView(),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 0, 149, 255),
        selectedIndex: _selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const <Widget> [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add),
            icon: Icon(Icons.add_outlined),
            label: 'Start Workout',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.insert_drive_file),
            icon: Icon(Icons.insert_drive_file_outlined),
            label: 'Templates',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.auto_graph_outlined),
            icon: Icon(Icons.auto_graph),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}