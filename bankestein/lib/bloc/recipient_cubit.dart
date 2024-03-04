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

      final recipients =
          await RecipientService.getRecipients(accessToken);
      emit(RecipientLoaded(recipients));
    } catch (e) {
      emit(RecipientError("Failed to load recipients: $e"));
    }
  }

  void deleteRecipient(String accessToken, int recipientId) async {
    try {
      emit(RecipientLoading());
      await RecipientService.deleteRecipient(accessToken, recipientId);
      final updatedRecipients = await RecipientService.getRecipients(accessToken);
      emit(RecipientLoaded(updatedRecipients));
    } catch (e) {
      print("error");
      emit(RecipientError("Failed to delete recipient: $e"));
    }
  }
}