import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<ThemeData> {
  SettingCubit()
      : super(ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF711CCC),
          ),
        ));

  void toggleTheme() {
    emit(state.brightness == Brightness.light
        ? ThemeData.dark().copyWith(
            primaryColor: const Color(0xFF711CCC),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF711CCC),
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: const Color(0xFF711CCC),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF711CCC),
            ),
          ));
  }
}
