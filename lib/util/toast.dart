import 'package:bot_toast/bot_toast.dart';

class Toast {
  static void show(String msg) {
    BotToast.showText(text: msg);
  }
}
