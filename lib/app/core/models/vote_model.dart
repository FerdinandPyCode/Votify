import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:votify_2/app/core/models/options_model.dart';
import 'package:votify_2/app/core/models/user_vote_model.dart';

class Vote {
  String id = '';
  String title = '';
  String description = '';
  String dateState = '';
  String dateEnd = '';
  String electionType = '';
  String createAt = '';
  String creator = '';
  List<String> votersEmail = [];
  List<Option> listeOptions = [];
  List<UserVote> listeVote = [];
  Vote({
    required this.id,
    required this.title,
    required this.description,
    required this.dateState,
    required this.dateEnd,
    required this.electionType,
    required this.createAt,
    required this.creator,
    required this.votersEmail,
    required this.listeOptions,
    required this.listeVote,
  });

  factory Vote.initial() => Vote(
      id: "",
      title: "",
      description: "",
      dateState: "",
      dateEnd: "",
      electionType: "",
      createAt: "",
      creator: "",
      votersEmail: [],
      listeOptions: [],
      listeVote: []);

  Vote copyWith({
    String? id,
    String? title,
    String? description,
    String? dateState,
    String? dateEnd,
    String? electionType,
    String? createAt,
    String? creator,
    List<String>? votersEmail,
    List<Option>? listeOptions,
    List<UserVote>? listeVote,
  }) {
    return Vote(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateState: dateState ?? this.dateState,
      dateEnd: dateEnd ?? this.dateEnd,
      electionType: electionType ?? this.electionType,
      createAt: createAt ?? this.createAt,
      creator: creator ?? this.creator,
      votersEmail: votersEmail ?? this.votersEmail,
      listeOptions: listeOptions ?? this.listeOptions,
      listeVote: listeVote ?? this.listeVote,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'dateState': dateState});
    result.addAll({'dateEnd': dateEnd});
    result.addAll({'electionType': electionType});
    result.addAll({'createAt': createAt});
    result.addAll({'creator': creator});
    result.addAll({'votersEmail': votersEmail});
    result
        .addAll({'listeOptions': listeOptions.map((x) => x.toMap()).toList()});
    result.addAll({'listeVote': listeVote.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Vote.fromMap(Map<String, dynamic> map) {
    return Vote(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateState: map['dateState'] ?? '',
      dateEnd: map['dateEnd'] ?? '',
      electionType: map['electionType'] ?? '',
      createAt: map['createAt'] ?? '',
      creator: map['creator'] ?? '',
      votersEmail: List<String>.from(map['votersEmail']),
      listeOptions:
          List<Option>.from(map['listeOptions']?.map((x) => Option.fromMap(x))),
      listeVote: List<UserVote>.from(
          map['listeVote']?.map((x) => UserVote.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vote.fromJson(String source) => Vote.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vote(id: $id, title: $title, description: $description, dateState: $dateState, dateEnd: $dateEnd, electionType: $electionType, createAt: $createAt, creator: $creator, votersEmail: $votersEmail, listeOptions: $listeOptions, listeVote: $listeVote)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vote &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.dateState == dateState &&
        other.dateEnd == dateEnd &&
        other.electionType == electionType &&
        other.createAt == createAt &&
        other.creator == creator &&
        listEquals(other.votersEmail, votersEmail) &&
        listEquals(other.listeOptions, listeOptions) &&
        listEquals(other.listeVote, listeVote);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        dateState.hashCode ^
        dateEnd.hashCode ^
        electionType.hashCode ^
        createAt.hashCode ^
        creator.hashCode ^
        votersEmail.hashCode ^
        listeOptions.hashCode ^
        listeVote.hashCode;
  }
}
