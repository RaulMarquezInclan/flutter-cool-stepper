import 'package:cool_stepper/cool_stepper.dart';
import 'package:cool_stepper/src/models/cool_step.dart';
import 'package:flutter/material.dart';

class CoolStepperView extends StatelessWidget {
  final CoolStep step;
  final VoidCallback onStepNext;
  final VoidCallback onStepBack;
  final EdgeInsetsGeometry contentPadding;
  final CoolStepperConfig config;

  const CoolStepperView({
    Key key,
    @required this.step,
    this.onStepNext,
    this.onStepBack,
    this.contentPadding,
    this.config,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final title = Container(
      width: MediaQuery.of(context).size.width,
      height: 27.0.w,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: config.headerColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                // color: Colors.cyan,
                width: 88.0.w,
                child: Text(
                  step.title.toUpperCase(),
                  style: config.titleTextStyle ??
                      TextStyle(
                        fontSize: 4.3.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.0.w),
          Text(
            step.subtitle,
            style: config.subtitleTextStyle ??
                TextStyle(
                  fontSize: 3.5.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          )
        ],
      ),
    );

    final content = Container(
      padding: contentPadding,
      child: step.content,
    );

    return Container(
      color: config.backgroundColor ?? Colors.transparent,
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title, content],
      ),
    );
  }
}
