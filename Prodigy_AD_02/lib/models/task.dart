class Task {
  String title;
  bool isCompleted;
  bool isImportant;
  DateTime? dueDate;

  Task({
    required this.title,
    this.isCompleted = false,
    this.isImportant = false,
    this.dueDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'isImportant': isImportant,
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
      isImportant: json['isImportant'] ?? false,
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : null,
    );
  }
}