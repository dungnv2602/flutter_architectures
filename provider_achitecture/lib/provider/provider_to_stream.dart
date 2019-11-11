import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderToStream<T> extends StatefulWidget implements SingleChildCloneableWidget {
  final ValueWidgetBuilder<Stream<T>> builder;
  final Widget child;

  const ProviderToStream({Key key, this.builder, this.child}) : super(key: key);

  @override
  _ProviderToStreamState<T> createState() => _ProviderToStreamState<T>();

  @override
  SingleChildCloneableWidget cloneWithChild(Widget child) {
    return ProviderToStream(
      key: key,
      builder: builder,
      child: child,
    );
  }
}

class _ProviderToStreamState<T> extends State<ProviderToStream<T>> {
  final StreamController<T> controller = StreamController<T>();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.add(Provider.of<T>(context));
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller.stream, widget.child);
  }
}
