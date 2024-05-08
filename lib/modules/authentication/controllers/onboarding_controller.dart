import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingController extends ChangeNotifier {
  // Variable
  final PageController pageController = PageController();
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void updatePageIndicator(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void dotNavigationClick(int index) {
    _currentPageIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (_currentPageIndex == 2) {
      // Jika sudah di halaman terakhir, pindah ke halaman login
      // Ganti '/login' dengan nama rute login Anda
      // Misalnya, Navigator.pushNamed(context, '/login');
      context.pushReplacement("/login");
    } else {
      _currentPageIndex++;
      pageController.jumpToPage(_currentPageIndex);
      notifyListeners();
    }
  }

  void skipPage() {
    _currentPageIndex = 2;
    pageController.jumpToPage(2);
    notifyListeners();
  }
}
