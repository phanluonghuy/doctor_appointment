class Medicine {
  final String id;
  final String name;
  final List<MedicineImage>? images;
  final String? indications;
  final String? contraindications;
  final String? sideEffects;
  final DateTime createdAt;
  final DateTime updatedAt;

  Medicine({
    required this.id,
    required this.name,
    this.images,
    this.indications,
    this.contraindications,
    this.sideEffects,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `Medicine` object from JSON
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['_id'] as String,
      name: json['name'] as String,
      images: json['images'] != null
          ? (json['images'] as List)
          .map((image) => MedicineImage.fromJson(image))
          .toList()
          : null,
      indications: json['indications'] as String?,
      contraindications: json['contraindications'] as String?,
      sideEffects: json['sideEffects'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `Medicine` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'images': images?.map((image) => image.toJson()).toList(),
      'indications': indications,
      'contraindications': contraindications,
      'sideEffects': sideEffects,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class MedicineImage {
  final String url;
  final String fileName;
  final String fileType;

  MedicineImage({
    required this.url,
    required this.fileName,
    required this.fileType,
  });

  /// Factory constructor to create a `MedicineImage` object from JSON
  factory MedicineImage.fromJson(Map<String, dynamic> json) {
    return MedicineImage(
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
    );
  }

  /// Converts the `MedicineImage` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'fileName': fileName,
      'fileType': fileType,
    };
  }
}
