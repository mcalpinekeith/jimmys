import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/utilities/animated_list_service.dart';

class IconService {
  static final IconService _instance = IconService._internal();

  final defaultIcons = const [

    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.heartCrack,
    FontAwesomeIcons.heartCirclePlus,
    FontAwesomeIcons.heartCircleMinus,
    FontAwesomeIcons.heartCircleBolt,
    FontAwesomeIcons.heartCircleCheck,
    FontAwesomeIcons.heartCircleXmark,
    FontAwesomeIcons.heartCircleExclamation,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.star,

    FontAwesomeIcons.circleCheck,
    FontAwesomeIcons.circleXmark,
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.yinYang,
    FontAwesomeIcons.bomb,
    FontAwesomeIcons.skull,
    FontAwesomeIcons.skullCrossbones,
    FontAwesomeIcons.bookSkull,
    FontAwesomeIcons.radiation,
    FontAwesomeIcons.biohazard,
    FontAwesomeIcons.poop,
    FontAwesomeIcons.poo,

    FontAwesomeIcons.film,
    FontAwesomeIcons.photoFilm,
    FontAwesomeIcons.cameraRetro,
    FontAwesomeIcons.image,
    FontAwesomeIcons.images,
    FontAwesomeIcons.panorama,

    FontAwesomeIcons.gem,
    FontAwesomeIcons.medal,
    FontAwesomeIcons.crown,
    FontAwesomeIcons.award,
    FontAwesomeIcons.trophy,
    FontAwesomeIcons.flagCheckered,
    FontAwesomeIcons.flag,
    FontAwesomeIcons.bullseye,
    FontAwesomeIcons.certificate,
    FontAwesomeIcons.crosshairs,

    FontAwesomeIcons.personSkating,
    FontAwesomeIcons.personSkiing,
    FontAwesomeIcons.personSkiingNordic,
    FontAwesomeIcons.personSnowboarding,
    FontAwesomeIcons.personBiking,
    FontAwesomeIcons.hotTubPerson,
    FontAwesomeIcons.personDrowning,
    FontAwesomeIcons.personSwimming,
    FontAwesomeIcons.personRunning,
    FontAwesomeIcons.personWalking,
    FontAwesomeIcons.personHiking,

    FontAwesomeIcons.map,
    FontAwesomeIcons.signsPost,
    FontAwesomeIcons.diamondTurnRight,

    FontAwesomeIcons.signHanging,
    FontAwesomeIcons.passport,
    FontAwesomeIcons.bookAtlas,
    FontAwesomeIcons.earthAfrica,
    FontAwesomeIcons.earthAmericas,
    FontAwesomeIcons.fly,
    FontAwesomeIcons.planeDeparture,
    FontAwesomeIcons.planeArrival,

    FontAwesomeIcons.umbrellaBeach,
    FontAwesomeIcons.sun,
    FontAwesomeIcons.cloudSun,
    FontAwesomeIcons.cloudSunRain,
    FontAwesomeIcons.cloudShowersHeavy,
    FontAwesomeIcons.cloudMoonRain,
    FontAwesomeIcons.cloudMoon,
    FontAwesomeIcons.moon,

    FontAwesomeIcons.snowman,
    FontAwesomeIcons.igloo,
    FontAwesomeIcons.snowflake,
    FontAwesomeIcons.wind,
    FontAwesomeIcons.smog,
    FontAwesomeIcons.cloud,
    FontAwesomeIcons.cloudBolt,
    FontAwesomeIcons.bolt,
    FontAwesomeIcons.umbrella,
    FontAwesomeIcons.gift,
    FontAwesomeIcons.gifts,
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.puzzlePiece,

    FontAwesomeIcons.scaleUnbalancedFlip,
    FontAwesomeIcons.scaleUnbalanced,
    FontAwesomeIcons.scaleBalanced,
    FontAwesomeIcons.gavel,
    FontAwesomeIcons.dice,
    FontAwesomeIcons.hourglass,
    FontAwesomeIcons.hourglassStart,
    FontAwesomeIcons.hourglassHalf,
    FontAwesomeIcons.hourglassEnd,
    FontAwesomeIcons.bell,
    FontAwesomeIcons.lightbulb,

    FontAwesomeIcons.batteryEmpty,
    FontAwesomeIcons.batteryQuarter,
    FontAwesomeIcons.batteryHalf,
    FontAwesomeIcons.batteryThreeQuarters,
    FontAwesomeIcons.batteryFull,

    FontAwesomeIcons.hammer,
    FontAwesomeIcons.wrench,
    FontAwesomeIcons.screwdriver,
    FontAwesomeIcons.screwdriverWrench,
    FontAwesomeIcons.trowel,
    FontAwesomeIcons.paintRoller,
    FontAwesomeIcons.brush,
    FontAwesomeIcons.dolly,
    FontAwesomeIcons.toolbox,

    FontAwesomeIcons.scissors,
    FontAwesomeIcons.spoon,
    FontAwesomeIcons.utensils,
    FontAwesomeIcons.kitchenSet,

    FontAwesomeIcons.paintbrush,
    FontAwesomeIcons.palette,
    FontAwesomeIcons.shapes,
    FontAwesomeIcons.cubesStacked,

    FontAwesomeIcons.boxesStacked,

    FontAwesomeIcons.wandMagic,
    FontAwesomeIcons.wandMagicSparkles,
    FontAwesomeIcons.hatWizard,
    FontAwesomeIcons.hatCowboy,
    FontAwesomeIcons.graduationCap,


    //FontAwesomeIcons.meteor,
    //FontAwesomeIcons.thumbtack,
    //FontAwesomeIcons.unlock,
    //FontAwesomeIcons.magnifyingGlass,

    FontAwesomeIcons.comment,
    FontAwesomeIcons.comments,

    FontAwesomeIcons.newspaper,
    FontAwesomeIcons.glasses,
    FontAwesomeIcons.socks,
    FontAwesomeIcons.mitten,
    FontAwesomeIcons.shirt,
    FontAwesomeIcons.vest,
    FontAwesomeIcons.vestPatches,

    FontAwesomeIcons.suitcaseRolling,
    FontAwesomeIcons.suitcaseMedical,
    FontAwesomeIcons.suitcase,
    FontAwesomeIcons.bagShopping,
    FontAwesomeIcons.briefcase,
    FontAwesomeIcons.vault,

    FontAwesomeIcons.faucet,
    FontAwesomeIcons.faucetDrip,
    FontAwesomeIcons.shower,
    FontAwesomeIcons.toilet,
    FontAwesomeIcons.toiletPaper,
    FontAwesomeIcons.toiletPaperSlash,

    FontAwesomeIcons.shoePrints,
    FontAwesomeIcons.stairs,

    FontAwesomeIcons.waterLadder,
    FontAwesomeIcons.water,

    FontAwesomeIcons.fireExtinguisher,
    FontAwesomeIcons.fireFlameSimple,
    FontAwesomeIcons.fireFlameCurved,
    FontAwesomeIcons.fire,
    FontAwesomeIcons.dumpsterFire,
    FontAwesomeIcons.dumpster,
    FontAwesomeIcons.trash,

    FontAwesomeIcons.headphones,
    FontAwesomeIcons.music,
    FontAwesomeIcons.masksTheater,
    FontAwesomeIcons.wineBottle,
    //FontAwesomeIcons.wineGlassEmpty,
    FontAwesomeIcons.wineGlass,
    FontAwesomeIcons.champagneGlasses,
    //FontAwesomeIcons.martiniGlassEmpty,
    FontAwesomeIcons.martiniGlass,
    FontAwesomeIcons.martiniGlassCitrus,
    FontAwesomeIcons.mugHot,
    FontAwesomeIcons.couch,
    FontAwesomeIcons.bed,

    FontAwesomeIcons.bucket,
    FontAwesomeIcons.gear,
    FontAwesomeIcons.gears,
    FontAwesomeIcons.weightHanging,
    FontAwesomeIcons.dumbbell,
    FontAwesomeIcons.book,
    //FontAwesomeIcons.video,
    FontAwesomeIcons.bullhorn,
    FontAwesomeIcons.key,

    FontAwesomeIcons.bookMedical,
    FontAwesomeIcons.mortarPestle,
    FontAwesomeIcons.stethoscope,
    FontAwesomeIcons.notesMedical,
    FontAwesomeIcons.lungs,
    FontAwesomeIcons.lungsVirus,
    FontAwesomeIcons.virusSlash,
    FontAwesomeIcons.virus,
    FontAwesomeIcons.viruses,
    FontAwesomeIcons.vialVirus,
    FontAwesomeIcons.vialCircleCheck,
    FontAwesomeIcons.vial,
    FontAwesomeIcons.vials,
    FontAwesomeIcons.flaskVial,
    FontAwesomeIcons.flask,
    FontAwesomeIcons.syringe,
    FontAwesomeIcons.soap,
    FontAwesomeIcons.droplet,
    FontAwesomeIcons.glassWater,
    FontAwesomeIcons.jar,

    FontAwesomeIcons.gasPump,
    FontAwesomeIcons.bicycle,
    FontAwesomeIcons.motorcycle,
    FontAwesomeIcons.paperPlane,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.jetFighter,
    FontAwesomeIcons.rocket,
    FontAwesomeIcons.shuttleSpace,
    FontAwesomeIcons.tractor,
    FontAwesomeIcons.snowplow,
    FontAwesomeIcons.sleigh,
    FontAwesomeIcons.truckFast,
    FontAwesomeIcons.truck,
    FontAwesomeIcons.vanShuttle,
    FontAwesomeIcons.carSide,
    FontAwesomeIcons.truckPickup,
    FontAwesomeIcons.truckField,
    FontAwesomeIcons.truckMonster,
    FontAwesomeIcons.sailboat,
    FontAwesomeIcons.helicopter,

    FontAwesomeIcons.football,
    FontAwesomeIcons.basketball,
    FontAwesomeIcons.baseballBatBall,
    FontAwesomeIcons.bowlingBall,
    FontAwesomeIcons.volleyball,
    FontAwesomeIcons.futbol,
    FontAwesomeIcons.tableTennisPaddleBall,
    FontAwesomeIcons.guitar,
    FontAwesomeIcons.golfBallTee,

    FontAwesomeIcons.tent,
    FontAwesomeIcons.tents,
    FontAwesomeIcons.mountainSun,
    FontAwesomeIcons.mountain,
    FontAwesomeIcons.tree,
    FontAwesomeIcons.leaf,
    FontAwesomeIcons.feather,
    FontAwesomeIcons.bone,

    FontAwesomeIcons.roadBarrier,
    FontAwesomeIcons.mountainCity,
    FontAwesomeIcons.treeCity,
    FontAwesomeIcons.city,
    FontAwesomeIcons.landmarkFlag,
    FontAwesomeIcons.hotel,
    FontAwesomeIcons.dungeon,

    FontAwesomeIcons.sackXmark,
    FontAwesomeIcons.sackDollar,
    FontAwesomeIcons.piggyBank,
    FontAwesomeIcons.coins,
    FontAwesomeIcons.dollarSign,
    FontAwesomeIcons.wallet,
    FontAwesomeIcons.moneyBillWave,
    FontAwesomeIcons.moneyBill,
    FontAwesomeIcons.moneyBills,
    FontAwesomeIcons.ticket,

    FontAwesomeIcons.handPointUp,
    FontAwesomeIcons.handPointDown,
    FontAwesomeIcons.handPointLeft,
    FontAwesomeIcons.handPointRight,
    FontAwesomeIcons.hand,
    FontAwesomeIcons.hands,
    FontAwesomeIcons.handsClapping,
    FontAwesomeIcons.thumbsUp,
    FontAwesomeIcons.thumbsDown,

    FontAwesomeIcons.pause,
    FontAwesomeIcons.play,
    FontAwesomeIcons.forward,
    FontAwesomeIcons.forwardFast,
    FontAwesomeIcons.volumeHigh,
    FontAwesomeIcons.volumeLow,
    FontAwesomeIcons.volumeOff,
    FontAwesomeIcons.volumeXmark,

    FontAwesomeIcons.exclamation,
    FontAwesomeIcons.question,
    FontAwesomeIcons.clipboard,
    FontAwesomeIcons.clipboardQuestion,
    FontAwesomeIcons.clipboardList,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.compassDrafting,
    FontAwesomeIcons.penClip,
    FontAwesomeIcons.pencil,
    FontAwesomeIcons.highlighter,
    FontAwesomeIcons.clock,
    FontAwesomeIcons.stopwatch20,
    FontAwesomeIcons.stopwatch,

    FontAwesomeIcons.powerOff,
    FontAwesomeIcons.toggleOff,
    FontAwesomeIcons.toggleOn,

    FontAwesomeIcons.pills,
    FontAwesomeIcons.bowlRice,
    FontAwesomeIcons.pizzaSlice,
    FontAwesomeIcons.iceCream,
    FontAwesomeIcons.burger,
    FontAwesomeIcons.hotdog,
    FontAwesomeIcons.drumstickBite,
    FontAwesomeIcons.candyCane,
    FontAwesomeIcons.cakeCandles,
    FontAwesomeIcons.cookie,
    FontAwesomeIcons.cookieBite,
    FontAwesomeIcons.lemon,
    FontAwesomeIcons.pepperHot,

    FontAwesomeIcons.bottleWater,

    FontAwesomeIcons.dog,
    FontAwesomeIcons.cat,
    FontAwesomeIcons.horse,
    FontAwesomeIcons.dove,
    FontAwesomeIcons.crow,

    FontAwesomeIcons.otter,
    FontAwesomeIcons.fishFins,
    FontAwesomeIcons.frog,
    FontAwesomeIcons.locust,
    FontAwesomeIcons.bug,
    FontAwesomeIcons.spider,
    FontAwesomeIcons.dragon,
//chess
//faces

  ];

  // The factory is promises to return an object of this type; it doesn't promise to make a new one.
  factory IconService() {
    return _instance;
  }

  // The "real" constructor called exactly once, by the static property assignment above it's also private, so it can only be called in this class.
  IconService._internal();

  AnimatedListService<IconItem> getAnimatedIconList(GlobalKey<AnimatedListState> key) {
    final items = <IconItem>[];

    for (var i = 0; i < defaultIcons.length; i++) {
      final iconData = defaultIcons[i];

      items.add(IconItem(
        unicode: getIconUnicode(iconData),
        icon: iconData,
      ));
    }

    return AnimatedListService(key, null, items);
  }

  String getIconUnicode(IconData iconData) {
    return iconData.codePoint.toRadixString(16);
  }
}

class IconItem {
  IconItem({
    required this.unicode,
    this.icon,
  });

  String unicode = '';
  IconData? icon;
  bool isSelected = false;
}