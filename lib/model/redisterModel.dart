class Register {
	String? status;
	String? message;

	Register({this.status, this.message});

	factory Register.fromJson(Map<String, dynamic> json) => Register(
				status: json['status'] as String?,
				message: json['message'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
			};
}
