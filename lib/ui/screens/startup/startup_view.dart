import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/ui/screens/_base/base_view_widget_state.dart';
import 'package:jimmys/ui/screens/startup/startup_contract.dart';
import 'package:jimmys/ui/screens/workout_list/workout_list_view.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/my_button.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';
import 'package:jimmys/core/extensions/string.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewWidgetState();
}

class _StartupViewWidgetState extends BaseViewWidgetState<StartupView, StartupVMContract, StartupVMState> with WidgetsMixin implements StartupViewContract {
  @override
  void onInitState() {}

  @override
  Widget contentBuilder(BuildContext context) {
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
                  Text('Hello,',
                    style: theme.textTheme.headlineLarge
                  ),
                  userAvatar(vmState.user),
                ],
              ),
            ),
            _userGreeting(theme),
            MyButton(
              label: const Text('Add workouts'),
              icon: const FaIcon(FontAwesomeIcons.circlePlus),
              onPressed: () => navigate(context, const WorkoutListView()),
            ),
            MyButton(
              label: const Text('Add exercises'),
              icon: const FaIcon(FontAwesomeIcons.circlePlus),
              onPressed: () {
                //Navigator.pop(context);
              },
            ),
            _scheduleWorkoutsOption(theme),
            _scheduledWorkout(theme),
          ],
        ),
      ),
    );
  }

  Widget _userGreeting(ThemeData theme) {
    final displayName = vmState.user != null && vmState.user!.displayName.isNotNullNorEmpty
      ? '${vmState.user!.displayName!}.'
      : 'Stranger.';

    return Row(
      children: [
        SizedBox(
          height: spacingLarge,
          child: Padding(
            padding: const EdgeInsets.only(left: spacingSmall),
            child: Text(displayName,
              style: headlineLargePrimary(theme),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _scheduleWorkoutsOption(ThemeData theme) {
    if (vmState.workoutList.isEmpty) return const SizedBox.shrink();

    return MyButton(
      label: const Text('Schedule workouts'),
      icon: const FaIcon(FontAwesomeIcons.calendar),
      onPressed: () {
        //Navigator.pop(context);
      },
    );
  }

  Widget _scheduledWorkout(ThemeData theme) {
    if (vmState.todayWorkout == null) return const SizedBox.shrink();

    return Expanded(
      child: Column(
        children: [
          const Gap(spacingLarge),
          const Text('Scheduled for today:'),
          const Gap(spacingMedium),
          Text(vmState.todayWorkout!.name,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
            softWrap: true,
          ),
          const Gap(spacingSmall),
          Expanded(
            child: ListView(
              children: [
                Text(vmState.todayWorkout!.description!,
                  textAlign: TextAlign.center,
                  style: titleMediumSecondary(theme),
                ),
              ],
            ),
          ),
          const Gap(spacingSmall),
        ],
      ),
    );
  }

  @override
  void showError(String message) {
    showSnackBar(context, message);
  }
}