import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_view_widget_state.dart';
import 'package:jimmys/ui/screens/workout_edit/workout_edit_view.dart';
import 'package:jimmys/ui/screens/workout_list/workout_list_contract.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/my_grouped_list_view.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';

class WorkoutListView extends StatefulWidget {
  const WorkoutListView({super.key});

  @override
  State<WorkoutListView> createState() => _WorkoutListViewWidgetState();
}

class _WorkoutListViewWidgetState extends BaseViewWidgetState<WorkoutListView, WorkoutListVMContract, WorkoutListViewModelState> with WidgetsMixin implements WorkoutListVContract {
  final TextEditingController searchBarController = TextEditingController();

  void searchWorkoutsListener() => searchWorkouts(searchBarController.text);
  void searchWorkouts(String text) {
    text = text.toLowerCase();

    for (var workoutItem in vmState.workoutList) {
      workoutItem.isVisible =
        workoutItem.data.name.toLowerCase().contains(text) ||
        (workoutItem.data.description.isNotNullNorEmpty && workoutItem.data.description!.toLowerCase().contains(text));
    }

    notify();
  }

  @override
  Future<void> onInitState() async {
    await reload();
    searchBarController.addListener(searchWorkoutsListener);
  }

  @override
  Widget contentBuilder(BuildContext context) {
    final isLoaded = !vmState.isLoading;
    final isLoadedAndEmpty = isLoaded && vmState.workoutList.isEmpty;
    final isLoadedAndNotEmpty = isLoaded && vmState.workoutList.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isLoadedAndNotEmpty ? searchBar(context, searchBarController) : nothing,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: fab(context, FontAwesomeIcons.plus, _workoutAddOnPressed),
      body: SafeArea(
        child: Stack(
          children: [
            if (!isLoaded)
              loader(context),

            if (isLoadedAndEmpty)
              _noWorkoutsContainer(),

            if (isLoadedAndNotEmpty)
              MyGroupedListView(
                key: widget.key,
                data: vmState.workoutList
                  .where((_) => _.isVisible)
                  .map((_) => _.data.toMap())
                  .toList(),
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(spacingLarge),
        const FaIcon(FontAwesomeIcons.ghost,
          size: spacingLarge,
        ),
        const Gap(spacingMedium),
        Text('Workouts are a myth around here ...',
          textAlign: TextAlign.center,
          style: headlineLargePrimary(context),
        ),
      ],
    );
  }

  void _workoutAddOnPressed() async {
    final page = WorkoutEditView(
      workout: Workout.create(),
      isAdd: true,
    );

    await navigate(context, page);
    vmContract.saveWorkout(page.workout);
    await reload();
  }

  void _workoutEditOnPressed(MyGroupedListItem item) async {
    final page = WorkoutEditView(
      workout: vmState.workoutList.firstWhere((_) => _.data.id == item.id).data,
      isAdd: false,
    );

    await navigate(context, page);
    vmContract.saveWorkout(page.workout);
    await reload();
  }

  @override
  void showError(String message) {
    showSnackBar(context, message);
  }

  @override
  void dispose() {
    searchBarController.removeListener(searchWorkoutsListener);
    searchBarController.dispose();
    super.dispose();
  }
}