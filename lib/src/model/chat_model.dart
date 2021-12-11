class ChatModel {
  final int id;
  final String name;
  final String image;
  final String lastMessage;
  final int unRead;

  ChatModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.image,
    required this.unRead,
  });
}
