import 'package:get/get.dart';
import 'package:portfolio/core/size_utils.dart';

class ResponsiveController extends GetxController {
  final Rx<DeviceType> _deviceType = DeviceType.desktop.obs;

  DeviceType get deviceType => _deviceType.value;

  bool get isMobile => _deviceType.value == DeviceType.mobile;
  bool get isTablet => _deviceType.value == DeviceType.tablet;
  bool get isDesktop => _deviceType.value == DeviceType.desktop;

  void updateDeviceType(DeviceType type) {
    if (_deviceType.value != type) {
      _deviceType.value = type;
    }
  }
}
