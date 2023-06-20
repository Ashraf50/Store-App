class Message{
  final String message;
  final String id;
  Message({
    required this.message,
    required this.id
    
  });
  factory Message.fromjson(jsonData){
    return Message(message: jsonData["message"],id: jsonData["id"]);
  }
}