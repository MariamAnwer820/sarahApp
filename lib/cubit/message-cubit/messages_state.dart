
import 'package:saraih_app/model/getmessage/message.dart';

class MessagesState {}

final class MessagesInitial extends MessagesState {}
final class MessagesloadingState extends MessagesState {}
final class MessagessuccessState extends MessagesState {
  
}
final class MessageserrorState extends MessagesState {
  final String errorMessage;
  MessageserrorState(this.errorMessage);
}





final class GetMessagesLoadingState extends MessagesState {}
final class GetMessagessuccessState extends MessagesState {
  final List<Message> messages;
  GetMessagessuccessState({required this.messages});
}
final class GetMessageserrorState extends MessagesState {
  final String errorMessage;
  GetMessageserrorState(this.errorMessage);
}


