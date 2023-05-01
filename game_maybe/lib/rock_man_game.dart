import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'components/rock_man.dart';
import 'components/praise_button.dart';
import 'components/feed_button.dart';
import 'components/clean_button.dart';
import 'components/scold_button.dart';
import 'components/reset_button.dart';

class RockManGame extends FlameGame with HasTappables {
  int hungerTimer = 0;

  TextComponent hungerCounter = TextBoxComponent();
  TextComponent happinessCounter = TextBoxComponent();
  TextComponent ageCounter = TextBoxComponent();

  static const double buttonGap = 25.0;
  static const double buttonWidth = 306.0;
  static const double buttonHeight = 148.0;
  //static const double buttonRadius = 70.0;
  //static const double rockManGap = 75.0;
  static final Vector2 buttonSize = Vector2(buttonWidth, buttonHeight);

  FeedButton feed = FeedButton();
  CleanButton clean = CleanButton();
  ScoldButton scold = ScoldButton();
  PraiseButton praise = PraiseButton();
  ResetButton reset = ResetButton();

  RockMan rockMan = new RockMan();

  //Set background color to blend with bottom of background image
  @override
  Color backgroundColor() => const Color(0xff01171c);
  @override
  Future<void> onLoad() async {
    ageCounter
      ..textRenderer = TextPaint(
          style: TextStyle(
              color: Color.fromARGB(255, 255, 1, 1),
              fontSize: 36,
              fontWeight: FontWeight.bold))
      ..y = 100;
    happinessCounter
      ..textRenderer = TextPaint(
          style: TextStyle(
              color: Color.fromARGB(255, 255, 1, 1),
              fontSize: 36,
              fontWeight: FontWeight.bold))
      ..y = 50;

    hungerCounter
      ..textRenderer = TextPaint(
          style: TextStyle(
              color: Color.fromARGB(255, 255, 0, 0),
              fontSize: 36,
              fontWeight: FontWeight.bold))
      ..y = 0;

    //initialize dynamic sizing variables

    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    final buttonScale =
        Vector2.all(((screenWidth - 100 - (buttonGap * 5)) / 4) / buttonWidth);
    print(size);
    final backgroundHeight =
        screenHeight - buttonGap * 2 - buttonHeight * buttonScale[1];

    //Load and set background sprite

    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('back.png')
      ..size = Vector2(screenWidth, backgroundHeight);
    add(background);
    add(hungerCounter);
    add(happinessCounter);
    add(ageCounter);

    rockMan
      ..scale = Vector2(2, 2)
      ..x = screenWidth / 2 - 38
      ..y = backgroundHeight * 0.8;
    add(rockMan);

    feed
      ..rockMan = rockMan
      ..sprite = await loadSprite('FeedButton.png')
      ..size = buttonSize
      ..scale = buttonScale
      ..y =
          (screenHeight - buttonGap - buttonHeight * buttonScale[1]).toDouble()
      ..x = buttonGap + 50.0;
    add(feed);

    clean
      ..rockMan = rockMan
      ..sprite = await loadSprite('CleanButton.png')
      ..size = buttonSize
      ..scale = buttonScale
      ..y =
          (screenHeight - buttonGap - buttonHeight * buttonScale[1]).toDouble()
      ..x = buttonGap * 2 + 50 + buttonWidth * buttonScale[0];
    add(clean);

    scold
      ..rockMan = rockMan
      ..sprite = await loadSprite('ScoldButton.png')
      ..size = buttonSize
      ..scale = buttonScale
      ..y =
          (screenHeight - buttonGap - buttonHeight * buttonScale[1]).toDouble()
      ..x = buttonGap * 3 + 50 + buttonWidth * 2 * buttonScale[0];
    add(scold);

    praise
      ..rockMan = rockMan
      ..sprite = await loadSprite('PraiseButton.png')
      ..size = buttonSize
      ..scale = buttonScale
      ..y =
          (screenHeight - buttonGap - buttonHeight * buttonScale[1]).toDouble()
      ..x = buttonGap * 4 + 50 + buttonWidth * 3 * buttonScale[0];
    add(praise);

    reset
      ..rockMan = rockMan
      ..sprite = await loadSprite('Trash.png')
      ..size = Vector2(150, 150)
      ..scale = buttonScale / 2
      ..y = buttonGap
      ..x = screenWidth - buttonGap - 150;
    add(reset);
  }

  @override
  void update(double dt) {
    hungerTimer++;
    if (hungerTimer == 680) {
      hungerTimer = 0;
      rockMan.setHunger(rockMan.getHunger() - 2);
      rockMan.setHappiness(rockMan.getHappiness() - 2);
    }
    if ((dt * 100000 % 2 == 0 && dt > 0.04) || dt < 0.005) {
      rockMan.setHunger(rockMan.getHunger() - 5);
      if (rockMan.getHunger() < 25) {
        rockMan.setHappiness(rockMan.getHappiness() - 1);
      }
    }
    if (rockMan.getHappiness() < 0) {
      rockMan.setisAbused(true);
    }
    if (rockMan.getHunger() < 0) {
      rockMan.dies();
    }
    //print(dt);

    hungerCounter.text = 'Hunger: ' + rockMan.getHunger().toString();
    happinessCounter.text = 'Mood: ' + rockMan.getHappiness().toString();
    ageCounter.text = 'Age: ' + rockMan.getAge().toString();
    super.update(dt);
  }
}
