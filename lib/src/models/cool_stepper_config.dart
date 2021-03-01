import 'package:flutter/widgets.dart';

class CoolStepperConfig {
  /// The text that should be displayed for the back button
  ///
  /// default is 'BACK'
  final int initialStep;

  /// The text that should be displayed for the back button
  ///
  /// default is 'BACK'
  final String backText;

  /// The text that should be displayed for the next button
  ///
  /// default is 'NEXT'
  final String nextText;

  /// The text that describes the progress
  ///
  /// default is 'STEP'
  final String stepText;

  /// The text that describes the progress
  ///
  /// default is 'OF'
  final String ofText;

  /// This is the background color of the header
  final Color headerColor;

  /// This is the background color of the header
  final Color backgroundColor;

  /// This is the background color of the header
  final Color contentColor;

  /// This is the color of the icon
  ///
  /// [This does not apply when icon is set]
  final Color iconColor;

  /// This icon replaces the default icon
  final Icon icon;

  /// This is the textStyle for the title text
  final TextStyle titleTextStyle;

  /// This is the textStyle for the subtitle text
  final TextStyle subtitleTextStyle;

  /// Progress labels that when supplied will override 'backText' and 'nextText', must equal the number of steps
  final List<String> progLabels;

  /// The text that should be displayed for the prev button on the first step, if provided will override 'backText'. It's meant to be combined with CoolStepper's 'onBackFirstStep' callback
  ///
  /// default is 'CANCEL'
  final String cancelText;

  /// The text that should be displayed for the next button on the final step
  ///
  /// default is 'FINISH'
  final String finalText;

  /// Hides the top right icon
  ///
  /// default is 'FINISH'
  final bool noIcon;

  const CoolStepperConfig({
    this.initialStep,
    this.backText,
    this.nextText,
    this.stepText,
    this.ofText,
    this.headerColor,
    this.backgroundColor,
    this.contentColor,
    this.iconColor,
    this.icon,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.progLabels,
    this.cancelText,
    this.finalText,
    this.noIcon,
  });
}
