import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/domain/models/providers/workout_list.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_view_widget_state.dart';
import 'package:jimmys/ui/screens/workout_edit/workout_edit_view.dart';
import 'package:jimmys/ui/screens/workout_list/workout_list_contract.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/my_button.dart';
import 'package:jimmys/ui/widgets/generic/my_grouped_list_view.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';
import 'package:provider/provider.dart';

class WorkoutListView extends StatefulWidget {
  const WorkoutListView({super.key});

  @override
  State<WorkoutListView> createState() => _WorkoutListViewWidgetState();
}

class _WorkoutListViewWidgetState extends BaseViewWidgetState<WorkoutListView, WorkoutListVMContract, WorkoutListViewModelState> with WidgetsMixin implements WorkoutListVContract {
  @override
  void onInitState() {
    vmState.workoutListProvider = context.read<WorkoutListProvider>();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Workouts'),
      floatingActionButton: fab(context, FontAwesomeIcons.plus, () {
        navigate(context, WorkoutEditView(
          workout: Workout.create(),
          isAdd: true,
        ));
      }),
      body: SafeArea(
        child: Stack(
          children: [
            if (vmState.isLoading)
              loader(context),

            if (!vmState.hasError && !vmState.isLoading && vmState.workoutList.isEmpty)
              _noWorkoutsContainer(),

            if (vmState.workoutList.isNotEmpty)
              Expanded(
                child: MyGroupedListView(
                  key: widget.key,
                  data: vmState.workoutList.map((_) => _.toMap()).toList(),
                  idField: 'id',
                  topTextField: 'category',
                  iconField: 'icon',
                  middleTextField: 'name',
                  bottomTextField: 'description',
                  onSelected: (MyGroupedListItem item) {
                    navigate(context, WorkoutEditView(
                      workout: vmState.workoutList.firstWhere((_) => _.id == item.id),
                      isAdd: false,
                    ));
                  },
                ),
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
          onPressed: () {
            navigate(context, WorkoutEditView(
              workout: Workout.create(),
              isAdd: true,
            ));
          }
        ),
        const Gap(spacingMedium),
      ],
    );
  }

  @override
  void showError(String message) {
    showSnackBar(context, message);
  }
}