// import 'package:flutter/material.dart';
// import 'package:memly/appcolors.dart';
// import 'package:memly/models/flashcard.dart';

// class AddCardDialog extends StatefulWidget {
//   const AddCardDialog({super.key});

//   @override
//   State<AddCardDialog> createState() => _AddCardDialogState();
// }

// class _AddCardDialogState extends State<AddCardDialog> {
//   final frontCtrl = TextEditingController();
//   final backCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final theme =
//         Theme.of(context).brightness == Brightness.dark
//             ? DarkAppColor()
//             : LightAppColor();
//     return StatefulBuilder(
//       builder: (context, setState) {
//         const maxLength = 50;
//         final isTooLong =
//             frontCtrl.text.length > maxLength ||
//             backCtrl.text.length > maxLength;
//         final isEmpty =
//             frontCtrl.text.trim().isEmpty || backCtrl.text.trim().isEmpty;

//         return AlertDialog(
//           title: Text(
//             'Новая карточка',
//             style: TextStyle(color: theme.textColor),
//           ),
//           backgroundColor: theme.backgroundColor,
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: frontCtrl,
//                 maxLength: maxLength,
//                 autofocus: true,
//                 onChanged: (_) => setState(() {}),
//                 decoration: InputDecoration(
//                   labelText: 'Лицевая сторона',
//                   counterText: '${frontCtrl.text.length}/$maxLength',
//                   errorText:
//                       frontCtrl.text.length > maxLength
//                           ? 'Слишком много символов'
//                           : null,
//                 ),
//               ),
//               TextField(
//                 controller: backCtrl,
//                 maxLength: maxLength,
//                 onChanged: (_) => setState(() {}),
//                 decoration: InputDecoration(
//                   labelText: 'Обратная сторона',
//                   counterText: '${backCtrl.text.length}/$maxLength',
//                   errorText:
//                       backCtrl.text.length > maxLength
//                           ? 'Слишком много символов'
//                           : null,
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Отмена'),
//             ),
//             ElevatedButton(
//               onPressed:
//                   isEmpty || isTooLong
//                       ? null
//                       : () {
//                         final card = Flashcard(
//                           front: frontCtrl.text.trim(),
//                           back: backCtrl.text.trim(),
//                           timesReviewed: 0,
//                           deckId: 0,
//                         );
//                         FocusScope.of(context).unfocus();
//                         Navigator.pop(context, card);
//                       },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     isEmpty || isTooLong ? Colors.grey : theme.greenBtnColor,
//               ),
//               child: Text(
//                 'Сохранить',
//                 style: TextStyle(
//                   color:
//                       isEmpty || isTooLong ? Colors.white70 : theme.textColor,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
