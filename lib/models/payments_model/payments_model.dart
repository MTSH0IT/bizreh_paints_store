import 'payment.dart';
import 'summary.dart';

class PaymentsModel {
	int? userId;
	List<Payment>? payments;
	Summary? summary;

	PaymentsModel({this.userId, this.payments, this.summary});

	factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
				userId: json['user_id'] as int?,
				payments: (json['payments'] as List<dynamic>?)
						?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
						.toList(),
				summary: json['summary'] == null
						? null
						: Summary.fromJson(json['summary'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'user_id': userId,
				'payments': payments?.map((e) => e.toJson()).toList(),
				'summary': summary?.toJson(),
			};
}
