
import 'ios_on_mac_utils_platform_interface.dart';

class IosOnMacUtils {
  Future<String?> getPlatformVersion() {
    return IosOnMacUtilsPlatform.instance.getPlatformVersion();
  }
}
