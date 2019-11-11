import 'package:flutter/widgets.dart';

class OrientationLayout extends StatelessWidget {
  final Widget Function(BuildContext) landscape;
  final Widget Function(BuildContext) portrait;

  const OrientationLayout({
    Key key,
    @required this.portrait,
    this.landscape,
  })  : assert(portrait != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape && landscape != null) {
              return landscape(context);
            }

            return portrait(context);
          },
        );
      },
    );
  }
}
