import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common_github_search/common_github_search.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  final GithubRepository repo;

  GithubSearchBloc(this.repo);
  @override
  GithubSearchState get initialState => SearchStateEmpty();

  @override
  void onTransition(
      Transition<GithubSearchEvent, GithubSearchState> transition) {
    print(transition);
  }

  @override
  Stream<GithubSearchState> transformEvents(Stream<GithubSearchEvent> events,
      Stream<GithubSearchState> Function(GithubSearchEvent event) next) {
    return super.transformEvents(
        (events as Observable<GithubSearchEvent>)
            .debounceTime(const Duration(milliseconds: 300)),
        next);
  }

  @override
  Stream<GithubSearchState> mapEventToState(
    GithubSearchEvent event,
  ) async* {
    if (event is TextChanged) {
      final String term = event.text;
      if (term.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final rs = await repo.search(term);
          yield SearchStateSuccess(rs.items);
        } catch (error) {
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError('sth went wrong');
        }
      }
    }
  }
}
