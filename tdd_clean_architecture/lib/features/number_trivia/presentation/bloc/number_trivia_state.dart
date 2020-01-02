import 'package:super_enum/super_enum.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/domain.dart';

part 'number_trivia_state.g.dart';

@superEnum
enum _NumberTriviaState {
  @object
  Empty,
  @object
  Loading,
  @Data(fields: [
    DataField('trivia', NumberTrivia),
  ])
  Loaded,
  @Data(fields: [
    DataField('msg', String),
  ])
  Error,
}
