// To parse this JSON data, do
//
//     final photosbyId = photosbyIdFromJson(jsonString);

import 'dart:convert';

PhotosbyId photosbyIdFromJson(String str) =>
    PhotosbyId.fromJson(json.decode(str));

class PhotosbyId {
  String? id;
  String? blurHash;
  String? description;
  String? altDescription;
  Urls? urls;
  int? likes;
  User? user;
  Location? location;
  List<PhotosbyIdTag>? tags;
  List<TagsPreview>? tagsPreview;
  int? views;
  int? downloads;

  PhotosbyId({
    this.id,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.likes,
    this.user,
    this.location,
    this.tags,
    this.tagsPreview,
    this.views,
    this.downloads,
  });

  factory PhotosbyId.fromJson(Map<String, dynamic> json) => PhotosbyId(
        id: json["id"] ?? "",
        blurHash: json["blur_hash"] ?? "",
        description: json["description"] ?? "",
        altDescription: json["alt_description"] ?? "",
        urls: Urls.fromJson(json["urls"]),
        likes: json["likes"] ?? 0,
        user: User.fromJson(json["user"]),
        location: json["location"] == null
            ? Location()
            : Location.fromJson(json["location"]),
        tags: json["tags"] == null
            ? null
            : List<PhotosbyIdTag>.from(
                json["tags"].map((x) => PhotosbyIdTag.fromJson(x))),
        tagsPreview: json["tags_preview"] == null
            ? null
            : List<TagsPreview>.from(
                json["tags_preview"].map((x) => TagsPreview.fromJson(x))),
        views: json["views"] ?? 0,
        downloads: json["downloads"] ?? 0,
      );
}

class Location {
  String? name;
  String? city;
  String? country;

  Location({
    this.name,
    this.city,
    this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"] ?? "",
        city: json["city"] ?? "",
        country: json["country"] ?? "",
      );
}

class Urls {
  String? full;
  String? regular;
  String? small;
  String? thumb;

  Urls({
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
      );
}

class User {
  String? id;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? bio;
  String? location;
  UserLinks links;
  ProfileImage profileImage;
  int totalCollections;
  int totalLikes;
  int totalPhotos;

  User({
    this.id,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.bio,
    this.location,
    required this.links,
    required this.profileImage,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        name: json["name"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? '',
        bio: json["bio"] ?? "",
        location: json["location"],
        links: UserLinks.fromJson(json["links"]),
        profileImage: ProfileImage.fromJson(json["profile_image"]),
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
    required this.photos,
    required this.likes,
    required this.following,
    required this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
        photos: json["photos"],
        likes: json["likes"],
        following: json["following"],
        followers: json["followers"],
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
}

class PhotosbyIdTag {
  String title;
  FluffySource? source;

  PhotosbyIdTag({
    required this.title,
    this.source,
  });

  factory PhotosbyIdTag.fromJson(Map<String, dynamic> json) => PhotosbyIdTag(
        title: json["title"],
        source: json["source"] == null
            ? null
            : FluffySource.fromJson(json["source"]),
      );
}

class FluffySource {
  String title;
  String subtitle;
  String description;
  FluffyCoverPhoto coverPhoto;

  FluffySource({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.coverPhoto,
  });

  factory FluffySource.fromJson(Map<String, dynamic> json) => FluffySource(
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        coverPhoto: FluffyCoverPhoto.fromJson(json["cover_photo"]),
      );
}

class FluffyCoverPhoto {
  String? id;
  String? blurHash;
  String? description;
  String? altDescription;
  Urls? urls;
  int? likes;
  User user;

  FluffyCoverPhoto({
    this.id,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    required this.likes,
    required this.user,
  });

  factory FluffyCoverPhoto.fromJson(Map<String, dynamic> json) =>
      FluffyCoverPhoto(
        id: json["id"] ?? "",
        blurHash: json["blur_hash"] ?? "",
        description: json["description"] ?? "",
        altDescription: json["alt_description"] ?? '',
        urls: Urls.fromJson(json["urls"]),
        likes: json["likes"] ?? 0,
        user: User.fromJson(json["user"]),
      );
}

class TagsPreview {
  String title;
  TagsPreviewSource? source;

  TagsPreview({
    required this.title,
    this.source,
  });

  factory TagsPreview.fromJson(Map<String, dynamic> json) => TagsPreview(
        title: json["title"],
        source: json["source"] == null
            ? null
            : TagsPreviewSource.fromJson(json["source"]),
      );
}

class TagsPreviewSource {
  String title;
  String subtitle;
  String description;
  TentacledCoverPhoto coverPhoto;

  TagsPreviewSource({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.coverPhoto,
  });

  factory TagsPreviewSource.fromJson(Map<String, dynamic> json) =>
      TagsPreviewSource(
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        coverPhoto: TentacledCoverPhoto.fromJson(json["cover_photo"]),
      );
}

class TentacledCoverPhoto {
  String id;
  String slug;
  String blurHash;
  String? description;
  String? altDescription;
  Urls urls;
  int likes;
  User user;

  TentacledCoverPhoto({
    required this.id,
    required this.slug,
    required this.blurHash,
    this.description,
    required this.altDescription,
    required this.urls,
    required this.likes,
    required this.user,
  });

  factory TentacledCoverPhoto.fromJson(Map<String, dynamic> json) =>
      TentacledCoverPhoto(
        id: json["id"],
        slug: json["slug"],
        blurHash: json["blur_hash"],
        description: json["description"] ?? "",
        altDescription: json["alt_description"] ?? "",
        urls: Urls.fromJson(json["urls"]),
        likes: json["likes"] ?? 0,
        user: User.fromJson(json["user"]),
      );
}
