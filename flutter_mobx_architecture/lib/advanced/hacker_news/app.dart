import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:mobx/mobx.dart';

import 'news_store.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin<Home> {
  final HackerNewsStore store = HackerNewsStore();
  final _tabs = [FeedType.latest, FeedType.top];
  TabController _tabController;

  void _onTabChanged() {
    store.loadNews(_tabs[_tabController.index]);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)..addListener(_onTabChanged);
    store.loadNews(_tabs.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hacker News'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Newest'), Tab(text: 'Top')],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            FeedItemsView(type: FeedType.latest, store: store),
            FeedItemsView(type: FeedType.top, store: store),
          ],
        ),
      ),
    );
  }
}

class FeedItemsView extends StatelessWidget {
  final HackerNewsStore store;
  final FeedType type;

  const FeedItemsView({Key key, this.store, this.type}) : super(key: key);

  Future _refresh() => (type == FeedType.latest) ? store.fetchLatest() : store.fetchTop();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final future = type == FeedType.latest ? store.latestItemsFuture : store.topItemsFuture;
        switch (future.status) {
          case FutureStatus.pending:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Text('Loading items...'),
              ],
            );
          case FutureStatus.rejected:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Failed to load items.',
                  style: TextStyle(color: Colors.red),
                ),
                RaisedButton(
                  child: const Text('Tap to try again'),
                  onPressed: _refresh,
                ),
              ],
            );
          case FutureStatus.fulfilled:
            final List<FeedItem> items = future.result;
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Text(
                        '${item.points}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('- ${item.user}, ${item.commentsCount} comment(s)'),
                      onTap: () => store.openUrl(item.url),
                    );
                  }),
            );
          default:
            return Text('null');
        }
      },
    );
  }
}
