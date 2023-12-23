import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/core/extensions/build_context.dart';
import 'package:jimmys/core/extensions/iterable.dart';
import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_view_widget_state.dart';
import 'package:jimmys/ui/screens/workout_edit/workout_edit_view.dart';
import 'package:jimmys/ui/screens/workout_list/workout_list_contract.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/controllers/list_controller.dart';
import 'package:jimmys/ui/widgets/generic/my_grouped_list_view.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';

class WorkoutListView extends StatefulWidget {
  const WorkoutListView({super.key});

  @override
  State<WorkoutListView> createState() => _WorkoutListViewWidgetState();
}

class _WorkoutListViewWidgetState extends BaseViewWidgetState<WorkoutListView, WorkoutListVMContract, WorkoutListViewModelState> with WidgetsMixin implements WorkoutListVContract {
  //region Filter
  /// isVisible[0]
  late TextEditingController _searchController;
  void _searchListener() => _searchWorkouts(_searchController.text);
  void _searchWorkouts(String text) {
    text = text.toLowerCase();

    for (var item in vmState.workoutList) {
      item.isVisible[0] = text.isNullOrEmpty ? true :
      (
        item.data.name.toLowerCase().contains(text) ||
        (item.data.description.isNotNullNorEmpty && item.data.description!.toLowerCase().contains(text))
      );
    }

    notify();
  }

  /// isVisible[1]
  late ListController _exerciseCategoriesController;
  void _exerciseCategoriesFilterListener() => _exerciseCategoriesFilterWorkouts(_exerciseCategoriesController.selected);
  void _exerciseCategoriesFilterWorkouts(List<String> selected) {
    for (var item in vmState.workoutList) {
      /// TODO: search by exercise categories
      //item.isVisible[1] = selected.isEmpty ? true : selected.contains(workoutItem.data.);
      item.isVisible[1] = true;
    }

    notify();
  }

  /// isVisible[2]
  late ListController _categoriesController;
  void _categoriesFilterListener() => _categoriesFilterWorkouts(_categoriesController.selected);
  void _categoriesFilterWorkouts(List<String> selected) {
    for (var item in vmState.workoutList) {
      item.isVisible[2] = selected.isEmpty ? true : selected.contains(item.data.category);
    }

    notify();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _bottomSheetController;
  bool _bottomSheetIsVisible = false;

  void _initializeControllers() {
    _searchController = TextEditingController();
    _exerciseCategoriesController = ListController('exercises with categories', ExerciseCategories.values.map((_) => _.title).toList());
    _categoriesController = ListController('workouts with categories', vmState.workoutList.where((_) => _.data.category.isNotNullNorEmpty).map((_) => _.data.category).toDistinct());

    _searchController.addListener(_searchListener);
    _exerciseCategoriesController.addListener(_exerciseCategoriesFilterListener);
    _categoriesController.addListener(_categoriesFilterListener);
  }
  //endregion

  @override
  Future<void> onInitState() async {
    await reload();
    _initializeControllers();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    final isLoaded = !vmState.isLoading;
    final isLoadedAndEmpty = isLoaded && vmState.workoutList.isEmpty;
    final isLoadedAndNotEmpty = isLoaded && vmState.workoutList.isNotEmpty;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: isLoadedAndNotEmpty ? searchBar(context, _searchController, IconButton(
          iconSize: iconMedium,
          icon: const FaIcon(FontAwesomeIcons.filter),
          onPressed: _filterOnPressed)
        ) : nothing,
        toolbarHeight: searchBarMaxHeight + spacingSmall,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: fab(context, FontAwesomeIcons.plus, _addOnPressed),
      body: SafeArea(
        child: Stack(
          children: [
            if (!isLoaded)
              loader(context),

            if (isLoadedAndEmpty)
              noResults(context, 'Workouts'),

            if (isLoadedAndNotEmpty)
              Column(
                children: [
                  filterSummary(_exerciseCategoriesController),
                  filterSummary(_categoriesController),
                  Expanded(
                    child: MyGroupedListView(
                      key: widget.key,
                      data: vmState.workoutList
                        .where((_) => _.isVisible.every((__) => __))
                        .map((_) => _.data.toMap())
                        .toList(),
                      idField: 'id',
                      topTextField: 'category',
                      iconField: 'icon',
                      middleTextField: 'name',
                      bottomTextField: 'description',
                      onSelected: (MyGroupedListItem item) => _editOnPressed(item),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  //region Filter
  void _filterOnPressed() {
    if (_bottomSheetIsVisible) {
      closeBottomsheet();
      return;
    }

    _bottomSheetIsVisible = true;
    _bottomSheetController = _scaffoldKey.currentState?.showBottomSheet((context) => Column(
      children: [
        Row(
          children: [
            IconButton(
              iconSize: iconLarge,
              icon: const FaIcon(FontAwesomeIcons.solidCircleXmark),
              color: Colors.black54,
              onPressed: closeBottomsheet,
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              filter(_bottomSheetController, _exerciseCategoriesController),
              const Gap(spacingSmall),
              filter(_bottomSheetController, _categoriesController),
            ],
          ),
        ),
      ]),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusMedium),
          topRight: Radius.circular(radiusMedium)
        ),
      ),
      constraints: BoxConstraints.tight(Size(context.media.size.width, context.media.size.height * 0.5)),
    );
  }

  void closeBottomsheet() {
    if (_bottomSheetController == null) return;

    _bottomSheetController!.close();
    _bottomSheetIsVisible = false;
  }
  //endregion

  void _addOnPressed() async {
    final page = WorkoutEditView(
      workout: Workout.create(),
      isAdd: true,
    );

    await navigate(context, page);
    vmContract.saveWorkout(page.workout);
    await reload();
  }

  void _editOnPressed(MyGroupedListItem item) async {
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
    _searchController.removeListener(_searchListener);
    _searchController.dispose();

    _exerciseCategoriesController.removeListener(_exerciseCategoriesFilterListener);
    _exerciseCategoriesController.dispose();

    _categoriesController.removeListener(_categoriesFilterListener);
    _categoriesController.dispose();

    super.dispose();
  }
}