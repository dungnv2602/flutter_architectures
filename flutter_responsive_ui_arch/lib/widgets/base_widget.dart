import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final Function(T) onModelReady;
  final T viewModel;

  const BaseWidget({
    Key key,
    this.onModelReady,
    @required this.viewModel,
    @required this.child,
  })  : assert(viewModel != null),
        assert(child != null),
        super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    if (widget.onModelReady != null) {
      widget.onModelReady(_viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => _viewModel,
      child: widget.child,
    );
  }
}
