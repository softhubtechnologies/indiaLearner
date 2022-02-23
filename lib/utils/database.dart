import 'package:get/get.dart';
import 'package:india_learner/utils/DbKeys.dart';
import 'package:india_learner/views/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static SharedPreferences prefs;
  static initDatabase() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveSelectedCategory({String category, String categoryId}) {
    prefs.setString(DbKeys.selectedCategory, category);
    prefs.setString(DbKeys.categoryId, categoryId);
  }

  static String getSelectedCategoryId() {
    print("categoryName ${prefs.get(DbKeys.categoryId)}");

    return prefs.get(DbKeys.categoryId);
  }

  static String getSelectedCategory() {
    print("categoryName ${prefs.get(DbKeys.selectedCategory)}");

    return prefs.get(DbKeys.selectedCategory);
  }

  static saveUserId(String userId) {
    prefs.setString(DbKeys.userId, userId);
  }

  static String getUserID() {
    return prefs.get(DbKeys.userId);
  }

  static saveSubCategory({String subcategory, String subcatId}) {
    prefs.setString(DbKeys.subcategory, subcategory);
    prefs.setString(DbKeys.subcategoryId, subcatId);
  }

  static String getSubcategory() {
    return prefs.get(DbKeys.subcategory);
  }

  static String getSubcategoryId() {
    return prefs.get(DbKeys.subcategoryId);
  }

  static String saveSubscribitionPlan(String price, String duration) {
    prefs.setString(DbKeys.price, price);
    prefs.setString(DbKeys.duration, duration);
  }

  static String getPlan() {
    return prefs.get(DbKeys.duration);
  }

  static saveClass(String className) {
    prefs.setString(DbKeys.className, className);
  }

  static String getClassName() {
    return prefs.getString(DbKeys.className);
  }

  static logout() async {
    await prefs.clear();
    Get.offAll(Login());
  }

  static downloadVideo({String videoJson}) async {
    await prefs.setString(DbKeys.downloads, videoJson);
  }

  static String getDownloadedVideos() {
    return prefs.getString(DbKeys.downloads);
  }

  static downloadNotes(String notesJson) async {
    await prefs.setString(DbKeys.downloadNotes, notesJson);
  }

  static String getDownloadedNotes() {
    return prefs.getString(DbKeys.downloadNotes);
  }

  static String getTheme() {
    return prefs.getString(DbKeys.themeKey);
  }

  static setTheme(String themeName) async {
    await prefs.setString(DbKeys.themeKey, themeName);
  }
}
