import 'dart:async';

import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/services/recipient_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'recipient_state.dart';

class RecipientCubit extends Cubit<RecipientState> {
  final AuthenticationCubit authCubit;
  StreamSubscription? _authSubscription;

  //RecipientCubit() : super(RecipientInitial());

  RecipientCubit(this.authCubit) : super(RecipientInitial()) {
    _authSubscription = authCubit.stream.listen((state) {
      if (state is AuthenticationAuthenticated) {
        getRecipients(state.accessToken);
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  void getRecipients(String accessToken) async {
    try {
      emit(RecipientLoading());
      final recipients = await RecipientService.getRecipients(accessToken);
      emit(RecipientLoaded(recipients));
    } catch (e) {
      emit(RecipientError("Failed to load recipients: $e", []));
    }
  }

  void addRecipient(String accessToken, String name, String iban) async {
    try {
      emit(RecipientLoading());
      await RecipientService.addRecipient(accessToken, name, iban);
      final updatedRecipients =
          await RecipientService.getRecipients(accessToken);
      emit(RecipientLoaded(updatedRecipients));
    } catch (e) {
      final recipients = await RecipientService.getRecipients(accessToken);
      emit(RecipientError("Failed to add recipient", recipients));
      emit(RecipientLoaded(recipients));
    }
  }

  void updateRecipient(String accessToken, String name, String iban, int? recipientId) async {
    try {
      emit(RecipientLoading());
      await RecipientService.updateRecipient(accessToken, name, iban, recipientId);
      final updatedRecipients =
          await RecipientService.getRecipients(accessToken);
      emit(RecipientLoaded(updatedRecipients));
    } catch (e) {
      final recipients = await RecipientService.getRecipients(accessToken);
      emit(RecipientError("Failed to modify recipient {$e}", recipients));
      emit(RecipientLoaded(recipients));
    }
  }

  void deleteRecipient(String accessToken, int recipientId) async {
    try {
      emit(RecipientLoading());
      await RecipientService.deleteRecipient(accessToken, recipientId);
      final updatedRecipients =
          await RecipientService.getRecipients(accessToken);
      emit(RecipientLoaded(updatedRecipients));
    } catch (e) {
      emit(RecipientError("Failed to delete recipient: $e", []));
    }
  }
}
