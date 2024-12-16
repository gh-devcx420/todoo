import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/pixelarticons.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:todoo_app/constants.dart';
import 'package:todoo_app/enums.dart';
import 'package:todoo_app/models/tasks_model.dart';
import 'package:todoo_app/providers/bottom_nav_bar_provider.dart';
import 'package:todoo_app/providers/tasks_provider.dart';
import 'package:todoo_app/utilities/util.dart';
import 'package:todoo_app/widgets/tasks_alert_dialogue.dart';
import 'package:todoo_app/widgets/tasks_button.dart';
import 'package:todoo_app/widgets/tasks_confirmation_dialogue.dart';
import 'package:todoo_app/widgets/tasks_text_field.dart';

class AddTasksScreen extends ConsumerStatefulWidget {
  const AddTasksScreen({super.key});

  @override
  ConsumerState<AddTasksScreen> createState() => _AddTasksPageState();
}

class _AddTasksPageState extends ConsumerState<AddTasksScreen> {
  ///Variables used to hold the inputs selected by the user.
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  DateTime? _selectedDate;
  final _dateInputController = TextEditingController();
  DateTime? _selectedTime;
  final _timeInputController = TextEditingController();
  bool isPriorityFirstTap = true;
  Priority _selectedPriority = Priority.none;
  bool isCategoryFirstTap = true;
  Category _selectedCategory = Category.none;
  bool isLocationFirstTap = true;
  String? _selectedLocation = '';
  final _locationController = TextEditingController();
  bool _isReminderSet = false;

  ///Variables used to handle app functionality.
  bool _isInitialized = false;
  final FocusNode _titleFieldFocusNode = FocusNode();
  final FocusNode _descriptionFieldFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final _todayDate = DateTime.now();

  /// Function Used to unfocus the title and description text fields
  /// to ensure the keyboard is dismissed before handling a button tap.
  void _prepareButtonTap() {
    _titleFieldFocusNode.unfocus();
    _descriptionFieldFocusNode.unfocus();
  }

  /// Function Used to toggle the state of the reminder,
  /// switching it between active and inactive.
  void _toggleReminder() {
    setState(() {
      _isReminderSet = !_isReminderSet;
    });
  }

  /// Function Used to open a date picker dialog, allowing the user
  /// to select a date.
  ///
  /// If a date is picked, it updates the `_selectedDate` and sets the date
  /// input controller's text.
  ///
  /// If no date is picked, it sets the date input to "No Date Picked".
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: _todayDate,
      lastDate:
          DateTime(_todayDate.year + 20, _todayDate.month, _todayDate.day),
    );
    if (pickedDate != null) {
      _selectedDate = pickedDate;
      _dateInputController.text = Utils.formatDate(pickedDate);
    } else {
      if (_dateInputController.text.isEmpty) {
        _dateInputController.text = "No Date Picked";
      }
    }
  }

  /// Function Used to open a time picker dialog, allowing the user
  /// to select a time.
  ///
  /// If a time is picked, it updates the `_selectedTime`, sets the reminder
  /// state to true, and updates the time input controller's text.
  ///
  /// If no time is picked, it sets the time input to 'No Time Picked' and
  /// resets the reminder state to false.
  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_todayDate),
    );

    if (pickedTime != null) {
      _selectedTime = DateTime(
        _todayDate.year,
        _todayDate.month,
        _todayDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      setState(() {
        _isReminderSet = true;
      });
      _timeInputController.text = Utils.formatTime(_selectedTime!);
    } else {
      _selectedTime = null;

      _timeInputController.text = 'No Time Picked';
      setState(() {
        _isReminderSet = false;
      });
    }
  }

  /// Function Used to set the selected task priority based on the user's choice.
  /// Updates the `_selectedPriority` state to the chosen priority.
  void _pickPriority(Priority pickedPriority) {
    setState(() {
      _selectedPriority = pickedPriority;
    });
  }

  /// Function Used to set the selected task category based on the user's choice.
  /// Updates the `_selectedCategory` state to the chosen category.
  void _pickCategory(Category pickedCategory) {
    setState(() {
      _selectedCategory = pickedCategory;
    });
  }

  /// Function Used to update the selected task location with the value
  /// from the `_locationController` and changes the state accordingly.
  void _pickLocation() {
    setState(() {
      _selectedLocation = _locationController.text.trim();
    });
  }

  /// Function used to build error message text widgets for task validation
  /// based on current user input.
  Widget _buildValidatorErrorMessages() {
    if (_titleTextController.text.isEmpty) {
      return Text(
        'Title is empty! Task must have a title.',
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
      );
    } else if (_selectedDate == null) {
      return Text(
        'Date is not selected! Task must have a date.',
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        textAlign: TextAlign.left,
      );
    } else if (_selectedDate!.isBefore(_todayDate) &&
        _selectedTime!.isBefore(_todayDate)) {
      return Text(
        'Time can\'t be in the past',
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        textAlign: TextAlign.left,
      );
    }
    return Container();
  }

  /// Function used to prepare input fields for saving by trimming unnecessary
  /// whitespace from the title and description text controllers.
  void _prepareInputsForSave() {
    _titleTextController.text = _titleTextController.text.trim();
    _descriptionTextController.text = _descriptionTextController.text.trim();
    _locationController.text = _locationController.text.trim();
  }

  /// Function used to handle the cancellation action by unfocusing
  /// the current context and navigating to a different tab in the
  /// bottom navigation bar.
  void _onCancelTap() {
    final navBarWatcher = ref.read(bottomNavigationBarProvider.notifier);
    FocusScope.of(context).unfocus();
    navBarWatcher.onNavBarItemTap(1);
  }

  ///
  void _onDeleteTap(bool isEditing) {
    final currentlyEditingTaskWatcher = ref.watch(currentEditingTaskProvider);
    final taskListWatcher = ref.watch(allTasksProvider);
    final taskHandler = ref.read(allTasksProvider.notifier);
    final navBarStateHandler = ref.read(bottomNavigationBarProvider.notifier);

    final editingTask = taskListWatcher.firstWhere((task) {
      return task.id == currentlyEditingTaskWatcher.values.first;
    });

    showDialog(
        context: context,
        builder: (context) {
          return TodooConfirmationDialogue(
            confirmationDialogueTitle: 'Confirm Deletion',
            confirmationDialogueBodyText:
                'Are you sure you want to delete this task permanently?',
            onCancelTap: () {
              Navigator.of(context).pop();
            },
            onConfirmTap: () {
              Navigator.of(context).pop();
              taskHandler.deleteTask(editingTask);
              navBarStateHandler.onNavBarItemTap(1);
            },
            confirmButtonText: 'Delete Forever',
          );
        });
  }

  /// Function used to save a task. If the task is in edit mode,
  /// it updates the existing task; otherwise, it adds a new one.
  ///
  /// After saving, it navigates back to the task list.
  void _onSaveTap(TodooTask newTask, bool isEditing) async {
    final allTasksStateHandler = ref.read(allTasksProvider.notifier);
    final navBarStateHandler = ref.read(bottomNavigationBarProvider.notifier);
    final currentlyEditingTaskWatcher = ref.watch(currentEditingTaskProvider);
    final taskListWatcher = ref.watch(allTasksProvider);
    final currentlyEditingTaskHandler =
        ref.read(currentEditingTaskProvider.notifier);

    /// move this to single function and handle cases in if else block.
    if (isEditing) {
      bool confirmEdits = await showDialog(
          context: context,
          builder: (context) {
            return TodooConfirmationDialogue(
              confirmationDialogueTitle: 'Confirm Edits',
              confirmationDialogueBodyText:
                  'Are you sure you want to confirm changes?',
              onCancelTap: () {
                Navigator.pop(context, false);
              },
              onConfirmTap: () {
                Navigator.pop(context, true);
                navBarStateHandler.onNavBarItemTap(1);
              },
              confirmButtonText: 'Confirm Edits',
            );
          });
      if (confirmEdits) {
        final editingTask = taskListWatcher.firstWhere((task) {
          return task.id == currentlyEditingTaskWatcher.values.first;
        });
        allTasksStateHandler.editTask(
          TodooTask.withID(
            id: editingTask.id,
            title: _titleTextController.text,
            description: _descriptionTextController.text,
            deadlineDate: _selectedDate!,
            deadlineTime: _selectedTime,
            category: _selectedCategory,
            priority: _selectedPriority,
            location: _selectedLocation,
            isReminderActive: _isReminderSet,
          ),
        );
        currentlyEditingTaskHandler.isEditingCurrently(
            false, 'Editing Complete');
      }
    } else {
      allTasksStateHandler.addTask(newTask);
      navBarStateHandler.onNavBarItemTap(1);
    }
  }

  /// Function used to initialize form fields with values of the
  /// currently editing task when the dependencies change.
  ///
  /// This allows the UI to display the task's current values for editing.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final currentlyEditingTaskWatcher = ref.watch(currentEditingTaskProvider);
      final taskListWatcher = ref.watch(allTasksProvider);

      if (currentlyEditingTaskWatcher.keys.first == true) {
        final editingTask = taskListWatcher.firstWhere((task) {
          return task.id == currentlyEditingTaskWatcher.values.first;
        });

        _titleTextController.text = editingTask.title;
        _descriptionTextController.text = editingTask.description ?? '';
        _selectedDate = editingTask.deadlineDate;
        _dateInputController.text = Utils.formatDate(_selectedDate!);
        _selectedTime = editingTask.deadlineTime;
        _timeInputController.text = Utils.formatTime(_selectedTime);
        _selectedPriority = editingTask.priority ?? Priority.none;
        _selectedCategory = editingTask.category ?? Category.none;
        _selectedLocation = editingTask.location ?? '';
        _locationController.text = _selectedLocation ?? '';
        _isReminderSet = editingTask.isReminderActive ?? false;
        _isInitialized = true;
      }
    }
  }

  /// Function used to properly release resources when the widget is disposed of.
  ///
  /// This prevents memory leaks by disposing of controllers and controllers
  /// when they are no longer needed.
  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    _dateInputController.dispose();
    _timeInputController.dispose();
    _locationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentlyEditingTaskWatcher = ref.watch(currentEditingTaskProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            currentlyEditingTaskWatcher.keys.first
                ? 'Editing Task'
                : 'Add Task',
          ),
          centerTitle: true,
          actions: [
            if (currentlyEditingTaskWatcher.keys.first) ...[
              TodooButton(
                onButtonTap: () {
                  _prepareButtonTap();
                  _onDeleteTap(currentlyEditingTaskWatcher.keys.first);
                },
                icon: Ic.delete,
              ),
            ],

            /// Toggles the reminder state if a time is set;
            /// otherwise, displays an error dialog informing the user that
            /// a reminder cannot be set without a selected time, with
            /// appropriate styling and icons.
            TodooButton(
              icon: _isReminderSet
                  ? Ic.notifications_active
                  : MaterialSymbols.notifications_active_outline_rounded,
              margin: kTodooButtonMargin.copyWith(left: 10, right: 10),
              onButtonTap: () {
                _prepareButtonTap();
                if (_selectedTime == null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return TodooAlertDialogue(
                          title: 'Reminder Error!',
                          contentItems: [
                            Text(
                              'Time is empty! Can\'t set reminder without setting time!',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        );
                      });
                } else {
                  _toggleReminder();
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: kScaffoldBodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// A custom text field widget for capturing TITLE input with
                /// various configurations.
                TodooTextField(
                  textFieldTitle: 'Title:',
                  focusNode: _titleFieldFocusNode,
                  textFieldCapitalization: TextCapitalization.words,
                  textFieldActionIcon: Bx.reset,
                  onActionIconTap: () {
                    _prepareButtonTap();
                    _titleTextController.text = '';
                  },
                  textFieldMaxLength: 50,
                  textFieldIcon: Iconify(
                    Bx.text,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textFieldController: _titleTextController,
                ),

                /// A custom text field widget for capturing TITLE input with
                /// various configurations.
                TodooTextField(
                  textFieldTitle: 'Description:',
                  focusNode: _descriptionFieldFocusNode,
                  textFieldCapitalization: TextCapitalization.sentences,
                  textFieldActionIcon: Bx.reset,
                  onActionIconTap: () {
                    _prepareButtonTap();
                    _descriptionTextController.text = '';
                  },
                  textFieldMaxLength: 150,
                  textFieldMaxLines: 3,
                  textFieldKeyboardType: TextInputType.multiline,
                  textFieldKeyboardInputAction: TextInputAction.newline,
                  textFieldIcon: Iconify(
                    Ic.outline_description,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textFieldController: _descriptionTextController,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    /// A custom read-only text field for selecting a date.
                    Expanded(
                      child: TodooTextField(
                        isReadOnly: true,
                        isInputPicker: true,
                        onTextFieldTap: _pickDate,
                        textFieldController: _dateInputController,
                        textFieldTitle: 'Pick Date:',
                        textFieldActionIcon: Bx.reset,
                        onActionIconTap: () {
                          if (_selectedDate != null) {
                            setState(() {
                              _selectedDate = null;
                              _dateInputController.text = 'Date Cleared';
                            });
                          }
                        },
                        textFieldIcon: Iconify(
                          Pixelarticons.calendar_plus,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    /// A custom read-only text field for selecting a time.
                    Expanded(
                      child: TodooTextField(
                        isReadOnly: true,
                        isInputPicker: true,
                        onTextFieldTap: _pickTime,
                        textFieldController: _timeInputController,
                        textFieldTitle: 'Pick Time:',
                        textFieldActionIcon: Bx.reset,
                        onActionIconTap: () {
                          if (_selectedTime != null) {
                            setState(() {
                              _selectedTime = null;
                              _timeInputController.text = 'Time Cleared';
                            });
                          }
                        },
                        textFieldIcon: Iconify(
                          Mdi.clock_plus_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Choose Options:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    children: [
                      /// Opens a dialog to select a task priority,
                      /// updating the priority state and resetting the initial tap flag.
                      TodooButton(
                        icon: _selectedPriority == Priority.none &&
                                isPriorityFirstTap
                            ? MaterialSymbols.arrow_circle_up
                            : priorityIconMap[_selectedPriority]!.keys.first,
                        buttonText: _selectedPriority == Priority.none
                            ? 'Set Priority'
                            : Utils.getPriorityLabel(_selectedPriority),
                        padding:
                            kTodooButtonPadding.copyWith(left: 10, right: 10),
                        onButtonTap: () {
                          _prepareButtonTap();
                          setState(() {
                            isPriorityFirstTap = false;
                          });
                          showDialog(
                            context: context,
                            builder: (context) => TodooAlertDialogue(
                              title: 'Select Task Priority:',
                              contentItems: priorityIconMap.entries
                                  .where((entry) => entry.key != Priority.none)
                                  .map((entry) {
                                return Center(
                                  child: SizedBox(
                                    width: 200,
                                    child: TodooButton(
                                      onButtonTap: () {
                                        _pickPriority(entry.key);

                                        Navigator.of(context).pop();
                                      },
                                      icon: priorityIconMap[entry.key]!
                                          .keys
                                          .first,
                                      iconColour: priorityIconMap[entry.key]!
                                          .values
                                          .first,
                                      buttonColour: priorityIconMap[entry.key]!
                                          .values
                                          .first
                                          .withOpacity(0.2),
                                      buttonText:
                                          Utils.getPriorityLabel(entry.key),
                                      textColour: priorityIconMap[entry.key]!
                                          .values
                                          .first,
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(6),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),

                      /// Opens a dialog to select a task category,
                      /// updating the category state and resetting the initial tap flag.
                      TodooButton(
                        icon: _selectedCategory == Category.none &&
                                isCategoryFirstTap
                            ? Ic.round_category
                            : categoryIconMap[_selectedCategory]!.keys.first,
                        buttonText: _selectedCategory == Category.none
                            ? 'Set Category'
                            : Utils.getCategoryLabel(_selectedCategory),
                        padding:
                            kTodooButtonPadding.copyWith(left: 10, right: 10),
                        onButtonTap: () {
                          _prepareButtonTap();
                          setState(() {
                            isCategoryFirstTap = false;
                          });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return TodooAlertDialogue(
                                  title: 'Choose Category:',
                                  contentItems: categoryIconMap.entries
                                      .where(
                                          (entry) => entry.key != Category.none)
                                      .map((entry) {
                                    return Center(
                                      child: SizedBox(
                                        width: 200,
                                        child: TodooButton(
                                          onButtonTap: () {
                                            _pickCategory(entry.key);
                                            Navigator.of(context).pop();
                                          },
                                          icon: categoryIconMap[entry.key]!
                                              .keys
                                              .first,
                                          iconColour:
                                              categoryIconMap[entry.key]!
                                                  .values
                                                  .first,
                                          buttonColour:
                                              categoryIconMap[entry.key]!
                                                  .values
                                                  .first
                                                  .withOpacity(0.2),
                                          buttonText:
                                              Utils.getCategoryLabel(entry.key),
                                          textColour:
                                              categoryIconMap[entry.key]!
                                                  .values
                                                  .first,
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.all(4),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              });
                        },
                      ),

                      /// Opens a dialog for entering or resetting the task location,
                      /// updating the location state and handling the initial tap flag.
                      TodooButton(
                        icon: isLocationFirstTap
                            ? Ic.round_location_on
                            : _locationController.text.isEmpty
                                ? Uil.location_pin_alt
                                : Ic.round_location_on,
                        buttonText: _locationController.text == ''
                            ? 'Set Location'
                            : 'Location Set',
                        padding:
                            kTodooButtonPadding.copyWith(left: 10, right: 10),
                        onButtonTap: () {
                          _prepareButtonTap();
                          setState(() {
                            isLocationFirstTap = false;
                          });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return TodooAlertDialogue(
                                  title: 'Choose Location:',
                                  contentItems: [
                                    TodooTextField(
                                      textFieldController: _locationController,
                                      textFieldCapitalization:
                                          TextCapitalization.characters,
                                      textFieldIcon: Iconify(
                                        Ic.round_location_on,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        'Coming Soon: You can pick location coordinates from map!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(fontSize: 10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TodooButton(
                                          onButtonTap: () {
                                            setState(() {
                                              _selectedLocation = '';
                                              _locationController.text = '';
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          icon: Ic.round_location_off,
                                          buttonText: 'Clear',
                                          buttonColour: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.06),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        TodooButton(
                                          onButtonTap: () {
                                            _pickLocation();
                                            Navigator.of(context).pop();
                                          },
                                          icon: Ic.round_add_location,
                                          buttonWidth: 80,
                                          buttonText: 'Confirm',
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// Handles the cancel action with a "Cancel" button, providing an icon, label,
                    /// and consistent styling with custom padding and height.
                    TodooButton(
                      onButtonTap: () {
                        _prepareButtonTap();
                        _onCancelTap();
                      },
                      icon: Ic.cancel,
                      buttonText: 'Cancel',
                      buttonColour: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.06),
                      padding:
                          kTodooButtonPadding.copyWith(left: 10, right: 10),
                      margin: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      width: 6,
                    ),

                    /// Saves the task with provided details if all required inputs are valid;
                    /// otherwise, displays an alert dialog to prompt input corrections,
                    /// with consistent button styling and a "Save" icon.
                    TodooButton(
                      onButtonTap: () {
                        _prepareButtonTap();
                        if (_titleTextController.text.isNotEmpty &&
                            _selectedDate != null &&
                            (_selectedTime == null ||
                                _selectedDate!.isAfter(_todayDate) ||
                                _selectedTime!.isAfter(_todayDate))) {
                          _prepareInputsForSave();
                          _onSaveTap(
                            TodooTask(
                              title: _titleTextController.text,
                              description: _descriptionTextController.text,
                              deadlineDate: _selectedDate!,
                              deadlineTime: _selectedTime,
                              category: _selectedCategory,
                              priority: _selectedPriority,
                              location: _selectedLocation,
                              isReminderActive: _isReminderSet,
                            ),
                            currentlyEditingTaskWatcher.keys.first,
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return TodooAlertDialogue(
                                  title: 'Check Your Inputs',
                                  contentItems: [
                                    _buildValidatorErrorMessages(),
                                  ],
                                );
                              });
                        }
                      },
                      icon: Ic.save,
                      buttonText: currentlyEditingTaskWatcher.keys.first
                          ? 'Save Edits'
                          : 'Save',
                      padding:
                          kTodooButtonPadding.copyWith(left: 10, right: 10),
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
