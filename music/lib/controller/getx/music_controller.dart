import 'package:get/get.dart';

class MusicController extends GetxController {
  int currentIndex = 1;
  bool isSwitched = false;

  isSwitchedToggle(value) {
    isSwitched = value;
    update();
  }

  currentIndexChange(index) {
    currentIndex = index;
    update();
  }
}