import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:game_maybe/components/rock_man.dart';

class FeedButton extends SpriteComponent with Tappable {
  late RockMan rockMan;
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      rockMan.feed();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
