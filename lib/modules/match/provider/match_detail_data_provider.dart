import 'package:flutter/material.dart';

class MatchDetailDataProvider extends ChangeNotifier {

  String animateUrl = "";
  
  bool _showAnimate = false;
  bool get showAnimate => _showAnimate;
  void setShowAnimate(bool value) {
    _showAnimate = value;
    notifyListeners();
  }

  bool _showVideo = false;
  bool get showVideo => _showVideo;
  void setShowVideo(bool value) {
    _showVideo = value;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
