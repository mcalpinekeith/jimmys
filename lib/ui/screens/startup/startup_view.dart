import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/core/extensions/build_context.dart';
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

class _StartupViewWidgetState extends BaseViewWidgetState<StartupView, StartupVMContract, StartupViewModelState> with WidgetsMixin implements StartupVContract {
  @override
  Future<void> onInitState() async {
    await reload();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _userGreeting(),
            const Gap(spacingMedium),
            MyButton(
              label: const Text('Workouts'),
              icon: const FaIcon(FontAwesomeIcons.stopwatch),
              onPressed: () async {
                await navigate(context, const WorkoutListView());
                await reload();
              },
            ),
            MyButton(
              label: const Text('Exercises'),
              icon: const FaIcon(FontAwesomeIcons.personRunning),
              onPressed: () {
                //Navigator.pop(context);
              },
            ),
            _scheduleWorkoutsOption(),
            _scheduledWorkout(),
          ],
        ),
      ),
    );
  }

  Widget _userGreeting() {
    final displayName = vmState.user != null && vmState.user!.displayName.isNotNullNorEmpty
      ? '${vmState.user!.displayName!}.'
      : 'Stranger.';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(spacingSmall, 0, spacingSmall, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hello,',
                style: context.text.headlineLarge
              ),
              userAvatar(vmState.user),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: spacingLarge,
              child: Padding(
                padding: const EdgeInsets.only(left: spacingSmall),
                child: Text(displayName,
                  style: headlineLargePrimary(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ]
    );
  }

  Widget _scheduleWorkoutsOption() {
    if (vmState.isLoading) return loader(context, padding: const EdgeInsets.only(top: spacingMedium));
    if (vmState.workoutList.isEmpty) return nothing;

    return MyButton(
      label: const Text('Schedule'),
      icon: const FaIcon(FontAwesomeIcons.calendar),
      onPressed: () {
        //Navigator.pop(context);
      },
    );
  }

  Widget _scheduledWorkout() {
    if (vmState.isLoading) return loader(context, padding: const EdgeInsets.only(top: spacingMedium + spacingLarge));
    if (vmState.todayWorkout == null) return nothing;

    return Expanded(
      child: Column(
        children: [
          const Gap(spacingLarge),
          const Text('Scheduled for today:'),
          const Gap(spacingMedium),
          Text(vmState.todayWorkout!.name,
            textAlign: TextAlign.center,
            style: context.text.titleLarge,
            softWrap: true,
          ),
          const Gap(spacingSmall),
          Expanded(
            child: ListView(
              children: [
                Text(vmState.todayWorkout!.description!,
                  textAlign: TextAlign.center,
                  style: titleMediumSecondary(context),
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