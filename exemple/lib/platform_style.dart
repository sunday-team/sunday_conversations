import 'package:flutter/foundation.dart';
import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_platform/sunday_platform.dart';
import 'package:universal_io/io.dart';

class PlatformStyle {
  static const String _styleKey = 'platform_style';
  static late SharedPreferencesListener prefs;

  static void initialize() {
    prefs = SharedPreferencesListener();
  }

  static Style get current {
    if (!_isInitialized()) {
      return _getPlatformStyle();
    }
    String? value = prefs.read(_styleKey);
    if (value != null) {
      return Style.values.firstWhere((e) => e.toString() == value,
          orElse: () => _getPlatformStyle());
    }
    return _getPlatformStyle();
  }

  static Style _getPlatformStyle() {
    if (kIsWeb) {
      return Style.latestIOS;
    } else if (Platform.isIOS || Platform.isMacOS) {
      return Style.latestIOS;
    } else if (Platform.isAndroid ||
        Platform.isWindows ||
        Platform.isLinux ||
        Platform.isFuchsia) {
      return Style.latestIOS;
    } else {
      return Style.latestIOS; // Default fallback
    }
  }

  static void setStyle(Style style) {
    if (_isInitialized()) {
      prefs.write(_styleKey, style.toString());
    }
  }

  static bool _isInitialized() {
    try {
      prefs;
      return true;
    } catch (e) {
      return false;
    }
  }
}
