import 'package:mobx/mobx.dart';

import 'package:github/server.dart';

part 'github_store.g.dart';

class GithubStore = _GithubStore with _$GithubStore;


abstract class _GithubStore with Store {
  final GitHub client = createGitHubClient();

  // No need to observe this as we are relying on the fetchReposFuture.status
  List<Repository> repositories = [];

  @observable
  String user = '';

  @action
  void setUser(String text) {
    fetchReposFuture = emptyResponse;
    user = text;
  }

  static ObservableFuture<List<Repository>> emptyResponse = ObservableFuture.value([]);

  /// The fetchReposFuture is marked as an @observable, because it will change its value when the network call is invoked. We start with an emptyResponse to avoid making null checks
  @observable
  ObservableFuture<List<Repository>> fetchReposFuture = emptyResponse;

  /// The @computed field hasResults is an easy way to know if there are results available. It is normally a good practice to create such computed-fields to simplify the logic.
  @computed
  bool get hasResults => fetchReposFuture != emptyResponse && fetchReposFuture.status == FutureStatus.fulfilled;

  @action
  Future<List<Repository>> fetchRepos() async {
    repositories = [];

    final future = client.repositories.listUserRepositories(user).toList(); // no await
    fetchReposFuture = ObservableFuture(future);

    return repositories = await future;
  }
}
