class Rain {
	double? oneh;

	Rain({this.oneh});

	factory Rain.fromJson(Map<String, dynamic> json) => Rain(
				oneh: (json['oneh'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'oneh': oneh,
			};
}
