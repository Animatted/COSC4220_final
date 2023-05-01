import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:game_maybe/components/rock_man.dart';

class ScoldButton extends SpriteComponent with Tappable {
  late RockMan rockMan;
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      rockMan.abuse();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
