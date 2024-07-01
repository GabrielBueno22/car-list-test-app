enum HttpError {
  badRequest,
  notFound,
  serverError,
  unauthorized,
  forbidden,
  invalidData,
  unknown
}

extension HttpErrorMessage on HttpError {
  String get errorMessage {
    switch (this) {
      case HttpError.badRequest:
        return 'Solicitação inválida. Por favor, verifique e tente novamente';
      case HttpError.notFound:
        return 'O recurso solicitado não foi encontrado';
      case HttpError.serverError:
        return 'Ocorreu um erro interno no servidor. Por favor, tente novamente mais tarde';
      case HttpError.unauthorized:
        return 'Você precisa estar autenticado para realizar esta ação';
      case HttpError.forbidden:
        return 'Você não tem permissão para realizar esta ação';
      case HttpError.invalidData:
        return 'Ocorreu um erro ao tratar a resposta do servidor. Por favor, tente novamente mais tarde';
      default:
        return 'Erro desconhecido. Por favor, tente novamente mais tarde';
    }
  }
}
