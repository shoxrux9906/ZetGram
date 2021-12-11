class ChatItemModel {
  final int id;
  final String message;
  final String time;
  final bool isMe;

  ChatItemModel({
    required this.id,
    required this.message,
    required this.time,
    required this.isMe,
  });
}
