import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:todoo_app/constants.dart';
import 'package:todoo_app/providers/theme_colour_provider.dart';
import 'package:todoo_app/utilities/util.dart';
import 'package:todoo_app/widgets/tasks_alert_dialogue.dart';
import 'package:todoo_app/widgets/tasks_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Widget _buildListTile(
      {required BuildContext context,
      required String tileIcon,
      required String titleText,
      required Function() onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Iconify(
        tileIcon,
        size: 22,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(titleText),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColourHandler = ref.read(appThemeSeedColourProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: kScaffoldBodyPadding,
        child: ListView(
          children: [
            _buildListTile(
              context: context,
              tileIcon: Mdi.palette,
              titleText: 'Change App Colour',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return TodooAlertDialogue(
                        title: 'Choose Colour',
                        contentItems: seedColourMap.keys.map((colour) {
                          return Center(
                            child: TodooButton(
                              onButtonTap: () {
                                seedColourHandler
                                    .changeSeedColour(seedColourMap[colour]!);
                                Navigator.of(context).pop();
                              },
                              icon: Mdi.square_rounded,
                              iconColour: seedColourMap[colour],
                              buttonText: Utils.getColourLabel(colour),
                              textColour: seedColourMap[colour],
                              buttonColour:
                                  seedColourMap[colour]!.withOpacity(0.15),
                              buttonWidth: 200,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(4),
                            ),
                          );
                        }).toList(),
                      );
                    });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            _buildListTile(
              context: context,
              tileIcon: Ic.baseline_18_up_rating,
              titleText: 'Rate App',
              onTap: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            _buildListTile(
              context: context,
              tileIcon: Mdi.bug,
              titleText: 'Report Bugs',
              onTap: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            _buildListTile(
              context: context,
              tileIcon: Mdi.login,
              titleText: 'Login (Coming Soon)',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
