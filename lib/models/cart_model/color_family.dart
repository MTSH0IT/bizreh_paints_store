class ColorFamily {
	int? id;
	String? colorDegree;

	ColorFamily({this.id, this.colorDegree});

	@override
	String toString() => 'ColorFamily(id: $id, colorDegree: $colorDegree)';

	factory ColorFamily.fromJson(Map<String, dynamic> json) => ColorFamily(
				id: json['id'] as int?,
				colorDegree: json['color_degree'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'color_degree': colorDegree,
			};
}
