import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/bloc/recipient_state.dart';
import 'package:bankestein/widgets/recipient_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recipient_cubit.dart';
import '../widgets/Navigation_bar_bottom.dart';
import '../widgets/Navigation_bar_top.dart';


class RecipientsView extends StatelessWidget {
  const RecipientsView({Key? key}) : super(key: key);

  static const String pageName = 'recipients';

  @override
  Widget build(BuildContext context) {
    final recipientCubit = BlocProvider.of<RecipientCubit>(context);
    final authState = context.watch<AuthenticationCubit>().state;
    final authCubit = context.watch<AuthenticationCubit>();
    if (authCubit.state is AuthenticationAuthenticated) {
      final accessToken = (authCubit.state as AuthenticationAuthenticated).accessToken;
      recipientCubit.getRecipients(accessToken);
    }

    return BlocListener<RecipientCubit, RecipientState>(
      listener: (context, state) {
        if (state is RecipientSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is RecipientError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
      appBar: const NavigationBarTop(title: 'Recipients'),
      body: BlocBuilder<RecipientCubit, RecipientState>(
        builder: (context, state) {
          if (state is RecipientLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipientLoaded) {
            return RecipientList(
              recipients: state.recipients,
              recipientCubit: recipientCubit,
              authState: authState,
            );
          } else if (state is RecipientError) {
            return RecipientList(
              recipients: state.recipients,
              recipientCubit: recipientCubit,
              authState: authState,
            );
          } else {
            return const Center(
              child: Text('No recipients found ... '),
            );
          }
        },
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 2),
    ),);
  }
}