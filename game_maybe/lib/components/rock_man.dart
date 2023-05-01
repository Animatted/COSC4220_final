import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class RockMan extends SpriteAnimationComponent with Tappable {
  late final SpriteAnimation rockManAnimation;
  late final SpriteAnimation happiestAnimation;
  late final SpriteAnimation fatAnimation;
  late final SpriteAnimation abusedDeadAnimation;
  late final SpriteAnimation deadAnimation;
  late final SpriteAnimation abusedAnimation;
  late final SpriteAnimation defaultEvoAnimation;
  static bool hasEvolved = false;
  static bool isAbused = false;
  static bool isDead = false;
  static int hunger = 50;
  static int happiness = 50;
  static int age = 0;
  int ageCounter = 0;

  bool needsReset = false;

  void reset() {
    happiness = 50;
    hunger = 50;
    age = 0;
    isAbused = false;
    isDead = false;
    needsReset = true;
  }

  int getAge() {
    return age;
  }

  void setisAbused(bool) {
    isAbused = true;
  }

  void setHappiness(int) {
    happiness = int;
  }

  int getHappiness() {
    return happiness;
  }

  void setHunger(int) {
    hunger = int;
  }

  int getHunger() {
    return hunger;
  }

  void feed() {
    if (hunger < 95) {
      hunger += 5;
    }
  }

  void pet() {
    happiness += 5;
  }

  void dies() {
    isDead = true;
  }

  void abuse() {
    happiness -= 10;
  }

  void clean() {
    happiness += 15;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //alive animation
    var rockManData = SpriteAnimationData.sequenced(
        amount: 14, stepTime: 0.15, textureSize: Vector2(38, 34));
    var aliveImage = await Flame.images.load('RockMan(38x34).png');
    rockManAnimation = SpriteAnimation.fromFrameData(aliveImage, rockManData);

    //dead animation
    var deadData = SpriteAnimationData.sequenced(
        amount: 10, stepTime: 0.15, textureSize: Vector2(44, 30));
    var deadImage = await Flame.images.load('Ghost(44x30).png');
    deadAnimation = SpriteAnimation.fromFrameData(deadImage, deadData);

    //fat animation
    var fatData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.15, textureSize: Vector2(40, 48));
    var fatImage = await Flame.images.load('Fat(40x48).png');
    fatAnimation = SpriteAnimation.fromFrameData(fatImage, fatData);

    //happiest animation
    var happiestData = SpriteAnimationData.sequenced(
        amount: 13, stepTime: 0.15, textureSize: Vector2(84, 38));
    var happiestImage = await Flame.images.load('Happiest(84x38).png');
    happiestAnimation =
        SpriteAnimation.fromFrameData(happiestImage, happiestData);

    //dead and abused animation
    var abusedDeadData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.15, textureSize: Vector2(52, 40));
    var abusedDeadImage = await Flame.images.load('DeadAbused(52x40).png');
    abusedDeadAnimation =
        SpriteAnimation.fromFrameData(abusedDeadImage, abusedDeadData);

    //abused animation
    var abusedData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.15, textureSize: Vector2(36, 30));
    var abusedImage = await Flame.images.load('Abused(36x30).png');
    abusedAnimation = SpriteAnimation.fromFrameData(abusedImage, abusedData);

    //default evolution animation
    var defaultEvoData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.15, textureSize: Vector2(44, 26));
    var defaultEvoImage = await Flame.images.load('DefaultEvo(44x26).png');
    defaultEvoAnimation =
        SpriteAnimation.fromFrameData(defaultEvoImage, defaultEvoData);
    animation = rockManAnimation;
  }

  @override
  void update(double db) {
    if (needsReset == true) {
      animation = rockManAnimation;
      needsReset = false;
    }

    if (isDead == true) {
      if (isAbused == true) {
        animation = deadAnimation;
      } else {
        animation = deadAnimation;
      }
    }

    if (age > 10 && hasEvolved == false) {
      if (isAbused == true) {
        animation = abusedAnimation;
        hasEvolved = true;
      } else if (hunger > 90 && happiness > 90) {
        animation = happiestAnimation;
        hasEvolved = true;
      } else if (hunger > 90 && happiness < 65) {
        animation = fatAnimation;
        hasEvolved = true;
      } else {
        animation = defaultEvoAnimation;
        hasEvolved = true;
      }
    }

    ageCounter++;
    if (ageCounter == 1200) {
      age++;
      ageCounter = 0;
    }

    super.update(db);
  }
}
