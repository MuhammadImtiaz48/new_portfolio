import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class SizeUtils {
  SizeUtils._();

  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 1024;

  static const Size desktopDesignSize = Size(1440, 900);
  static const Size mobileDesignSize = Size(375, 812);

  static double screenWidth = desktopDesignSize.width;
  static double screenHeight = desktopDesignSize.height;
  static DeviceType deviceType = DeviceType.desktop;
  static Size designSize = desktopDesignSize;

  static void setScreenSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;

    if (screenWidth >= desktopBreakpoint) {
      deviceType = DeviceType.desktop;
      designSize = desktopDesignSize;
    } else if (screenWidth >= mobileBreakpoint) {
      deviceType = DeviceType.tablet;
      designSize = desktopDesignSize;
    } else {
      deviceType = DeviceType.mobile;
      designSize = mobileDesignSize;
    }
  }
}

extension ResponsiveSizeExtension on num {
  double get h => this * (SizeUtils.screenWidth / SizeUtils.designSize.width);

  double get v =>
      this * (SizeUtils.screenHeight / SizeUtils.designSize.height);

  double get fSize =>
      this * (SizeUtils.screenWidth / SizeUtils.designSize.width);

  double get adaptSize {
    final horizontal = h;
    final vertical = v;
    return horizontal < vertical ? horizontal : vertical;
  }
}
