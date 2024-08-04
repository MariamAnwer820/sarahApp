class Message {
	String? message;
	DateTime? createdAt;
	DateTime? updatedAt;

	Message({this.message, this.createdAt, this.updatedAt});

	factory Message.fromJson(Map<String, dynamic> json) => Message(
				message: json['message'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
			);

	Map<String, dynamic> toJson() => {
				'message': message,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
			};
}
