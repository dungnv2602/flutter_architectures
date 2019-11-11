import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'github_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(builder: (_) => GithubStore()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<GithubStore>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          UserInput(store: store),
          LoadingIndicator(store: store),
          ShowError(store: store),
          RepoListView(store: store),
        ],
      ),
    );
  }
}

class RepoListView extends StatelessWidget {
  final GithubStore store;

  const RepoListView({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(
        builder: (_) {
          if (!store.hasResults) return Container();
          if (store.repositories.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('No repo(s) found for user: '),
                Text(
                  store.user,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            );
          }
          return ListView.builder(
            itemCount: store.repositories.length,
            itemBuilder: (_, index) {
              final repo = store.repositories[index];
              return ListTile(
                title: Row(
                  children: <Widget>[
                    Text(
                      repo.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('(${repo.stargazersCount})'),
                    const Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
                subtitle: Text(repo.description ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}

class UserInput extends StatelessWidget {
  final GithubStore store;

  const UserInput({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextField(
              autocorrect: false,
              autofocus: false,
              onSubmitted: (String value) {
                store.setUser(value);
                store.fetchRepos();
              },
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: store.fetchRepos,
        )
      ],
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final GithubStore store;

  const LoadingIndicator({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) =>
          store.fetchReposFuture.status == FutureStatus.pending ? const LinearProgressIndicator() : Container(),
    );
  }
}

class ShowError extends StatelessWidget {
  final GithubStore store;

  const ShowError({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => store.fetchReposFuture.status == FutureStatus.rejected
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.warning,
                  color: Colors.deepOrange,
                ),
                Container(width: 8),
                const Text(
                  'Failed to fetch repos for',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                Text(
                  store.user,
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
