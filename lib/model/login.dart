class Login {
	String? status;
	String? message;
	String? token;

	Login({this.status, this.message, this.token});

	factory Login.fromJson(Map<String, dynamic> json) => Login(
				status: json['status'] as String?,
				message: json['message'] as String?,
				token: json['token'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'token': token,
			};
}
