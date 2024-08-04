class Editing {
	String? status;
	String? message;

	Editing({this.status, this.message});

	factory Editing.fromJson(Map<String, dynamic> json) => Editing(
				status: json['status'] as String?,
				message: json['message'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
			};
}
