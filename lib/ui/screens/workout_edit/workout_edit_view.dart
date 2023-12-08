import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/core/extensions/build_context.dart';
import 'package:jimmys/core/extensions/datetime.dart';
import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/domain/models/workout_exercise.dart';
import 'package:jimmys/ui/screens/_base/base_view_widget_state.dart';
import 'package:jimmys/ui/screens/workout_edit/workout_edit_contract.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/my_autocomplete.dart';
import 'package:jimmys/ui/widgets/generic/my_button.dart';
import 'package:jimmys/ui/widgets/generic/my_card.dart';
import 'package:jimmys/ui/widgets/generic/my_carousel.dart';
import 'package:jimmys/ui/widgets/generic/my_grid.dart';
import 'package:jimmys/ui/widgets/generic/my_number_stepper.dart';
import 'package:jimmys/ui/widgets/generic/my_text_form_field.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';
import 'package:jimmys/utilities/animated_list_service.dart';
import 'package:jimmys/utilities/icon_service.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:uuid/uuid.dart';

class WorkoutEditView extends StatefulWidget {
  const WorkoutEditView({
    super.key,
    this.workoutId
  });

  final String? workoutId;

  @override
  State<WorkoutEditView> createState() => _WorkoutEditViewWidgetState();
}

class _WorkoutEditViewWidgetState extends BaseViewWidgetState<WorkoutEditView, WorkoutEditVMContract, WorkoutEditViewModelState> with WidgetsMixin, TickerProviderStateMixin implements WorkoutEditVContract {

  /// Override to disable auto rebuilds on any vmState change.
  ///@override
  ///bool get autoSubscribeToVmStateChanges => false;

  late AnimatedListService<WorkoutExerciseItem> _workoutExerciseList;
  late AutoScrollController _workoutIconController;
  late AnimatedListService<IconItem> _workoutIconList;

  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _workoutExerciseKey = GlobalKey<AnimatedListState>();
  final _workoutIconKey = GlobalKey<AnimatedListState>();

  @override
  void onInitState() {
    super.initState();
    _initializeWorkoutIconList();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.focusScope.requestFocus(_focusNode);
      _initializeWorkoutExerciseList();
    });
  }

  void _initializeWorkoutIconList() {
    _workoutIconController = scrollController(context);
    _workoutIconList = IconService.getAnimatedIconList(_workoutIconKey);

    if (vmState.isAdd) return;

    for (var i = 0; i < _workoutIconList.items.length; i++) {
      final isSelected = _workoutIconList.items[i].unicode == vmState.workout.icon;

      _workoutIconList.items[i].isSelected = vmState.workout.icon.isNullOrEmpty ? false : isSelected;
    }
  }

  void _initializeWorkoutExerciseList() {
    _workoutExerciseList = vmState.workoutExercises.isEmpty
      ? AnimatedListService(_workoutExerciseKey, _removedWorkoutExerciseItemBuilder, [])
      : AnimatedListService(_workoutExerciseKey, _removedWorkoutExerciseItemBuilder,
          vmState.workoutExercises.map((_) => WorkoutExerciseItem(
            id: _.id,
            workoutId: _.workoutId,
            exerciseId: _.exerciseId,
            isDropSet: _.isDropSet,
            sequence: _.sequence,
            sets: _.sets,
            exercise: _.exercise,
            supersetExerciseId: _.supersetExerciseId,
            supersetExercise: _.supersetExercise,
          )),
        );

      /// vmState.workoutExercises.clear();
  }

  Widget _removedWorkoutExerciseItemBuilder(BuildContext context, Animation<double> animation, WorkoutExerciseItem item) => _workoutExerciseItemBuilder(animation, item: item);

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, (vmState.isAdd ? 'Add workout' : 'Edit workout'), actions: _appBarActions()),
      floatingActionButton: fab(context, FontAwesomeIcons.solidFloppyDisk, _saveForm),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Expanded(
                child: MyCarousel(
                  onSelected: _carouselOnSelected,
                  children: [
                    _carouselPageMain(),
                    _carouselPageIcon(),
                    _carouselPageExercises(),
                    _carouselPageSaveOptions(),
                  ],
                ),
              ),
              const Gap(spacingSmall),
              _lastSave(),
              const Gap(spacingSmall),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget>? _appBarActions() {
    if (vmState.isAdd) return null;

    return [
      deleteAction(context, 'workout', () {
        vmContract.remove();

        if (!vmState.hasError && context.mounted) {
          pop(context); /// Close dialog
          pop(context); /// Close form
        }
      })
    ];
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    vmContract.save();

    for (final workoutExercise in _workoutExerciseList.items) {
      vmContract.saveWorkoutExercise(workoutExercise);
    }

    setState(() {
      vmState.lastSave = DateTime.now();
    });
  }

  //region Carousel Pages
  void _carouselOnSelected(int selectedIndex) {
    /// onSelected for carousel icons page
    if (selectedIndex == 1) {
      final iconIndex = _workoutIconList.items.indexWhere((_) => _.isSelected);

      if (iconIndex > -1) {
        _workoutIconController.scrollToIndex(iconIndex, preferPosition: AutoScrollPosition.begin);
      }
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  Widget _carouselPageMain() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            primary: true,
            children: [
              MyTextFormField(
                initialValue: vmState.workout.name,
                validator: (value) => (value.isNullOrEmpty) ? 'Name is required.' : null,
                labelText: 'Name',
                onChanged: (String value) => vmState.workout.name = value,
              ),
              MyAutocomplete(
                initialValue: vmState.workout.category,
                labelText: 'Category',
                options: vmState.categories,
                onSelected: (selection) => vmState.workout.category = selection,
              ),
              MyTextFormField(
                initialValue: vmState.workout.description,
                labelText: 'Description',
                keyboardType: TextInputType.multiline,
                onChanged: (value) => vmState.workout.description = value,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _carouselPageIcon() {
    return Column(
      children: [
        const Gap(spacingMedium),
        Text('Select an icon for your new workout.',
            style: context.textTheme.bodySmall
        ),
        const Gap(spacingSmall),
        Expanded(
          child: MyGrid(
            gridKey: _workoutIconKey,
            gridList: _workoutIconList,
            controller: _workoutIconController,
            onSelected: (String value) => vmState.workout.icon = value,
          ),
        ),
      ],
    );
  }

  Widget _carouselPageExercises() {
    return Column(
      children: [
        _exerciseAutocomplete(),
        Visibility(
          visible: vmState.currentExercise == null,
          replacement: IconButton(
            iconSize: iconMedium,
            icon: const FaIcon(FontAwesomeIcons.solidCircleDown),
            onPressed: _workoutExerciseInsertOnPressed,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text('Select an exercise from the list',
                style: context.textTheme.labelSmall
            ),
          ),
        ),
        Expanded(
          child: AnimatedList(
              key: _workoutExerciseKey,
              initialItemCount: _workoutExerciseList.length,
              itemBuilder: (BuildContext context, int index, Animation<double> animation) => _workoutExerciseItemBuilder(animation, index: index)
          ),
        ),
      ],
    );
  }

  Widget _exerciseAutocomplete() {
    return MyAutocomplete(
      labelText: 'Exercise',
      options: vmState.exercises.map((_) => _.name).toList(),
      onSelected: (String selection) {
        setState(() {
          vmState.currentExercise = vmState.exercises.where((_) => _.name == selection).singleOrNull;
        });
      },
    );
  }

  void _workoutExerciseInsertOnPressed() {
    if (vmState.currentExercise == null) return;

    final index = _workoutExerciseList.length;

    _workoutExerciseList.insert(
        index,
        WorkoutExerciseItem(
          id: const Uuid().v8(),
          workoutId: vmState.workout.id,
          exerciseId: vmState.currentExercise!.id,
          isDropSet: false,
          sequence: index + 1,
          sets: ['15', '12', '8'],
          exercise: vmState.currentExercise!,
          supersetExerciseId: null,
          supersetExercise: null,
        )
    );
  }

  Widget _workoutExerciseItemBuilder(Animation<double> animation, {int index = 0, WorkoutExerciseItem? item}) {
    final workoutExercise = item ?? _workoutExerciseList[index];

    return Padding(
      padding: const EdgeInsets.all(spacingMicro),
      child: MyCard(
        animation: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(spacingSmall),
              child: Text(workoutExercise.exercise!.name,
                style: titleMediumSecondary(context),
                softWrap: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: spacingSmall, right: spacingMedium),
                    child: ElevatedButton(
                      child: Text('Sets: ${workoutExercise.sets.join(', ')}'),
                      onPressed: () {
                        setState(() {
                          for (var i = 0; i < _workoutExerciseList.items.length; i++) {
                            _workoutExerciseList[i].isSetsExpanded = i == index ? !_workoutExerciseList[i].isSetsExpanded : false;
                          }
                        });
                      },
                    ),
                  ),
                ),
                IconButton(
                  iconSize: iconMedium,
                  highlightColor: context.colorScheme.primary,
                  color: workoutExercise.isDropSet ? context.colorScheme.primary : context.colorScheme.onPrimaryContainer,
                  icon: const FaIcon(FontAwesomeIcons.rankingStar),
                  onPressed: () {
                    setState(() {
                      workoutExercise.isDropSet = !workoutExercise.isDropSet;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: spacingMedium, right: spacingSmall),
                  child: IconButton(
                    iconSize: iconMedium,
                    color: context.colorScheme.error,
                    icon: const FaIcon(FontAwesomeIcons.trash),
                    onPressed: () {
                      _workoutExerciseList.removeAt(_workoutExerciseList.indexOf(workoutExercise));
                    },
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: duration,
              height: workoutExercise.isSetsExpanded ? workoutExercise.sets.length * 50 : 0,
              child: Column(
                children: [
                  const Divider(height: spacingSmall, thickness: 1, indent: spacingMedium, endIndent: spacingMedium),
                  Expanded(
                    child: ListView.builder(
                      itemCount: workoutExercise.sets.length,
                      itemBuilder: (BuildContext context, int index) {
                        var set = workoutExercise.sets[index];

                        return MyNumberStepper(
                          initialValue: int.parse(set),
                          step: 1,
                          onChanged: (value) {
                            setState(() {
                              workoutExercise.sets[index] = value.toString();
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _carouselPageSaveOptions() {
    /// For readability, leave onPressed function bodies in this function
    return ListView(
        children: [
          const Gap(spacingLarge),
          MyButton(
            size: Sizes.large,
            label: const Text('Save & close'),
            icon: const FaIcon(FontAwesomeIcons.floppyDisk),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _saveForm();

                if (context.mounted) pop(context);
              }
            },
          ),
          MyButton(
            size: Sizes.large,
            label: const Text('Save & add new workout'),
            icon: const FaIcon(FontAwesomeIcons.rotateLeft),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _saveForm();

                if (context.mounted) {
                  pop(context); /// Close form
                  navigate(context, const WorkoutEditView());
                }
              }
            },
          ),
          MyButton(
              size: Sizes.large,
              label: const Text('Save & edit exercises'),
              icon: const FaIcon(FontAwesomeIcons.listOl),
              onPressed: () async {}
          ),
          MyButton(
              size: Sizes.large,
              label: const Text('Save & schedule'),
              icon: const FaIcon(FontAwesomeIcons.xmarksLines),
              onPressed: () async {}
          ),
        ]
    );
  }
  //endregion

  Widget _lastSave() {
    final value = vmState.lastSave != null ? vmState.lastSave!.time(use24HourFormat(context)) : 'never';

    return Text('Last save: $value',
      style: context.textTheme.bodySmall,
      textAlign: TextAlign.center
    );
  }

  @override
  void showError(String message) {
    showSnackBar(context, message);
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }
}

class WorkoutExerciseItem extends WorkoutExercise {
  WorkoutExerciseItem({
    required super.id,
    required super.workoutId,
    required super.exerciseId,
    required super.isDropSet,
    required super.sequence,
    required super.sets,
    required super.exercise,
    required super.supersetExerciseId,
    required super.supersetExercise,
  });

  bool isSetsExpanded = false;
}