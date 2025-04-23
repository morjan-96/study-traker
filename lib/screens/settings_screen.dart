// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:study_traker/PreferencesService/preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final PreferencesService _prefs = PreferencesService();

  final TextEditingController _dailyController = TextEditingController();
  final TextEditingController _weeklyController = TextEditingController();

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final dailyGoal = await _prefs.getDailyGoal();
    final weeklyGoal = await _prefs.getWeeklyGoal();
    final isDark = await _prefs.isDarkMode();

    setState(() {
      _dailyController.text = dailyGoal.toString();
      _weeklyController.text = weeklyGoal.toString();
      _isDarkMode = isDark;
    });
  }

  Future<void> _saveSettings() async {
    final daily = int.tryParse(_dailyController.text) ?? 0;
    final weekly = int.tryParse(_weeklyController.text) ?? 0;

    await _prefs.setDailyGoal(daily);
    await _prefs.setWeeklyGoal(weekly);
    await _prefs.setDarkMode(_isDarkMode);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('تم حفظ الإعدادات ✅')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإعدادات")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dailyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "الهدف اليومي (بالدقائق)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weeklyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "الهدف الأسبوعي (بالدقائق)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("الوضع الليلي"),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() => _isDarkMode = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _saveSettings,
              icon: const Icon(Icons.save),
              label: const Text("حفظ الإعدادات"),
            ),
          ],
        ),
      ),
    );
  }
}
