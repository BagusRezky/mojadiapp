class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final String birthDate;
  final String address;

  AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.birthDate,
    required this.address,
  });

  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? birthDate,
    String? address,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
    );
  }
}
