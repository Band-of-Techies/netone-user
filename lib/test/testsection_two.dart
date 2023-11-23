// // ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:netone_enquiry_management/api/applicantdetails.dart';
// import 'package:netone_enquiry_management/api/applicants.dart';
// import 'package:netone_enquiry_management/constants/colors.dart';
// import 'package:netone_enquiry_management/constants/text.dart';
// import 'package:netone_enquiry_management/main.dart';
// import 'package:provider/provider.dart';

// class SectionTwo extends StatefulWidget {
//   final MyTabController myTabController;
//   late TabController _tabController;

//   SectionTwo(this.myTabController, this._tabController);

//   @override
//   State<SectionTwo> createState() => _SectionTwoState();
// }

// class _SectionTwoState extends State<SectionTwo> {
//   final _formKey = GlobalKey<FormState>();

//   List<EmployemntandKlinDetails> applicantDetailsList =
//       List.generate(4, (_) => EmployemntandKlinDetails());

//   List<String> employemnttypelist = ['Permanent', 'Temporary'];
//   @override
//   Widget build(BuildContext context) {
//     final numberOfPersons = widget.myTabController.numberOfPersons;
//     final myTabController = Provider.of<MyTabController>(context);
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               CustomText(
//                 text: 'Employment Details',
//                 color: blackfont,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//               ),
//               employmentDetails('Applicant 1', 0),
//               if (numberOfPersons > 1) employmentDetails('Applicant 2', 1),
//               if (numberOfPersons > 2) employmentDetails('Applicant 3', 2),
//               if (numberOfPersons > 3) employmentDetails('Applicant 4', 3),
//               SizedBox(
//                 height: 40,
//               ),
//               Text('Nex of Kin Information'),
//               kinInformation('Applicant 1', 0),
//               if (numberOfPersons > 1) kinInformation('Applicant 2', 1),
//               if (numberOfPersons > 2) kinInformation('Applicant 3', 2),
//               if (numberOfPersons > 3) kinInformation('Applicant 4', 3),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       if (widget._tabController.index <
//                           widget._tabController.length - 1) {
//                         widget._tabController
//                             .animateTo(widget._tabController.index - 1);
//                       } else {
//                         // Handle the case when the last tab is reached
//                       }
//                       //widget.myTabController.updateNumberOfPersons(numberOfPersons);
//                       //  DefaultTabController.of(context)?.animateTo(1);
//                       // if (_formKey.currentState!.validate()) {
//                       //   // Form is valid, move to the next section

//                       // }
//                     },
//                     child: Text('Previous'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       myTabController.employmentDetailsList =
//                           applicantDetailsList;
//                       // printApplicantDetails();
//                       if (widget._tabController.index <
//                           widget._tabController.length - 1) {
//                         widget._tabController
//                             .animateTo(widget._tabController.index + 1);
//                       } else {
//                         // Handle the case when the last tab is reached
//                       }
//                       //widget.myTabController.updateNumberOfPersons(numberOfPersons);
//                       //  DefaultTabController.of(context)?.animateTo(1);
//                       // if (_formKey.currentState!.validate()) {
//                       //   // Form is valid, move to the next section

//                       // }
//                     },
//                     child: Text('Next'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void printApplicantDetails() {
//     for (int i = 0; i < applicantDetailsList.length; i++) {
//       print('Applicant ${i + 1} Details:');

//       // Kin Information
//       print('Name: ${applicantDetailsList[i].nameController.text}');
//       print(
//           'Other Names: ${applicantDetailsList[i].otherNamesController.text}');
//       print(
//           'Physical Address: ${applicantDetailsList[i].physicalAddressControlleremployment.text}');
//       print(
//           'Postal Address: ${applicantDetailsList[i].postalAddressControllerEmployment.text}');
//       print(
//           'Cell Number: ${applicantDetailsList[i].cellNumberController.text}');
//       print(
//           'Email Address: ${applicantDetailsList[i].emailAddressController.text}');
//       print(
//           'Additional Field 1: ${applicantDetailsList[i].physicalAddressControllernextofkin.text}');
//       print(
//           'Additional Field 2: ${applicantDetailsList[i].postalAddressControllerforKline.text}');

//       // Employment Details
//       print('Job Title: ${applicantDetailsList[i].jobTitleController.text}');
//       print('Ministry: ${applicantDetailsList[i].ministryController.text}');

//       print('Town: ${applicantDetailsList[i].townController.text}');
//       print('Province: ${applicantDetailsList[i].provinceController.text}');

//       // Additional Fields for employmentDetails
//       print(
//           'Gross Salary: ${applicantDetailsList[i].grossSalaryController.text}');
//       print(
//           'Current Net Salary: ${applicantDetailsList[i].currentNetSalaryController.text}');
//       print(
//           'Salary Scale: ${applicantDetailsList[i].salaryScaleController.text}');
//       print(
//           'Preferred Year of Retirement: ${applicantDetailsList[i].preferredYearOfRetirementController.text}');
//       print(
//           'Employee Number: ${applicantDetailsList[i].employeeNumberController.text}');
//       print(
//           'Years in Employment: ${applicantDetailsList[i].yearsInEmploymentController.text}');

//       // Employment Type
//       print('Employment Type: ${applicantDetailsList[i].employmentType}');
//       print('Employment Exp: ${applicantDetailsList[i].expiryDateController}');
//       // Additional Fields as needed

//       print('\n');
//     }
//   }

//   Column kinInformation(String message, int index) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(message),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Name'),
//                 onChanged: (value) {
//                   applicantDetailsList[index].nameController.text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter name';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Other Names'),
//                 onChanged: (value) {
//                   applicantDetailsList[index].otherNamesController.text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter other names';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         ),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Physical Address'),
//           onChanged: (value) {
//             applicantDetailsList[index]
//                 .physicalAddressControllernextofkin
//                 .text = value;
//           },
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter physical address';
//             }
//             return null;
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Postal Address'),
//           onChanged: (value) {
//             applicantDetailsList[index].postalAddressControllerforKline.text =
//                 value;
//           },
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter posal addres';
//             }
//             return null;
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Cell Number'),
//           onChanged: (value) {
//             applicantDetailsList[index].cellNumberController.text = value;
//           },
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter cell number';
//             }
//             return null;
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Email Address'),
//           onChanged: (value) {
//             applicantDetailsList[index].emailAddressController.text = value;
//           },
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter email';
//             }
//             return null;
//           },
//         ),
//         SizedBox(
//           height: 40,
//         ),
//       ],
//     );
//   }

//   Column employmentDetails(String message, int index) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           message,
//           style: GoogleFonts.dmSans(
//               color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Job Title'),
//                 onChanged: (value) {
//                   applicantDetailsList[index].jobTitleController.text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter job';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             SizedBox(width: 40.0),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Ministry'),
//                 onChanged: (value) {
//                   applicantDetailsList[index].ministryController.text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter ministy';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Physical Address'),
//                 onChanged: (value) {
//                   applicantDetailsList[index]
//                       .physicalAddressControlleremployment
//                       .text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter physical address';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             SizedBox(width: 40.0),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Postal Address'),
//                 onChanged: (value) {
//                   applicantDetailsList[index]
//                       .postalAddressControllerEmployment
//                       .text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter postal address';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Town'),
//                 onChanged: (value) {
//                   applicantDetailsList[index].townController.text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter town';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             SizedBox(width: 40.0),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Province'),
//                 onChanged: (value) {
//                   applicantDetailsList[index].provinceController.text = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter province';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Gross Salary'),
//                 controller: applicantDetailsList[index].grossSalaryController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter gross salary';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             SizedBox(width: 40.0),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Current Net Salary'),
//                 controller:
//                     applicantDetailsList[index].currentNetSalaryController,
//               ),
//             ),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Salary Scale'),
//                 controller: applicantDetailsList[index].salaryScaleController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter salary scale';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration:
//                     InputDecoration(labelText: 'Preferred Year of Retirement'),
//                 keyboardType: TextInputType.datetime,
//                 controller: applicantDetailsList[index]
//                     .preferredYearOfRetirementController,
//               ),
//             ),
//             SizedBox(width: 40.0),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Employee Number'),
//                 controller:
//                     applicantDetailsList[index].employeeNumberController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter employee number';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Years in Employment'),
//                 controller:
//                     applicantDetailsList[index].yearsInEmploymentController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter year';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text('Employment Type:'),
//             Row(
//               children: [
//                 Row(
//                   children: employemnttypelist.map((String value) {
//                     return Row(
//                       children: [
//                         Radio(
//                           value: value,
//                           groupValue:
//                               applicantDetailsList[index].employmentType,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               applicantDetailsList[index].employmentType =
//                                   newValue!;
//                             });
//                           },
//                         ),
//                         Text(value),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(width: 40.0),
//                 if (applicantDetailsList[index].employmentType == 'Temporary')
//                   SizedBox(
//                     width: 200,
//                     child: GestureDetector(
//                       onTap: () async {
//                         await _selectJobExpiryDate(
//                             context, applicantDetailsList[index]);
//                       },
//                       child: AbsorbPointer(
//                         child: TextFormField(
//                           decoration:
//                               InputDecoration(labelText: 'License Expiry Date'),
//                           keyboardType: TextInputType.datetime,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 40,
//         ),
//       ],
//     );
//   }

//   bool validateEmploymentType(List<EmployemntandKlinDetails> applicants) {
//     for (int i = 0; i < applicants.length; i++) {
//       String employmentType = applicants[i].employmentType;

//       if (employmentType != 'Permanent' && employmentType != 'Temporary') {
//         // Employment type is not a valid value (neither "Permanent" nor "Temporary")
//         return false;
//       }

//       // Additional validation for Temporary employment type if needed
//       if (employmentType == 'Temporary' &&
//           applicants[i].expiryDateController.isEmpty) {
//         // Additional field for Temporary employment is empty
//         return false;
//       }
//     }

//     // All employmentType values are either "Permanent" or "Temporary" with additional validation if needed
//     return true;
//   }

//   Future<void> _selectJobExpiryDate(
//       BuildContext context, EmployemntandKlinDetails applicant) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101), // Adjust as needed
//     );

//     if (picked != null) {
//       setState(() {
//         applicant.expiryDateController = picked.toString();
//       });
//     }
//   }
// }
