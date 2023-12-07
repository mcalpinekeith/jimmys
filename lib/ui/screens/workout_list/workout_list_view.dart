import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
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

class _WorkoutListViewWidgetState extends BaseViewWidgetState<WorkoutListView, WorkoutListVMContract, WorkoutListVMState> with WidgetsMixin implements WorkoutListViewContract {
  @override
  void onInitState() {}

  @override
  Widget contentBuilder(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(theme, 'Workouts'),
      floatingActionButton: fab(theme, FontAwesomeIcons.plus, () => navigate(context, const WorkoutEditView())),
      body: SafeArea(
        child: Visibility(
          visible: vmState.workoutList.isNotEmpty,
          replacement: _createEmptyContainer(),
          child: Column(
            children: [
              Expanded(
                child: MyGroupedListView(
                  key: widget.key,
                  data: vmState.workoutList.map((_) => _.toMap()).toList(),
                  idField: 'id',
                  pretextField: 'category',
                  iconField: 'icon',
                  textField: 'name',
                  posttextField: 'description',
                  onSelected: (MyGroupedListItem item) => navigate(context, WorkoutEditView(workoutId: item.id)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createEmptyContainer() {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(spacingMedium),
        Text(
          'Workouts are a myth around here ...',
          textAlign: TextAlign.center,
          style: headlineLargePrimary(theme),
        ),
        const Gap(spacingMedium),
        const FaIcon(
          FontAwesomeIcons.ghost,
          size: spacingLarge,
        ),
        const Gap(spacingLarge),
        MyButton(
          label: const Text('Add workout'),
          icon: const FaIcon(FontAwesomeIcons.circlePlus),
          onTap: () => navigate(context, const WorkoutEditView()),
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