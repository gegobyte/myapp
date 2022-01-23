import 'package:flutter/foundation.dart';

import '../genre/genre.dart';
import './movie_entity.dart';

@immutable
class Movie {
  final int id;
  final String title;
  final String overview;
  final num voteAverage;
  final List<Genre> genres;
  final String releaseDate;
  final String? backdropPath;
  final String? posterPath;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genres,
    required this.releaseDate,
    this.backdropPath,
    this.posterPath,
  });

  Movie.initial()
      : id = 0,
        title = '',
        overview = '',
        voteAverage = 0,
        genres = [],
        releaseDate = '',
        backdropPath = '',
        posterPath = '';

  factory Movie.fromEntity(MovieEntity entity, List<Genre> genres) {
    return Movie(
      id: entity.id,
      title: entity.title,
      overview: entity.overview,
      voteAverage: entity.voteAverage,
      genres: genres
          .where((genre) => entity.genreIds.contains(genre.id))
          .toList(growable: false),
      releaseDate: entity.releaseDate,
      backdropPath:
          'https://image.tmdb.org/t/p/original/${entity.backdropPath}',
      posterPath: 'https://image.tmdb.org/t/p/original/${entity.posterPath}',
    );
  }

  String get genresCommaSeparated =>
      genres.map((e) => e.name).toList().join(', ');

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, overview: $overview, voteAverage: $voteAverage, genres: $genres, releaseDate: $releaseDate, backdropPath: $backdropPath, posterPath: $posterPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.id == id &&
        other.title == title &&
        other.overview == overview &&
        other.voteAverage == voteAverage &&
        listEquals(other.genres, genres) &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        overview.hashCode ^
        voteAverage.hashCode ^
        genres.hashCode ^
        releaseDate.hashCode;
  }
}
