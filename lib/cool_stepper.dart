library cool_stepper;

export 'package:cool_stepper/src/models/cool_step.dart';
export 'package:cool_stepper/src/models/cool_stepper_config.dart';
import 'package:cool_stepper/src/models/cool_step.dart';
import 'package:cool_stepper/src/models/cool_stepper_config.dart';
import 'package:cool_stepper/src/widgets/cool_stepper_view.dart';
import 'package:monopoly_saver/app/theme/monopoly_colors.dart';
import 'package:flutter/material.dart';

/// CoolStepper
class CoolStepper extends StatefulWidget {
  final List<CoolStep> steps;
  final VoidCallback onCompleted;

  /// Executed when pressing back while on the first step
  final VoidCallback onBackFirstStep;

  /// Executed when changing between steps
  final Function(int, bool) onStepChange;
  final EdgeInsetsGeometry contentPadding;
  final CoolStepperConfig config;

  const CoolStepper({
    Key key,
    @required this.steps,
    @required this.onCompleted,
    this.onBackFirstStep,
    this.onStepChange,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20.0),
    this.config = const CoolStepperConfig(
        backText: "PREV",
        nextText: "NEXT",
        stepText: "STEP",
        ofText: "OF",
        cancelText: 'CANCEL',
        finalText: "FINISH",
        progLabels: null),
  }) : super(key: key);

  @override
  _CoolStepperState createState() => _CoolStepperState();
}

class _CoolStepperState extends State<CoolStepper> {
  PageController _controller;

  int currentStep = 0;

  @override
  void initState() {
    super.initState();

    if (widget.config.initialStep != null) {
      if (widget.config.initialStep > widget.steps.length) {
        throw 'initialStep cannot be greater than the number of steps (${widget.config.initialStep > widget.steps.length})';
      } else {
        _controller = PageController(initialPage: widget.config.initialStep);
      }
    } else {
      _controller = PageController();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  switchToPage(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  onStepNext() {
    String validation = widget.steps[currentStep].validation();
    if (validation == null) {
      if (!_isLast(currentStep)) {
        setState(() {
          currentStep++;
        });
        FocusScope.of(context).unfocus();
        switchToPage(currentStep);
        if (widget.onStepChange != null) {
          widget.onStepChange(currentStep, true);
        }
      } else {
        widget.onCompleted();
      }
    } else {
      // Do Nothing
    }
  }

  onStepBack() {
    if (!_isFirst(currentStep)) {
      setState(() {
        currentStep--;
      });
      if (widget.onStepChange != null) {
        widget.onStepChange(currentStep, false);
      }
      switchToPage(currentStep);
    } else {
      if (widget.onBackFirstStep != null) {
        widget.onBackFirstStep();
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Expanded(
      child: Container(
        child: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: widget.steps.map((step) {
            return CoolStepperView(
              step: step,
              contentPadding: widget.contentPadding,
              config: widget.config,
            );
          }).toList(),
        ),
      ),
    );

    final counter = Container(
      child: Text(
        "${widget.config.stepText ?? 'step'} ${currentStep + 1} ${widget.config.ofText ?? 'of'} ${widget.steps.length}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: MonopolyColors.tileTextColor,
        ),
      ),
    );

    String getNextLabel() {
      String nextLabel;
      if (widget.config.progLabels != null) {
        if (_isLast(currentStep)) {
          nextLabel = widget.config.finalText ?? 'FINISH';
        } else {
          nextLabel = widget.config.progLabels[currentStep + 1];
        }
      } else {
        nextLabel = widget.config.nextText ?? 'NEXT';
      }
      return nextLabel;
    }

    String getPrevLabel() {
      String backLabel;
      if (widget.config.progLabels != null) {
        if (_isFirst(currentStep)) {
          backLabel = widget.config.cancelText ?? 'CANCEL';
        } else {
          backLabel = widget.config.progLabels[currentStep - 1];
        }
      } else {
        backLabel = widget.config.backText ?? 'PREV';
      }
      return backLabel;
    }

    final buttons = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: onStepBack,
            child: Text(
              getPrevLabel(),
              style: TextStyle(
                color: MonopolyColors.tileTextColor,
              ),
            ),
          ),
          counter,
          FlatButton(
            onPressed: onStepNext,
            child: Text(
              getNextLabel(),
              style: TextStyle(
                color: MonopolyColors.tileTextColor,
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      color: MonopolyColors.trueBlue,
      child: Column(
        children: [content, buttons],
      ),
    );
  }
}
