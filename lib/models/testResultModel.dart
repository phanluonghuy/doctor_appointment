class TestResult {
  final String id;
  final String medicalRecordId;
  final String testName;
  final String? labDetails;
  final TestResultFile? results;
  final DateTime createdAt;
  final DateTime updatedAt;

  TestResult({
    required this.id,
    required this.medicalRecordId,
    required this.testName,
    this.labDetails,
    this.results,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a `TestResult` object from JSON
  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      id: json['_id'] as String,
      medicalRecordId: json['medicalRecordId'] as String,
      testName: json['testName'] as String,
      labDetails: json['labDetails'] as String?,
      results: json['results'] != null
          ? TestResultFile.fromJson(json['results'] as Map<String, dynamic>)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the `TestResult` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medicalRecordId': medicalRecordId,
      'testName': testName,
      'labDetails': labDetails,
      'results': results?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class TestResultFile {
  final String url;
  final String fileName;
  final String fileType;

  TestResultFile({
    required this.url,
    required this.fileName,
    required this.fileType,
  });

  /// Factory constructor to create a `TestResultFile` object from JSON
  factory TestResultFile.fromJson(Map<String, dynamic> json) {
    return TestResultFile(
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
    );
  }

  /// Converts the `TestResultFile` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'fileName': fileName,
      'fileType': fileType,
    };
  }
}
