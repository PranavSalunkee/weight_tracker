class UserWeight {
  UserWeight({required this.date, required this.weight});
  final DateTime date;
  double weight;

  @override
  String toString() {
    return '{$date, $weight}';
  }
}

class UserData {
  final List<String> dates;
  final List<String> weights;

  UserData({required this.dates, required this.weights});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      dates: List<String>.from(json['dates'].map((x) => x.toString())),
      weights: List<String>.from(json['weights'].map((x) => x.toString())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates,
      'weights': weights,
    };
  }
}
