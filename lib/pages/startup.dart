import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/constants.dart';
import 'package:jimmys/functions.dart';
import 'package:jimmys/pages/workouts.dart';
import 'package:jimmys/services/data_service.dart';
import 'package:jimmys/services/workout_service.dart';
import 'package:jimmys/widgets/my_button.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  State<StartupPage> createState() => _StartupState();
}

class _StartupState extends State<StartupPage> {
  final _db = DataService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(spacingSmall, 0, spacingSmall, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello,', style: theme.textTheme.headlineLarge),
                  _createAvatarImage(),
                ],
              ),
            ),
            _createUserGreeting(theme),
            MyButton(
              label: const Text('Add workouts'),
              icon: const FaIcon(FontAwesomeIcons.circlePlus),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const WorkoutsPage()
                ));
              },
            ),
            MyButton(
              label: const Text('Add exercises'),
              icon: const FaIcon(FontAwesomeIcons.circlePlus),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            _createScheduleWorkoutsOption(theme),
            _createScheduledWorkout(theme),
          ],
        ),
      ),
    );
  }

  Widget _createAvatarImage() {
    final user = FirebaseAuth.instance.currentUser;
    Widget avatar = Image.memory(kTransparentImage);

    if (user != null && user.photoURL != null) {
      avatar = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: user.photoURL!,
      );
    }

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: imageSmall,
        height: imageSmall,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: avatar,
      ),
    );
  }

  Widget _createUserGreeting(ThemeData theme) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return createBusy(theme);

        if (snapshot.hasError && snapshot.error != null) return Text(snapshot.error!.toString());

        final d = snapshot.data;
        if (d != null && d.displayName != null) {
          return Row(
            children: [ 
              SizedBox(
                height: spacingLarge,
                child: Padding(
                  padding: const EdgeInsets.only(left: spacingSmall),
                  child: Text(
                    '${d.displayName!}.',
                    style: getHeadlineLargePrimary(theme),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        }

        return Row(
          children: [ 
            Padding(
              padding: const EdgeInsets.only(left: spacingSmall),
              child: Text('Stranger.', style: getHeadlineLargePrimary(theme)),
            ),
          ],
        );
      },
    );
  }

  Widget _createScheduleWorkoutsOption(ThemeData theme) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutService(),
      child: Consumer<WorkoutService>(builder: (context, workoutService, child) {
        if (_db.workouts.isEmpty) return const SizedBox.shrink();

        return MyButton(
          label: const Text('Schedule workouts'),
          icon: const FaIcon(FontAwesomeIcons.calendar),
          onTap: () {
            //Navigator.pop(context);
          },
        );
      }),
    );
  }

  Widget _createScheduledWorkout(ThemeData theme) {
    var ws = context.watch<WorkoutService>();

    if (ws.todayWorkout == null) return const SizedBox.shrink();

    return Expanded(
      child: Column(
        children: [
          const Gap(spacingLarge),
          const Text('Scheduled for today:'),
          const Gap(spacingMedium),
          Text(
            ws.todayWorkout!.name,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
            softWrap: true,
          ),
          const Gap(spacingSmall),
          Expanded(
            child: ListView(
              children: [
                Text(
                  ws.todayWorkout!.description!,
                  textAlign: TextAlign.center,
                  style: getTitleMediumSecondary(theme),
                ),
              ],
            ),
          ),
          const Gap(spacingSmall),
        ],
      ),
    );
  }
}