import 'package:flutter/material.dart';
import 'package:todoo_app/constants.dart';
import 'package:todoo_app/widgets/tasks_button.dart';

class TodooTextField extends StatelessWidget {
  const TodooTextField({
    super.key,
    required this.textFieldController,
    required this.textFieldIcon,
    this.textFieldTitle,
    this.isReadOnly,
    this.textFieldMinLines,
    this.textFieldMaxLines,
    this.textFieldMaxLength,
    this.textFieldCapitalization,
    this.textFieldKeyboardType,
    this.textFieldKeyboardInputAction,
    this.onTextFieldTap,
    this.isInputPicker,
    this.focusNode,
    this.textFieldActionIcon,
    this.onActionIconTap,
  });

  final bool? isReadOnly;
  final TextEditingController textFieldController;
  final String? textFieldTitle;
  final Widget textFieldIcon;
  final int? textFieldMinLines;
  final int? textFieldMaxLines;
  final int? textFieldMaxLength;
  final TextCapitalization? textFieldCapitalization;
  final TextInputType? textFieldKeyboardType;
  final TextInputAction? textFieldKeyboardInputAction;
  final Function()? onTextFieldTap;
  final bool? isInputPicker;
  final FocusNode? focusNode;
  final String? textFieldActionIcon;
  final Function()? onActionIconTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textFieldTitle != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  textFieldTitle!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const Spacer(),
              if (textFieldActionIcon != null) ...[
                TodooButton(
                  icon: textFieldActionIcon,
                  padding: const EdgeInsets.all(0),
                  buttonColour: Colors.transparent,
                  margin: kTodooButtonMargin.copyWith(
                    right: 6,
                  ),
                  onButtonTap: onActionIconTap ?? () {},
                ),
              ],
            ],
          ),
          const SizedBox(
            height: 4,
          ),
        ],
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          child: RawScrollbar(
            thickness: 2,
            mainAxisMargin: 2,
            padding: const EdgeInsets.only(right: 4),
            radius: Radius.circular(kTodooAppRoundness),
            thumbColor: Theme.of(context).colorScheme.primary,
            fadeDuration: const Duration(milliseconds: 300),
            timeToFade: const Duration(milliseconds: 600),
            child: TextField(
              onTap: onTextFieldTap,
              readOnly: isReadOnly ?? false,
              focusNode: focusNode,
              cursorHeight: 20,
              style: (isInputPicker ?? false)
                  ? Theme.of(context).textTheme.bodySmall
                  : Theme.of(context).textTheme.bodyMedium,
              textCapitalization:
                  textFieldCapitalization ?? TextCapitalization.sentences,
              keyboardType: textFieldKeyboardType ?? TextInputType.text,
              textInputAction:
                  textFieldKeyboardInputAction ?? TextInputAction.done,
              controller: textFieldController,
              maxLines: textFieldMaxLines ?? 1,
              minLines: textFieldMinLines ?? 1,
              maxLength: textFieldMaxLength,
              decoration: const InputDecoration().copyWith(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: textFieldIcon,
                ),
                prefixIconConstraints: const BoxConstraints(maxHeight: 22),
                counterStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
