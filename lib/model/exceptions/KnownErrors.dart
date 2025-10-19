import 'KnownError.dart';

class KnownErrors{
  List<KnownError> knownErrors = new List.empty(growable: true);

  KnownErrors();

  addError(KnownError knownError) {
    knownErrors.add(knownError);
  }

  List<KnownError> getErrors() {
    return knownErrors;
  }

  KnownErrors.fromJson(List<dynamic> json) {
    for (var item in json) {
      knownErrors.add(KnownError.fromJson(item));
    }
  }

  bool noErrors() {
    return knownErrors.isEmpty;
  }
}