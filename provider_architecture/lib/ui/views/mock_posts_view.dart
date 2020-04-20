import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider_architecture/provider/mock_posts_notifier.dart';
import 'package:provider_architecture/ui/views/base_view.dart';
import 'package:provider_architecture/ui/widgets/creation_aware_list_item.dart';
import 'package:provider_architecture/ui/widgets/list_item.dart';

class MockPostsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<MockPostsNotifier>(
        notifier: MockPostsNotifier(),
        consumerBuilder: (_, notifier, __) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
              notifier.reload();
            },
            child: ListView.builder(
              itemBuilder: (_, index) {
                return CreationAwareListItem(
                  itemCreated: () {
                    SchedulerBinding.instance.addPostFrameCallback(
                        (_) => notifier.handleItemCreated(index));
                  },
                  child: ListItem(
                    title: notifier.items[index],
                  ),
                );
              },
              itemCount: notifier.items.length,
            ),
          );
        },
      ),
    );
  }
}
