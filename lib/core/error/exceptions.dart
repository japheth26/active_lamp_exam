class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

const String ERROR_UNKNOWN = 'Unknown error';

const String ERROR_403 = 'Error[403]: Forbidden';

const String ERROR_404 = 'Error[404]: Not found';

const String ERROR_500 = 'Error[500]: Server internal error';

const String ERROR_503 = 'Error[503] Server emporarily not available';
