import 'dart:convert';

class NotifModel {
  String key = '';
  String title = '';
  String description = '';
  String createdAt = '';
  String to = '';
  String from = '';
  String type = '';
  int seen = 0;
  NotifModel({
    required this.key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.to,
    required this.from,
    required this.type,
    required this.seen,
  });

  NotifModel copyWith({
    String? key,
    String? title,
    String? description,
    String? createdAt,
    String? to,
    String? from,
    String? type,
    int? seen,
  }) {
    return NotifModel(
      key: key ?? this.key,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      to: to ?? this.to,
      from: from ?? this.from,
      type: type ?? this.type,
      seen: seen ?? this.seen,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'key': key});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'createdAt': createdAt});
    result.addAll({'to': to});
    result.addAll({'from': from});
    result.addAll({'type': type});
    result.addAll({'seen': seen});
  
    return result;
  }

  factory NotifModel.fromMap(Map<String, dynamic> map) {
    return NotifModel(
      key: map['key'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['createdAt'] ?? '',
      to: map['to'] ?? '',
      from: map['from'] ?? '',
      type: map['type'] ?? '',
      seen: map['seen']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifModel.fromJson(String source) => NotifModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotifModel(key: $key, title: $title, description: $description, createdAt: $createdAt, to: $to, from: $from, type: $type, seen: $seen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotifModel &&
      other.key == key &&
      other.title == title &&
      other.description == description &&
      other.createdAt == createdAt &&
      other.to == to &&
      other.from == from &&
      other.type == type &&
      other.seen == seen;
  }

  @override
  int get hashCode {
    return key.hashCode ^
      title.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      to.hashCode ^
      from.hashCode ^
      type.hashCode ^
      seen.hashCode;
  }
}
