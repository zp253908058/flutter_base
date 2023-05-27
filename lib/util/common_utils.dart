import 'dart:math' as math;

class CommonUtils {

  static bool compareVersion(String newVersion, String old) {
    if (newVersion.isEmpty || old.isEmpty) {
      return false;
    }
    var newList = newVersion.split('.');
    var oldList = old.split('.');
    if (newList.isEmpty || oldList.isEmpty) {
      return false;
    }
    int newLength = newList.length;
    int oldLength = oldList.length;
    int minLength = math.min(newLength, oldLength);
    int position = 0;
    int diff = int.parse(newList[position]) - int.parse(oldList[position]);
    while (position < minLength && diff == 0) {
      position++;
      diff = int.parse(newList[position]) - int.parse(oldList[position]);
    }
    diff = (diff != 0) ? diff : (newLength - oldLength);
    return diff > 0;
  }
}
