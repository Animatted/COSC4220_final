import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'rock_man_game.dart';

void main() {
  final game = RockManGame();
  runApp(GameWidget(game: game));
}
