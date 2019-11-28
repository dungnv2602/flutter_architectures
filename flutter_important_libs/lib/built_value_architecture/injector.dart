import 'repos.dart';

enum RepoType { MOCK, PROD }

class Injector {
  static final Injector _instance = Injector._();
  factory Injector() => _instance;
  Injector._();

  static RepoType _repoType;

  static void config(RepoType repoType) => _repoType = repoType;

  RedditRepos get redditRepo {
    switch (_repoType) {
      case RepoType.MOCK:
        return MockRedditRepos();
      case RepoType.PROD:
        return ProdRedditRepos();
      default:
        return null;
    }
  }
}
