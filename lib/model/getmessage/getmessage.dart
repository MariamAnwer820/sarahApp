import 'message.dart';

class Gmessage {
	String? status;
	String? message;
	List<Message>? messages;

	Gmessage({this.status, this.message, this.messages});

	factory Gmessage.fromJson(Map<String, dynamic> json) => Gmessage(
				status: json['status'] as String?,
				message: json['message'] as String?,
				messages: (json['messages'] as List<dynamic>?)
						?.map((e) => Message.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'messages': messages?.map((e) => e.toJson()).toList(),
			};
}
