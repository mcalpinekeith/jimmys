import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_view_widget_state.dart';
import 'package:jimmys/ui/screens/workout_edit/workout_edit_view.dart';
import 'package:jimmys/ui/screens/workout_list/workout_list_contract.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/my_button.dart';
import 'package:jimmys/ui/widgets/generic/my_grouped_list_view.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';

class WorkoutListView extends StatefulWidget {
  const WorkoutListView({super.key});

  @override
  State<WorkoutListView> createState() => _WorkoutListViewWidgetState();
}

class _WorkoutListViewWidgetState extends BaseViewWidgetState<WorkoutListView, WorkoutListVMContract, WorkoutListViewModelState> with WidgetsMixin implements WorkoutListVContract {
  @override
  Future<void> onInitState() async {
    await reload();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Workouts'),
      floatingActionButton: fab(context, FontAwesomeIcons.plus, _workoutAddOnPressed),
      body: SafeArea(
        child: Stack(
          children: [
            if (vmState.isLoading)
              loader(context),

            if (!vmState.isLoading && vmState.workoutList.isEmpty)
              _noWorkoutsContainer(),

            if (!vmState.isLoading && vmState.workoutList.isNotEmpty)
              MyGroupedListView(
                key: widget.key,
                data: vmState.workoutList.map((_) => _.toMap()).toList(),
                idField: 'id',
                topTextField: 'category',
                iconField: 'icon',
                middleTextField: 'name',
                bottomTextField: 'description',
                onSelected: (MyGroupedListItem item) => _workoutEditOnPressed(item),
              ),
          ],
        ),
      ),
    );
  }

  Widget _noWorkoutsContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(spacingMedium),
        Text('Workouts are a myth around here ...',
          textAlign: TextAlign.center,
          style: headlineLargePrimary(context),
        ),
        const Gap(spacingMedium),
        const FaIcon(FontAwesomeIcons.ghost,
          size: spacingLarge,
        ),
        const Gap(spacingLarge),
        MyButton(
          label: const Text('Add workout'),
          icon: const FaIcon(FontAwesomeIcons.circlePlus),
          onPressed: _workoutAddOnPressed,
        ),
        const Gap(spacingMedium),
      ],
    );
  }

  void _workoutAddOnPressed() async {
    await navigate(context, WorkoutEditView(
      workout: Workout.create(),
      isAdd: true,
    ));

    await reload();
  }

  void _workoutEditOnPressed(MyGroupedListItem item) async {
    await navigate(context, WorkoutEditView(
      workout: vmState.workoutList.firstWhere((_) => _.id == item.id),
      isAdd: false,
    ));

    await reload();
  }

  @override
  void showError(String message) {
    showSnackBar(context, message);
  }
}