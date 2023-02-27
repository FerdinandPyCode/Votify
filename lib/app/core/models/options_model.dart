import 'dart:convert';

class Option {
  String code = '';
  String fullName = '';
  String imageUrl = '';
  int voteCounter = 0;
  Option({
    required this.code,
    required this.fullName,
    required this.imageUrl,
    required this.voteCounter,
  });

  Option copyWith({
    String? code,
    String? fullName,
    String? imageUrl,
    int? voteCounter,
  }) {
    return Option(
      code: code ?? this.code,
      fullName: fullName ?? this.fullName,
      imageUrl: imageUrl ?? this.imageUrl,
      voteCounter: voteCounter ?? this.voteCounter,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'code': code});
    result.addAll({'fullName': fullName});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'voteCounter': voteCounter});

    return result;
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      code: map['code'] ?? '',
      fullName: map['fullName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      voteCounter: map['voteCounter']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) => Option.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Option(code: $code, fullName: $fullName, imageUrl: $imageUrl, voteCounter: $voteCounter)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Option &&
        other.code == code &&
        other.fullName == fullName &&
        other.imageUrl == imageUrl &&
        other.voteCounter == voteCounter;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        fullName.hashCode ^
        imageUrl.hashCode ^
        voteCounter.hashCode;
  }
}
