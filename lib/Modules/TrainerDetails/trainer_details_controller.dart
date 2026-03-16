import 'package:mvc_pattern/mvc_pattern.dart';

class TrainerDetailsController extends ControllerMVC {
  // singleton
  factory TrainerDetailsController() {
    _this ??= TrainerDetailsController._();
    return _this!;
  }
  static TrainerDetailsController? _this;
  TrainerDetailsController._();

}
