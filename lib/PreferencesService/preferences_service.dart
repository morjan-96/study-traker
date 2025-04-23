import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String keyDailyGoal = 'daily_goal_minutes';
  static const String keyWeeklyGoal = 'weekly_goal_minutes';
  static const String keyDarkMode = 'dark_mode';

  // حفظ الهدف اليومي
  Future<void> setDailyGoal(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyDailyGoal, minutes);
  }

  // جلب الهدف اليومي
  Future<int> getDailyGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyDailyGoal) ?? 0;
  }

  // حفظ الهدف الأسبوعي
  Future<void> setWeeklyGoal(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyWeeklyGoal, minutes);
  }

  // جلب الهدف الأسبوعي
  Future<int> getWeeklyGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyWeeklyGoal) ?? 0;
  }

  // حفظ الوضع الليلي
  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyDarkMode, isDark);
  }

  // جلب الوضع الليلي
  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyDarkMode) ?? false;
  }
}
