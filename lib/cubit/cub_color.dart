// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:westminster_confession/colors/col_palette.dart';
// import 'package:westminster_confession/utils/globals.dart';

// class ColorsState {
//   ThemeData themeData;
//   ColorsState({required this.themeData});
// }

// class ColorsCubit extends Cubit<ColorsState> {
//   ColorsCubit()
//       : super(
//           ColorsState(
//             themeData: ThemeData(
//               colorScheme: ColorScheme.fromSeed(
//                 seedColor: Palette.colorsList.values
//                     .elementAt(Globals.colorListNumber),
//               ),
//             ),
//           ),
//         );

//   void setcolorScheme(MaterialColor color) => emit(
//         ColorsState(
//           themeData:
//               ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: color)),
//         ),
//       );

//   //void getSize() async => emit(Globals.initialTextSize);

//   //Future<void> getcolorScheme() async => emit(ColorsState(themeData: ThemeData(colorScheme: ColorScheme.));
// }
