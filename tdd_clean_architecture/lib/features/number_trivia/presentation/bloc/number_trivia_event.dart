import 'package:super_enum/super_enum.dart';

part 'number_trivia_event.g.dart';

@superEnum
enum _NumberTriviaEvent {
  @object
  GetRandomNumber,
  @Data(fields: [
    DataField('numberString', String),
  ])
  GetConcreteNumber,
}
