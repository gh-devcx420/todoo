import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:todoo_app/constants.dart';

class TodooButton extends StatelessWidget {
  const TodooButton({
    super.key,
    required this.onButtonTap,
    this.icon,
    this.iconSize,
    this.iconColour,
    this.buttonText,
    this.textColour,
    this.buttonColour,
    this.padding,
    this.margin,
    this.buttonHeight,
    this.buttonWidth,
  });

  final String? icon;
  final double? iconSize;
  final Function() onButtonTap;
  final Color? buttonColour;
  final Color? iconColour;
  final String? buttonText;
  final Color? textColour;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? buttonHeight;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonTap,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        margin: margin ?? kTodooButtonMargin,
        padding: padding ?? kTodooButtonPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          color: buttonColour ??
              Theme.of(context).colorScheme.primary.withOpacity(0.15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Iconify(
                icon!,
                color: iconColour ?? Theme.of(context).colorScheme.primary,
                size: iconSize ?? 18.0,
              ),
            ],
            if (buttonText != null) ...[
              const SizedBox(width: 2),
              Text(
                buttonText!,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color:
                          textColour ?? Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
