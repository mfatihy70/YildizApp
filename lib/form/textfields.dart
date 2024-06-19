// //TODO: FIX THIS FILE

// import 'package:flutter/material.dart';
// import 'package:yildiz_app/localization.dart';
// import 'package:yildiz_app/theme/color_scheme.dart';
// import 'form_functions.dart' show customTextField;
// import 'validation.dart';

// List<Widget> textFields(
//   //GlobalKey<FormState> formKey,
//   TextEditingController nameC,
//   TextEditingController addressC,
//   TextEditingController phoneC,
//   TextEditingController milkC,
//   TextEditingController eggC,
//   TextEditingController otherC,
//   String? milkError,
//   String? eggError,
//   String? otherError,
//   BuildContext context,
//   List<Widget> widgets,
// ) {
//   // return Form(
//   //   key: formKey,
//   //   child: SingleChildScrollView(
//   //     padding: EdgeInsets.all(16.0),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.stretch,
//   //       children: [
//   //         customTextField(
//   //           controller: nameC,
//   //           labelText: l('name', context),
//   //           keyboardType: TextInputType.text,
//   //           validator: (value) {
//   //             return validateName(context, value);
//   //           },
//   //         ),
//   //         customTextField(
//   //           controller: addressC,
//   //           labelText: l('address', context),
//   //           keyboardType: TextInputType.text,
//   //           validator: (value) {
//   //             return validateAddress(context, value);
//   //           },
//   //         ),
//   //         customTextField(
//   //           controller: phoneC,
//   //           labelText: l('phone_number', context),
//   //           keyboardType: TextInputType.phone,
//   //           validator: (value) {
//   //             return validatePhoneNumber(context, value);
//   //           },
//   //         ),
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //           children: [
//   //             Expanded(
//   //               child: customTextField(
//   //                 controller: milkC,
//   //                 labelText: l('milk_in_liters', context),
//   //                 keyboardType: TextInputType.number,
//   //                 validator: (String? value) {
//   //                   return milkError;
//   //                 },
//   //               ),
//   //             ),
//   //             Expanded(
//   //               child: customTextField(
//   //                 controller: eggC,
//   //                 labelText: l('egg_in_plates', context),
//   //                 keyboardType: TextInputType.number,
//   //                 validator: (value) {
//   //                   return eggError;
//   //                 },
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         customTextField(
//   //           controller: otherC,
//   //           labelText: l('other', context),
//   //           keyboardType: TextInputType.text,
//   //           validator: (value) {
//   //             return otherError;
//   //           },
//   //         ),
//   //         for (var widget in widgets) widget,
//   //       ],
//   //     ),
//   //   ),
//   // );

//   return [
//     customTextField(
//       controller: nameC,
//       labelText: l('name', context),
//       keyboardType: TextInputType.text,
//       validator: (value) {
//         return validateName(context, value);
//       },
//     ),
//     customTextField(
//       controller: addressC,
//       labelText: l('address', context),
//       keyboardType: TextInputType.text,
//       validator: (value) {
//         return validateAddress(context, value);
//       },
//     ),
//     customTextField(
//       controller: phoneC,
//       labelText: l('phone_number', context),
//       keyboardType: TextInputType.phone,
//       validator: (value) {
//         return validatePhoneNumber(context, value);
//       },
//     ),
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(
//           child: customTextField(
//             controller: milkC,
//             labelText: l('milk_in_liters', context),
//             keyboardType: TextInputType.number,
//             validator: (String? value) {
//               return milkError;
//             },
//           ),
//         ),
//         Expanded(
//           child: customTextField(
//             controller: eggC,
//             labelText: l('egg_in_plates', context),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               return eggError;
//             },
//           ),
//         ),
//       ],
//     ),
//     customTextField(
//       controller: otherC,
//       labelText: l('other', context),
//       keyboardType: TextInputType.text,
//       validator: (value) {
//         return otherError;
//       },
//     ),
//     ...widgets,
//   ];
// }
