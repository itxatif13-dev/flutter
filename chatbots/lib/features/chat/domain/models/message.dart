enum MessageRole { user, assistant, system }

class Message {
  final String id;
  final String content;
  final MessageRole role;
  final DateTime timestamp;
  final bool isOptimistic;
  final String? imageUrl;

  Message({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.isOptimistic = false,
    this.imageUrl,
  });

  Message copyWith({
    String? id,
    String? content,
    MessageRole? role,
    DateTime? timestamp,
    bool? isOptimistic,
    String? imageUrl,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
      isOptimistic: isOptimistic ?? this.isOptimistic,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
