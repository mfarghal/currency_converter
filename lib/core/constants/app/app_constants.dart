// ignore_for_file: constant_identifier_names

class ApplicationConstants {
  static const API_KEY = '7abf663b2a6d034a0557';

  static flagUrl({
    required String countyrId,
  }) =>
      'https://flagcdn.com/16x12/$countyrId.png';
}
