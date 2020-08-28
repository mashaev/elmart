import 'package:ansicolor/ansicolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences session;

cprint(String msg) {
  AnsiPen pen = new AnsiPen()
    ..white()
    ..rgb(r: 1.0, g: 0.8, b: 0.2);
  assert(() {
    print(pen(msg));
    return true;
  }());
}
