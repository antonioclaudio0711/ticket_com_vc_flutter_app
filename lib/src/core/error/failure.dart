abstract class Failure implements Exception {
  final String title;
  final String description;

  Failure({
    required this.title,
    required this.description,
  });
}

class HttpRequestException extends Failure {
  final String titleError;
  final String descriptionError;

  HttpRequestException({
    required this.titleError,
    required this.descriptionError,
  }) : super(
          title: titleError,
          description: descriptionError,
        );
}

class UnknownException extends Failure {
  final String titleError;
  final String descriptionError;

  UnknownException({
    required this.titleError,
    required this.descriptionError,
  }) : super(
          title: titleError,
          description: descriptionError,
        );
}
