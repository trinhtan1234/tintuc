class Comment {
  String content;
  DateTime timestamp;

  Comment({required this.content, required this.timestamp});

  factory Comment.create({required String content}) {
    return Comment(
      content: content,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
