import 'package:dio/dio.dart';

class ErrorHandler {
  static String getMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Délai de connexion dépassé. Vérifiez votre connexion.';
        
        case DioExceptionType.badResponse:
          return _handleStatusCode(error.response?.statusCode);
        
        case DioExceptionType.cancel:
          return 'Requête annulée';
        
        default:
          return 'Erreur de connexion au serveur';
      }
    }
    return 'Une erreur est survenue';
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Requête invalide';
      case 401:
        return 'Session expirée. Veuillez vous reconnecter.';
      case 403:
        return 'Accès refusé';
      case 404:
        return 'Ressource introuvable';
      case 500:
        return 'Erreur serveur. Réessayez plus tard.';
      case 503:
        return 'Service temporairement indisponible';
      default:
        return 'Erreur serveur (Code $statusCode)';
    }
  }
}
