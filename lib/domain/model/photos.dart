// To parse this JSON data, do
//
//     final photos = photosFromJson(jsonString);

import 'dart:convert';

List<Photos> photosFromJson(String str) =>
    List<Photos>.from(json.decode(str).map((x) => Photos.fromJson(x)));

// String photosToJson(List<Photos> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Photos {
  String id;
  String slug;
  int width;
  int height;
  String color;
  String blurHash;
  String? description;
  String altDescription;
  Urls urls;
  PhotoLinks links;
  int likes;
  List<dynamic> currentUserCollections;
  User user;

  Photos({
    required this.id,
    required this.slug,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    this.description,
    required this.altDescription,
    required this.urls,
    required this.links,
    required this.likes,
    required this.currentUserCollections,
    required this.user,
  });

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        id: json["id"] ?? "",
        slug: json["slug"] ?? "",
        width: json["width"] ?? 0,
        height: json["height"] ?? 0,
        color: json["color"] ?? "",
        blurHash: json["blur_hash"] ?? "",
        description: json["description"] ?? "",
        altDescription: json["alt_description"] ?? "",
        urls: json["urls"] == null ? Urls() : Urls.fromJson(json["urls"]),
        links: json["links"] == null
            ? PhotoLinks()
            : PhotoLinks.fromJson(json["links"]),
        likes: json["likes"] ?? 0,
        currentUserCollections:
            List<dynamic>.from(json["current_user_collections"].map((x) => x)),
        user: User.fromJson(json["user"]),
      );
}

class PhotoLinks {
  String? self;
  String? download;
  String? downloadLocation;

  PhotoLinks({
    this.self,
    this.download,
    this.downloadLocation,
  });

  factory PhotoLinks.fromJson(Map<String, dynamic> json) => PhotoLinks(
        self: json["self"] ?? "",
        download: json["download"] ?? "",
        downloadLocation: json["download_location"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "download": download,
        "download_location": downloadLocation,
      };
}

class User {
  String id;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? portfolioUrl;
  String? bio;
  String? location;
  ProfileImage? profileImage;
  int totalCollections;
  int totalLikes;
  int totalPhotos;

  User({
    required this.id,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.profileImage,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        name: json["name"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        portfolioUrl: json["portfolio_url"],
        bio: json["bio"] ?? "",
        location: json["location"] ?? "",
        profileImage: json["profile_image"] == null
            ? ProfileImage()
            : ProfileImage.fromJson(json["profile_image"]),
        totalCollections: json["total_collections"],
        totalLikes: json["total_likes"],
        totalPhotos: json["total_photos"],
      );
}

class UserLinks {
  String? photos;
  String? likes;
  String? following;
  String? followers;

  UserLinks({
    this.photos,
    this.likes,
    this.following,
    this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
        photos: json["photos"] ?? "",
        likes: json["likes"] ?? "",
        following: json["following"] ?? "",
        followers: json["followers"] ?? "",
      );
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        small: json["small"] ?? "",
        medium: json["medium"] ?? "",
        large: json["large"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"] ?? "",
        full: json["full"] ?? "",
        regular: json["regular"] ?? "",
        small: json["small"] ?? "",
        thumb: json["thumb"] ?? "",
        smallS3: json["small_s3"] ?? "",
      );
}
