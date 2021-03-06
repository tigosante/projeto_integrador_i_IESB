import 'package:personal_flow/domain/task/task.entity.dart';

class TaskFindArgs {
  TaskFindArgs({
    required this.id,
  });

  final int id;
}

class TaskFindAllArgs {
  TaskFindAllArgs({
    required this.idUser,
  });

  final int idUser;
}

class TaskSaveArgs {
  TaskSaveArgs({
    required this.id,
    required this.idUser,
    required this.title,
    required this.description,
  });

  final int id;
  final int idUser;
  final String title;
  final String description;
}

class TaskSaveListArgs {
  TaskSaveListArgs({
    required this.tasks,
  });

  final List<TaskEntity> tasks;
}

class TaskUpdateArgs {
  TaskUpdateArgs({
    required this.id,
    required this.title,
    required this.description,
  });

  final int id;
  final String title;
  final String description;
}

class TaskDeleteArgs {
  TaskDeleteArgs({
    required this.id,
    required this.idUser,
  });

  final int id;
  final int idUser;
}
