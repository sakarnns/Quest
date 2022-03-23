class UserProfile {
  UserProfile({
    this.name,
    this.surname,
    this.username,
    this.email,
    this.points,
    this.tier,
    this.image,
    this.phone,
    this.ctzid,
  });

  final String? name;
  final String? surname;
  final String? username;
  final String? email;
  final int? points;
  final int? tier;
  final String? image;
  final String? phone;
  final String? ctzid;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json["name"] == null ? null : json["name"],
        surname: json["Surname"] == null ? null : json["Surname"],
        username: json["Username"] == null ? null : json["Username"],
        email: json["Email"] == null ? null : json["Email"],
        points: json["Points"] == null ? null : json["Points"],
        tier: json["Tier_Point"] == null ? null : json["Tier_Point"],
        image: json["Profile_image"] == null ? null : json["Profile_image"],
        phone: json["Phone"] == null ? null : json["Phone"],
        ctzid: json["ctzid"] == null ? null : json["ctzid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "Surname": surname == null ? null : surname,
        "Username": username == null ? null : username,
        "Email": email == null ? null : email,
        "Points": points == null ? null : points,
        "Tier_Point": tier == null ? null : tier,
        "Profile_image": image == null ? null : image,
        "Phone": phone == null ? null : phone,
        "ctzid": ctzid == null ? null : ctzid,
      };
}