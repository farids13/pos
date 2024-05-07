import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{
  static OnboardingController get instance => Get.find();

  //Variable
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.toInt().obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage(){
    if(currentPageIndex.value >= 2){
      // Get.offAllNamed("/login");
    }else{
      currentPageIndex.value++;
      pageController.jumpToPage(currentPageIndex.value);
    }

  }

  void skipPage(){
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

}