import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final T notifier;
  final Widget Function(BuildContext context, T value, Widget child)
      consumerBuilder;
  final Widget consumerChild;
  final Function(T) onNotifierReady;

  const BaseView(
      {Key key,
      this.notifier,
      this.consumerBuilder,
      this.consumerChild,
      this.onNotifierReady})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  // We want to store the instance of the model in the state
  // that way it stays constant through rebuilds
  T notifier;

  @override
  void initState() {
    // assign the model once when state is initialised
    notifier = widget.notifier;
    //trigger function if not null
    if (widget.onNotifierReady != null) {
      widget.onNotifierReady(notifier);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// use default constructor ChangeNotifierProvider so that it can do dispose for us
    return ChangeNotifierProvider<T>(
      create: (context) => notifier,
      child: Consumer<T>(
        builder: widget.consumerBuilder,
        child: widget.consumerChild,
      ),
    );
  }
}
