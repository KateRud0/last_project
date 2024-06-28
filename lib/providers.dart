import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CategoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> _categories = [];

  List<Map<String, dynamic>> get categories => _categories;

  CategoryProvider() {
    _loadFromPrefs();
  }

  void addCategory(Map<String, dynamic> category) {
    _categories.add(category);
    _saveToPrefs();
    notifyListeners();
  }

  void updateCategory(int index, Map<String, dynamic> newCategory) {
    _categories[index] = newCategory;
    _saveToPrefs();
    notifyListeners();
  }

  void deleteCategory(int index) {
    _categories.removeAt(index);
    _saveToPrefs();
    notifyListeners();
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final categories = prefs.getStringList('categories');
    if (categories != null) {
      _categories = categories.map((e) => json.decode(e)).toList().cast<Map<String, dynamic>>();
      notifyListeners();
    }
  }

  void _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final categories = _categories.map((e) => json.encode(e)).toList();
    prefs.setStringList('categories', categories);
  }
}

class TaskProvider with ChangeNotifier {
  List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => _tasks;

  TaskProvider() {
    _loadFromPrefs();
  }

  void addTask(Map<String, dynamic> task) {
    _tasks.add(task);
    _saveToPrefs();
    notifyListeners();
  }

  void updateTask(int index, Map<String, dynamic> newTask) {
    _tasks[index] = newTask;
    _saveToPrefs();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    _saveToPrefs();
    notifyListeners();
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = prefs.getStringList('tasks');
    if (tasks != null) {
      _tasks = tasks.map((e) => json.decode(e)).toList().cast<Map<String, dynamic>>();
      notifyListeners();
    }
  }

  void _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = _tasks.map((e) => json.encode(e)).toList();
    prefs.setStringList('tasks', tasks);
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
