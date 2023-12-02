import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/utilities/functions.dart';
import 'package:jimmys/pages/workout_edit.dart';
import 'package:jimmys/services/data_service.dart';
import 'package:jimmys/services/workout_service.dart';
import 'package:jimmys/ui/widgets/my_button.dart';
import 'package:jimmys/ui/widgets/my_grouped_list_view.dart';
import 'package:provider/provider.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  State<WorkoutsPage> createState() => _WorkoutsState();
}

class _WorkoutsState extends State<WorkoutsPage> {
  final _db = DataService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final use24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

    return Scaffold(
      appBar: createAppBar(theme, 'Workouts'),
      floatingActionButton: createFloatingButton(theme, FontAwesomeIcons.plus, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutEditPage()))),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => WorkoutService(),
          child: Consumer<WorkoutService>(builder: (context, workoutService, child) {
            if (_db.workouts.isEmpty) return _createEmptyContainer();

            return Column(
              children: [
                Expanded(
                  child: MyGroupedListView(
                    key: widget.key,
                    data: _db.workouts.map((_) => _.toMap()).toList(),
                    idField: 'id',
                    pretextField: 'category',
                    iconField: 'icon',
                    textField: 'name',
                    posttextField: 'description',
                    onSelected: (MyGroupedListItem item) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutEditPage(workoutId: item.id)));
                    },
                  ),
                ),
                const Gap(spacingMedium),
                Text('Last sync: ${_db.workoutsLastSync.time(use24HourFormat)}', style: theme.textTheme.bodySmall),
                const Gap(spacingMedium),
              ],
            );
          }),
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
          style: getHeadlineLargePrimary(theme),
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
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutEditPage())),
        ),
        const Gap(spacingMedium),
      ],
    );
  }
}
