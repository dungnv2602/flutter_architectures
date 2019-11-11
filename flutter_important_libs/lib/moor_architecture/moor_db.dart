//import 'package:moor_flutter/moor_flutter.dart';
//
//part 'moor_db.g.dart';
//
//// The name of the database table is "tasks"
//// By default, the name of the generated data class will be "Task" (without "s")
//class Tasks extends Table {
//  // autoIncrement automatically sets this to be the primary key
//  IntColumn get id => integer().autoIncrement()();
//
//  // If the length constraint is not fulfilled, the Task will not
//  // be inserted into the database and an exception will be thrown.
//  TextColumn get name => text().withLength(min: 1, max: 50)();
//
//  // DateTime is not natively supported by SQLite
//  // Moor converts it to & from UNIX seconds
//  DateTimeColumn get dueDate => dateTime().nullable()();
//
//  // Booleans are not supported as well, Moor converts them to integers
//  // Simple default values are specified as Constants
//  BoolColumn get completed => boolean().withDefault(Constant(false))();
//
//  // Foreign key
//  TextColumn get tagName => text().nullable().customConstraint('NULL REFERENCES tags(name)')();
//}
//
//class Tags extends Table {
//  TextColumn get name => text().withLength(min: 1, max: 10)();
//
//  IntColumn get color => integer()();
//
//  // set primary key
//  @override
//  Set<Column> get primaryKey => {name};
//}
//
//@UseMoor(tables: [Tasks, Tags], daos: [TaskDao, TagDao])
//class AppDatabase extends _$AppDatabase {
//  AppDatabase()
//      :
//        // Specify the location of the database file
//        super(FlutterQueryExecutor.inDatabaseFolder(
//            path: 'db.sqlite',
//            // Good for debugging - prints SQL in the console
//            logStatements: true));
//
//  // Bump this when changing tables and columns.
//  @override
//  int get schemaVersion => 2;
//
//  @override
//  MigrationStrategy get migration => MigrationStrategy(
//    onUpgrade: (migrator, from, to) async {
//      if (from == 1) {
//        await migrator.addColumn(tasks, tasks.tagName);
//        await migrator.createTable(tags);
//      }
//    },
//    beforeOpen: (details) async {
//      await customStatement('PRAGMA foreign_keys = ON');
//    },
//  );
//}
//
//class TaskWithTag {
//  final Task task;
//  final Tag tag;
//
//  TaskWithTag({@required this.task, @required this.tag});
//}
//
//// Denote which tables this DAO can access
//@UseDao(tables: [Tasks, Tags])
//class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
//  final AppDatabase db;
//
//  TaskDao(this.db) : super(db);
//
//  Stream<List<TaskWithTag>> watchAllTasks() {
//    // Wrap the whole select statement in parenthesis
//    return (select(tasks)
//    // Statements like orderBy and where return void => the need to use a cascading ".." operator
//      ..orderBy(
//        ([
//          // Primary sorting by due date
//              (t) =>
//              OrderingTerm(expression: t.dueDate, mode: OrderingMode.asc),
//          // Secondary alphabetical sorting
//              (t) => OrderingTerm(expression: t.name),
//        ]),
//      ))
//    // As opposed to orderBy or where, join returns a value. This is what we want to watch/get.
//        .join(
//      [
//        // Join all the tasks with their tags.
//        // It's important that we use equalsExp and not just equals.
//        // This way, we can join using all tag names in the tasks table, not just a specific one.
//        leftOuterJoin(tags, tags.name.equalsExp(tasks.tagName)),
//      ],
//    )
//    // watch the whole select statement including the join
//        .watch()
//    // Watching a join gets us a Stream of List<TypedResult>
//    // Mapping each List<TypedResult> emitted by the Stream to a List<TaskWithTag>
//        .map(
//          (rows) => rows.map(
//            (row) {
//          return TaskWithTag(
//            task: row.readTable(tasks),
//            tag: row.readTable(tags),
//          );
//        },
//      ).toList(),
//    );
//  }
//
//  Future<int> insertTask(Insertable<Task> task) => into(tasks).insert(task);
//
//  Future<int> deleteTask(Insertable<Task> task) => delete(tasks).delete(task);
//
//  Future<bool> updateTask(Insertable<Task> task) => update(tasks).replace(task);
//}
//
//// Denote which tables this DAO can access
//@UseDao(tables: [Tags])
//class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
//  final AppDatabase db;
//
//  TagDao(this.db) : super(db);
//
//  Stream<List<Tag>> watchTags() => select(tags).watch();
//
//  Future<int> insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
//}
