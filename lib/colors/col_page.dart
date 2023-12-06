// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:westminster_confession/colors/col_palette.dart';
// import 'package:westminster_confession/cubit/cub_color.dart';
// import 'package:westminster_confession/utils/globals.dart';
// import 'package:westminster_confession/utils/shared_prefs.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';

// SharedPrefs _sharedPrefs = SharedPrefs();
// MaterialColor? primaryScheme;

// class ColorsPage extends StatefulWidget {
//   const ColorsPage({Key? key}) : super(key: key);

//   @override
//   State<ColorsPage> createState() => _ColorsPageState();
// }

// class _ColorsPageState extends State<ColorsPage> {
//   @override
//   void initState() {
//     super.initState();
//     // primarySwatch =
//     //     Palette.colorsList.values.elementAt(Globals.colorListNumber);
//     // primaryScheme = BlocProvider.of<ColorsCubit>(context)
//     //     .state
//     //     .themeData
//     //     .colorScheme
//     //     .primary as MaterialColor?;
//     //primaryColor = context.read<ColorsCubit>().state.themeData.primaryColor as MaterialColor?;

//     //primaryScheme = context.read<ColorsCubit>().state as MaterialColor?;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         actions: const [],
//         elevation: 16,
//         title: Text(
//           'Color Selector',
//           style: Theme.of(context).textTheme.headlineSmall,
//           // style: TextStyle(
//           //   color: primarySwatch![50],
//           // ),
//         ),
//         leading: GestureDetector(
//           child: const Icon(Icons.arrow_back),
//           onTap: () {
//             Future.delayed(
//               Duration(milliseconds: Globals.navigatorDelay),
//               () {
//                 Navigator.pop(context);
//               },
//             );
//           },
//         ),
//       ),
//       body: Center(
//         child: ListView(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             for (int i = 0; i < 52; i++)
//               InkWell(
//                 onTap: () {
//                   //final colorcubit = context.read<ColorsCubit>();
//                   //Globals.colorListNumber = i;
//                   _sharedPrefs.setIntPref('colorsList', i).then(
//                     (value) {
//                       //primaryColor = Globals.colorListNumber = i;

//                       // setState(() {
//                       //   //primaryColor = Palette.colorsList.values.elementAt(i);
//                       //   FlexColorScheme.light(scheme: FlexScheme.blue).toTheme;
//                       // });

//                       //Theme.of(context).

//                       // BlocProvider.of<ColorsCubit>(context)
//                       //     .setPalette(Palette.colorsList.values.elementAt(i));
//                       // Future.delayed(
//                       //   Duration(milliseconds: Globals.navigatorDelay),
//                       //   () {
//                       //     Navigator.of(context).pushNamed(('/WeMain'));
//                       //   },
//                       // );
//                     },
//                   );
//                 },
//                 child: Center(
//                   child: Column(
//                     children: [
//                       // const SizedBox(
//                       //   height: 8,
//                       // ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
//                           height: 55,
//                           decoration: BoxDecoration(
//                             //color: FlexScheme.values[i].name., //Colors.green[200],
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             FlexScheme.values[i].name,
//                           ))
//                     ],
//                   ),
//                 ),
//                 // child: Container(
//                 //   margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
//                 //   height: 55,
//                 //   // color: FlexScheme.values[i].name
//                 //   //      .toColor, //Palette.colorsList.values.elementAt(i),
//                 //   child: Center(
//                 //     child: Text(FlexScheme.values[i].name,
//                 //         //Palette.colorsList.keys.elementAt(i),
//                 //         style: Theme.of(context).textTheme.bodyLarge),
//                 //   ),
//                 // ),
//               ),
//             //)
//           ],
//         ),
//       ),
//     );
//   }
// }
