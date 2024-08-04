
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/api.dart';
import 'package:saraih_app/cubit/message-cubit/messages_state.dart';
import 'package:saraih_app/model/getmessage/message.dart';
import 'package:saraih_app/model/send.message.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this.apiService) : super(MessagesInitial());
  final ApiService apiService;
   sendMassage({
    required String email,
    required String message,
  }) async {
    emit(MessagesloadingState());

    try {
      Response response = await apiService.sendMassage(
        endPoint: '/message/addMessage',
        email: email,
        message: message,
      );
      Send userModel = Send.fromJson(response.data);
      print(userModel);
      emit(MessagessuccessState());
    } on DioException catch (e) {
      emit(MessageserrorState(e.toString()));
    }
  }
  Getmessage() async {
    emit(GetMessagesLoadingState());
    try {
      Response response = await apiService.Getmessage(
        endPoint: '/message/getMessage',
      );
      //Gmessage userModel = Gmessage.fromJson(response.data);
      Map<String,dynamic> Responsedata =response.data;
      List<Message> messages = [];
      for(int i=0;i<Responsedata['messages'].length;i++){
        messages.add(Message.fromJson(Responsedata['messages'][i])
        );
      }
      print(messages);
      emit(GetMessagessuccessState(messages:messages));
    } on DioException catch (e) {
      emit(GetMessageserrorState(e.toString()));
    }
  }
}
