import 'package:collection/collection.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/constants.dart';
import 'package:jimmys/functions.dart';
import 'package:jimmys/models/exercise.dart';
import 'package:jimmys/models/workout.dart';
import 'package:jimmys/models/workout_exercise.dart';
import 'package:jimmys/services/animated_list_service.dart';
import 'package:jimmys/services/data_service.dart';
import 'package:jimmys/services/exercise_service.dart';
import 'package:jimmys/services/icon_service.dart';
import 'package:jimmys/services/workout_service.dart';
import 'package:jimmys/widgets/my_autocomplete.dart';
import 'package:jimmys/widgets/my_button.dart';
import 'package:jimmys/widgets/my_card.dart';
import 'package:jimmys/widgets/my_carousel.dart';
import 'package:jimmys/widgets/my_grid.dart';
import 'package:jimmys/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:uuid/uuid.dart';

class WorkoutEditPage extends StatefulWidget {
  const WorkoutEditPage({
    Key? key,
    this.workoutId,
  }) : super(key: key);

  final String? workoutId;

  @override
  State<WorkoutEditPage> createState() => _WorkoutEditState();
}

class _WorkoutEditState extends State<WorkoutEditPage> with TickerProviderStateMixin {
  final _db = DataService();
  late bool _isAdd;
  late Workout _workout;
  late List<String> _categories;

  late String _lastSave;
  late bool _use24HourFormat;
  final _formKey = GlobalKey<FormState>();
  final _workoutExerciseKey = GlobalKey<AnimatedListState>();
  final _workoutIconKey = GlobalKey<AnimatedListState>();
  late AutoScrollController _workoutIconController;
  final _focusNode = FocusNode();

  Exercise? _currentExercise;
  late AnimatedListService<WorkoutExerciseItem> _workoutExerciseList;
  late AnimatedListService<IconItem> _workoutIconList;

  final double _setsMaxHeight = 100;

  @override
  void initState() {
    super.initState();
    _lastSave = 'never';
    _isAdd = widget.workoutId == null;
    _workoutExerciseList = AnimatedListService(_workoutExerciseKey, _createRemovedWorkoutExerciseItem, <WorkoutExerciseItem>[]);
    _workoutIconList = IconService().getAnimatedIconList(_workoutIconKey);

    if (widget.workoutId != null) {
      _workout = _db.workouts.singleWhere((_) => _.id == widget.workoutId);
      for (var i = 0; i < _workoutIconList.items.length; i++) {
        _workoutIconList.items[i].isSelected = _workoutIconList.items[i].unicode == _workout.icon;
      }
    }
    else {
      var id = const Uuid().v8();
      var name = '${generateWordPairs().first.join()} workout';
      _workout = Workout(id: id, name: name);
    }

    _workoutIconController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(
        MediaQuery.of(context).padding.left,
        MediaQuery.of(context).padding.top,
        MediaQuery.of(context).padding.right,
        MediaQuery.of(context).padding.bottom
      ),
      axis: Axis.vertical,
      suggestedRowHeight: iconMedium + (spacingMicro * 2),
    );

    _categories = _db.workouts.where((_) => _.category != null && _.category!.isNotEmpty).map((_) => _.category!).toSet().toList();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FocusScope.of(context).requestFocus(_focusNode);

      if (widget.workoutId != null) {
        final we = await WorkoutService().fetchExercises(widget.workoutId);

        we.sort((a, b) => a.sequence.compareTo(b.sequence));

        _workoutExerciseList = AnimatedListService(
          _workoutExerciseKey,
          _createRemovedWorkoutExerciseItem,
          we.map((_) => WorkoutExerciseItem(
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
      }
    });
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    _use24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

    return Scaffold(
      appBar: createAppBar(theme, (_isAdd ? 'Add workout' : 'Edit workout'),
        actions: (_isAdd ? null : <Widget>[
          createDeleteAction(theme, context, 'workout', () async {
            await WorkoutService().remove(_workout);

            if (context.mounted) {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close form
            }
          })
        ])
      ),
      floatingActionButton: createFloatingButton(theme, FontAwesomeIcons.solidFloppyDisk, _saveForm),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Expanded(
                child: MyCarousel(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ListView(
                            primary: true,
                            children: [
                              MyTextFormField(
                                initialValue: _workout.name,
                                validator: (String? value) => (value == null || value.isEmpty) ? 'Name is required.' : null,
                                labelText: 'Name',
                                onChanged: (String value) => _workout.name = value,
                              ),
                              MyAutocomplete(
                                initialValue: _workout.category,
                                labelText: 'Category',
                                options: _categories,
                                onSelected: (String selection) => _workout.category = selection,
                              ),
                              MyTextFormField(
                                initialValue: _workout.description,
                                labelText: 'Description',
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) => _workout.description = value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Gap(spacingMedium),
                        Text('Select an icon for your new workout.', style: theme.textTheme.bodySmall),
                        const Gap(spacingSmall),
                        Expanded(
                          child: MyGrid(
                            gridKey: _workoutIconKey,
                            gridList: _workoutIconList,
                            controller: _workoutIconController,
                            onSelected: (String value) => _workout.icon = value,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ChangeNotifierProvider(
                          create: (context) => ExerciseService(),
                          child: Consumer<ExerciseService>(
                            builder: (context, exerciseService, child) => MyAutocomplete(
                              labelText: 'Exercise',
                              options: _db.exercises.map((_) => _.name).toList(),
                              onSelected: (String selection) {
                                setState(() {
                                  _currentExercise = _db.exercises.where((_) => _.name == selection).singleOrNull;
                                  if (kDebugMode) {
                                    if (_currentExercise == null) {
                                      print('--------------- Could not find any exercises for "$selection"');
                                    }
                                    else {
                                      print('--------------- Found "${_currentExercise!.name}"');
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _currentExercise == null,
                          replacement: IconButton(
                            iconSize: iconMedium,
                            icon: const FaIcon(FontAwesomeIcons.solidCircleDown),
                            onPressed: () async {
                              if (_currentExercise == null) return;

                              final int index = _workoutExerciseList.length;

                              _workoutExerciseList.insert(
                                index,
                                WorkoutExerciseItem(
                                  id: const Uuid().v8(),
                                  workoutId: _workout.id,
                                  exerciseId: _currentExercise!.id,
                                  isDropSet: false,
                                  sequence: index + 1,
                                  sets: ['15', '12', '8'],
                                  exercise: _currentExercise!,
                                  supersetExerciseId: null,
                                  supersetExercise: null,
                                )
                              );
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: Text('Select an exercise from the list', style: theme.textTheme.labelSmall),
                          ),
                        ),
                        Expanded(
                          child: AnimatedList(
                            key: _workoutExerciseKey,
                            initialItemCount: _workoutExerciseList.length,
                            itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                              return _createAddedWorkoutExerciseItem(context, animation, index);
                            },
                          ),
                        ),
                      ],
                    ),
                    _createSaveOptions(),
                  ],
                  onSelected: (int selectedIndex) {
                    if (selectedIndex == 1) {
                      final selectedWorkoutIconIndex = _workoutIconList.items.indexWhere((_) => _.isSelected);
                      if (selectedWorkoutIconIndex > -1) {
                        _workoutIconController.scrollToIndex(selectedWorkoutIconIndex, preferPosition: AutoScrollPosition.begin);
                      }
                    }

                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
              const Gap(spacingSmall),
              Text('Last save: $_lastSave', style: theme.textTheme.bodySmall, textAlign: TextAlign.center,),
              const Gap(spacingMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createAddedWorkoutExerciseItem(BuildContext context, Animation<double> animation, int index) {
    return _createWorkoutExerciseItem(context, animation, index: index);
  }

  Widget _createRemovedWorkoutExerciseItem(BuildContext context, Animation<double> animation, WorkoutExerciseItem item) {
    return _createWorkoutExerciseItem(context, animation, item: item);
  }

  Widget _createWorkoutExerciseItem(BuildContext context, Animation<double> animation, {int index = 0, WorkoutExerciseItem? item}) {
    final workoutExercise = item ?? _workoutExerciseList[index];
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(spacingMicro),
      child: MyCard(
        animation: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(spacingSmall),
              child: Text(
                workoutExercise.exercise!.name,
                style: getTitleMediumSecondary(theme),
                softWrap: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: spacingSmall, bottom: spacingSmall),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: spacingSmall),
                  child: IconButton(
                    iconSize: iconMedium,
                    highlightColor: theme.colorScheme.primary,
                    color: workoutExercise.isDropSet ? theme.colorScheme.primary : theme.colorScheme.onPrimaryContainer,
                    icon: const FaIcon(FontAwesomeIcons.rankingStar),
                    onPressed: () {
                      setState(() {
                        workoutExercise.isDropSet = !workoutExercise.isDropSet;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: spacingSmall, right: spacingSmall),
                  child: IconButton(
                    iconSize: iconMedium,
                    color: theme.colorScheme.error,
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
              height: workoutExercise.isSetsExpanded ? _setsMaxHeight : 0,
              child: ListView.builder(
                itemCount: workoutExercise.sets.length,
                itemBuilder: (BuildContext context, int index) {
                  final set = workoutExercise.sets[index];
                  final theme = Theme.of(context);

                  return Text(set, style: theme.textTheme.labelSmall);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSaveOptions() {
    return ListView(
      children: [
        const Gap(spacingLarge),
        MyButton(
          size: Sizes.large,
          label: const Text('Save & close'),
          icon: const FaIcon(FontAwesomeIcons.floppyDisk),
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              _saveForm();

              if (context.mounted) Navigator.pop(context);
            }
          },
        ),
        MyButton(
          size: Sizes.large,
          label: const Text('Save & add new workout'),
          icon: const FaIcon(FontAwesomeIcons.rotateLeft),
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              _saveForm();

              if (context.mounted) {
                Navigator.pop(context); // Close form
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutEditPage()));
              }
            }
          },
        ),
        MyButton(
          size: Sizes.large,
          label: const Text('Save & edit exercises'),
          icon: const FaIcon(FontAwesomeIcons.listOl),
          onTap: () async {}
        ),
        MyButton(
          size: Sizes.large,
          label: const Text('Save & schedule'),
          icon: const FaIcon(FontAwesomeIcons.xmarksLines),
          onTap: () async {}
        ),
      ]
    );
  }

  _saveForm() async {
    if (_formKey.currentState!.validate()) {
      // form is valid
      await WorkoutService().save(_workout);

      for (final workoutExercise in _workoutExerciseList.items) {
        await WorkoutService().saveWorkoutExercise(workoutExercise);
      }

      setState(() {
        _lastSave = DateTime.now().time(_use24HourFormat);
      });
    }
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
