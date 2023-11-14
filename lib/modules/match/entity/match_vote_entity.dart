

class MatchVoteEntity {
  int matchId;
  int homeTeam;
  int awayTeam;
  int type;
  int isHight;

  MatchVoteEntity({
    required this.matchId,
    required this.homeTeam,
    required this.awayTeam,
    required this.type,
    required this.isHight,
  });

  factory MatchVoteEntity.fromJson(Map<String, dynamic> json) {
    return MatchVoteEntity(
      matchId: json['matchId'] ?? 0,
      homeTeam: json['homeTeam'] ?? 0,
      awayTeam: json['awayTeam'] ?? 0,
      type: json['type'] ?? 0,
      isHight: json['isHight'] ?? 0
    );
  }
}
