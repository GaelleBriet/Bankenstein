import 'package:bankestein/models/recipient.dart';

abstract class RecipientState {}

class RecipientInitial extends RecipientState {}

class RecipientLoading extends RecipientState {}

class RecipientLoaded extends RecipientState {
  final List<Recipient> recipients;
  RecipientLoaded(this.recipients);
}

class RecipientError extends RecipientState {
  final String errorMessage;
  final List<Recipient> recipients;

  RecipientError(this.errorMessage, this.recipients);
}

class RecipientSuccess extends RecipientState {
    final String message;

    RecipientSuccess(this.message);
}