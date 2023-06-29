import 'package:flutter/foundation.dart';

import 'package:flutter/animation.dart';

class AnimProvider extends ChangeNotifier {
  late AnimationController _animationController;

  AnimationController get animationController => _animationController;

  // set animationController(AnimationController controller) {
  //   _animationController = controller;
  //   notifyListeners();
  // }

  void init(TickerProvider t) {
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: t /* Your TickerProvider */,
    );
  }

  void resetAnimation() {
    _animationController.reset();
    notifyListeners();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
