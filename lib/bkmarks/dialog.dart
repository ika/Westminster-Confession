// import 'package:flutter/material.dart';
// import 'package:westminster_confession/bkmarks/model.dart';
// import 'package:westminster_confession/bkmarks/queries.dart';

// // Bookmarks Dialog

// BMQueries bmQueries = BMQueries();
// BMModel? model;

// class BMDialog {
//   Future confirmDialog(BuildContext context, BMModel bmmodel) async {
//     return showDialog(
//       builder: (context) => AlertDialog(
//         title: const Text("Delete BookMark?"), // title
//         content: Text("${bmmodel.title}\n${bmmodel.subtitle}"), // subtitle
//         actions: [
//           TextButton(
//             child: const Text('YES',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             onPressed: () => Navigator.of(context).pop(true),
//           ),
//           TextButton(
//             child:
//                 const Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
//             onPressed: () => Navigator.of(context).pop(false),
//           ),
//         ],
//       ),
//       context: context,
//     );
//   }

//   SnackBar bmExistsSnackBar = const SnackBar(
//     content: Text('BookMark already exists.'),
//   );

//   SnackBar bmAddedSnackBar = const SnackBar(
//     content: Text('BookMark added.'),
//   );

//   void bMWrapper(BuildContext context, BMModel bmmodel) {
    
//     bmQueries.getBookMarkExists(bmmodel.para).then((value) {
//       if (value < 1) {
//         confirmDialog(context, bmmodel).then((value) {
//           if (value) {
//             final model = BMModel(
//                 title: bmmodel.title,
//                 subtitle: bmmodel.subtitle,
//                 para: bmmodel.para);
//             bmQueries.saveBookMark(model).then((value) {
//               ScaffoldMessenger.of(context).showSnackBar(bmAddedSnackBar);
//             });
//           }
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(bmExistsSnackBar);
//       }
//     });
//   }
// }
