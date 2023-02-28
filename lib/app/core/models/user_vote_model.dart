import 'dart:convert';

class UserVote {
  String userId = '';
  String optionchoisi = '';
  String votedAt = '';
  UserVote({
    required this.userId,
    required this.optionchoisi,
    required this.votedAt,
  });

  UserVote copyWith({
    String? userId,
    String? optionchoisi,
    String? votedAt,
  }) {
    return UserVote(
      userId: userId ?? this.userId,
      optionchoisi: optionchoisi ?? this.optionchoisi,
      votedAt: votedAt ?? this.votedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userId': userId});
    result.addAll({'optionchoisi': optionchoisi});
    result.addAll({'votedAt': votedAt});
  
    return result;
  }

  factory UserVote.fromMap(Map<String, dynamic> map) {
    return UserVote(
      userId: map['userId'] ?? '',
      optionchoisi: map['optionchoisi'] ?? '',
      votedAt: map['votedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserVote.fromJson(String source) => UserVote.fromMap(json.decode(source));

  @override
  String toString() => 'UserVote(userId: $userId, optionchoisi: $optionchoisi, votedAt: $votedAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserVote &&
      other.userId == userId &&
      other.optionchoisi == optionchoisi &&
      other.votedAt == votedAt;
  }

  @override
  int get hashCode => userId.hashCode ^ optionchoisi.hashCode ^ votedAt.hashCode;
}
