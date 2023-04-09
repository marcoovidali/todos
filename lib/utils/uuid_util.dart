import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UuidUtil {
  get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // saving random uuid if not present in preferences
    if (!preferences.containsKey('uuid')) {
      String uuid = const Uuid().v4();
      preferences.setString('uuid', uuid);
    }

    return preferences.getString('uuid');
  }
}
