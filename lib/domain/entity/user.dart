import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  String get initials {
    final List<String> nameParts = name.trim().split(' ');
    String initials = '';

    for (int i = 0; i < nameParts.length; i++) {
      final str = nameParts[i];
      if (str.isNotEmpty) {
        initials += nameParts[i][0];

        if (i == 1) {
          return initials;
        }
      }
    }

    return initials.toUpperCase();
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
