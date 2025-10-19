class KnownError{
  String? errorCode;
  String errorMessage;
  String clientMessage;

  KnownError(String? errorCode, String errorMessage, String clientMessage)
      : this.errorCode = errorCode,
        this.errorMessage = errorMessage,
        this.clientMessage = clientMessage;

  KnownError.fromJson(Map<String, dynamic> json)
      : errorCode = json['errorCode'],
        errorMessage = json['errorMessage'],
        clientMessage = json['clientMessage'];

  String? getErrorCode() {
    return errorCode;
  }

  String getErrorMessage() {
    return clientMessage;
  }

  String getClientMessage() {
    return clientMessage;
  }

  KnownError setErrorCode(String code) {
    errorCode = code;
    return this;
  }

  KnownError setErrorMessage(String message) {
    errorMessage = message;
    return this;
  }

  KnownError setClientMessage(String message) {
    clientMessage = message;
    return this;
  }
}