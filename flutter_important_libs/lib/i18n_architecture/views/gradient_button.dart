import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Gradient gradient;
  final Color color;
  final Color shadowColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry margin;
  final bool loading;
  final Widget loadingWidget;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.width,
    this.height = 40,
    this.margin = const EdgeInsets.all(8),
    this.gradient,
    this.color,
    this.shadowColor = Colors.black38,
    this.onPressed,
    this.loading = false,
    this.loadingWidget = const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 2,
      ),
    ),
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: loading ? null : onPressed,
          child: Center(
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: loading ? loadingWidget : child),
          ),
        ),
      ),
    );
  }
}
