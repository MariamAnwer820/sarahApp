class Send {
	String? status;
	String? message;

	Send({this.status, this.message});

	factory Send.fromJson(Map<String, dynamic> json) => Send(
				message: json['message'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'message': message,
			};
}
