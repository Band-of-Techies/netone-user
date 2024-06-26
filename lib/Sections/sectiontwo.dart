// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_enquiry_management/api/applicantdetails.dart';
import 'package:netone_enquiry_management/constants/colors.dart';
import 'package:netone_enquiry_management/constants/text.dart';
import 'package:netone_enquiry_management/constants/textfield.dart';
import 'package:netone_enquiry_management/main.dart';
import 'package:provider/provider.dart';

class SectionTwo extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  SectionTwo(this.myTabController, this._tabController);

  @override
  State<SectionTwo> createState() => _SectionTwoState();
}

class _SectionTwoState extends State<SectionTwo>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  List<EmployemntandKlinDetails> applicantDetailsLists = [];
  List<String> yearsList = List.generate(50, (index) => (index + 1).toString());
  List<String> letters = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<String> employemnttypelist = ['Permanent', 'Contract'];
  String? selectedProvince;
  String? selectedTown;
  List<String> provinces = [
    'Central',
    'Copperbelt',
    'Eastern',
    'Luapula',
    'Lusaka',
    'Northern',
    'Muchinga',
    'North-Western',
    'Southern',
    'Western',
  ];
  Map<String, List<String>> townsByProvince = {
    'Central': [
      'Chibombo District',
      'Chisamba District',
      'Chitambo District',
      'Kabwe District',
      'Kapiri Mposhi District',
      'Luano District',
      'Mkushi District',
      'Mumbwa District',
      'Ngabwe District',
      'Serenje District',
      'Shibuyunji District',
    ],
    'Copperbelt': [
      'Chililabombwe District',
      'Chingola District',
      'Kalulushi District',
      'Kitwe District',
      'Luanshya District',
      'Lufwanyama District',
      'Masaiti District',
      'Mpongwe District',
      'Mufulira District',
      'Ndola District',
    ],
    'Eastern': [
      'Chadiza District',
      'Chama District',
      'Chasefu District',
      'Chipangali District',
      'Chipata District',
      'Kasenengwa District',
      'Katete District',
      'Lumezi District',
      'Lundazi District',
      'Lusangazi District',
      'Mambwe District',
      'Nyimba District',
      'Petauke District',
      'Sinda District',
      'Vubwi District',
    ],
    'Luapula': [
      'Chembe District',
      'Chiengi District',
      'Chifunabuli District',
      'Chipili District',
      'Kawambwa District',
      'Lunga District',
      'Mansa District',
      'Milenge District',
      'Mwansabombwe District',
      'Mwense District',
      'Nchelenge District',
      'Samfya District',
    ],
    'Lusaka': [
      'Chilanga District',
      'Chongwe District',
      'Kafue District',
      'Luangwa District',
      'Lusaka District',
      'Rufunsa District',
    ],
    'Muchinga': [
      'Chinsali District',
      'Isoka District',
      'Mafinga District',
      'Mpika District',
      'Nakonde District',
      'Shiwangandu District',
      'Kanchibiya District',
      'Lavushimanda District',
    ],
    'Northern': [
      'Kasama District',
      'Chilubi District',
      'Kaputa District',
      'Luwingu District',
      'Mbala District',
      'Mporokoso District',
      'Mpulungu District',
      'Mungwi District',
      'Nsama District',
      'Lupososhi District',
      'Lunte District',
      'Senga Hill District',
    ],
    'North-Western': [
      'Chavuma District',
      'Ikelenge District',
      'Kabompo District',
      'Kalumbila District',
      'Kasempa District',
      'Manyinga District',
      'Mufumbwe District',
      'Mushindamo District',
      'Mwinilunga District',
      'Solwezi District',
      'Zambezi District',
    ],
    'Southern': [
      'Chikankata District',
      'Chirundu District',
      'Choma District',
      'Gwembe District',
      'Itezhi-Tezhi District',
      'Kalomo District',
      'Kazungula District',
      'Livingstone District',
      'Mazabuka District',
      'Monze District',
      'Namwala District',
      'Pemba District',
      'Siavonga District',
      'Sinazongwe District',
      'Zimba District',
    ],
    'Western': [
      'Kalabo District',
      'Kaoma District',
      'Limulunga District',
      'Luampa District',
      'Lukulu District',
      'Mitete District',
      'Mongu District',
      'Mulobezi District',
      'Mwandi District',
      'Nalolo District',
      'Nkeyema District',
      'Senanga District',
      'Sesheke District',
      'Shangombo District',
      'Sikongo District',
      'Sioma District',
    ]
  };
  String? selectedLetter;
  @override
  Widget build(BuildContext context) {
    final numberOfPersons = widget.myTabController.numberOfPersons;
    final myTabController = Provider.of<MyTabController>(context);
    List<EmployemntandKlinDetails> applicantDetailsLists =
        myTabController.employmentDetailsList;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomText(
                text: 'Employment Details',
                color: blackfont,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              employmentDetails('Applicant 1', applicantDetailsLists[0]),
              if (numberOfPersons > 1)
                employmentDetails('Applicant 2', applicantDetailsLists[1]),
              if (numberOfPersons > 2)
                employmentDetails('Applicant 3', applicantDetailsLists[2]),
              if (numberOfPersons > 3)
                employmentDetails('Applicant 4', applicantDetailsLists[3]),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'Next of Kin Information',
                color: blackfont,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              kinInformation('Applicant 1', applicantDetailsLists[0]),
              if (numberOfPersons > 1)
                kinInformation('Applicant 2', applicantDetailsLists[1]),
              if (numberOfPersons > 2)
                kinInformation('Applicant 3', applicantDetailsLists[2]),
              if (numberOfPersons > 3)
                kinInformation('Applicant 4', applicantDetailsLists[3]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .48,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(buttondarkbg),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15))),
                        onPressed: () {
                          if (widget._tabController.index <
                              widget._tabController.length - 1) {
                            widget._tabController
                                .animateTo(widget._tabController.index - 1);
                          } else {
                            // Handle the case when the last tab is reached
                          }
                          //widget.myTabController.updateNumberOfPersons(numberOfPersons);
                          //  DefaultTabController.of(context)?.animateTo(1);
                          // if (_formKey.currentState!.validate()) {
                          //   // Form is valid, move to the next section

                          // }
                        },
                        child: CustomText(
                          text: 'Previous',
                          color: whitefont,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .48,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(primary),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15))),
                        onPressed: () {
                          myTabController.employmentDetailsList =
                              applicantDetailsLists;
                          myTabController
                              .updateEMplymentandKlin(applicantDetailsLists);
                          // printApplicantDetails();
                          if (widget._tabController.index <
                              widget._tabController.length - 1) {
                            widget._tabController
                                .animateTo(widget._tabController.index + 1);
                          } else {
                            // Handle the case when the last tab is reached
                          }
                          //widget.myTabController.updateNumberOfPersons(numberOfPersons);
                          //  DefaultTabController.of(context)?.animateTo(1);
                          // if (_formKey.currentState!.validate()) {
                          //   // Form is valid, move to the next section

                          // }
                        },
                        child: CustomText(
                          text: 'Next',
                          color: whitefont,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void printApplicantDetails() {
    for (int i = 0; i < widget.myTabController.numberOfPersons; i++) {
      print('Applicant ${i + 1} Details:');

      // Kin Information
      print('Name: ${applicantDetailsLists[i].nameController.text}');
      print(
          'Other Names: ${applicantDetailsLists[i].otherNamesController.text}');
      print(
          'Physical Address: ${applicantDetailsLists[i].physicalAddressControlleremployment.text}');
      print(
          'Postal Address: ${applicantDetailsLists[i].postalAddressControllerEmployment.text}');
      print(
          'Cell Number: ${applicantDetailsLists[i].cellNumberController.text}');
      print(
          'Email Address: ${applicantDetailsLists[i].emailAddressController.text}');
      print(
          'Additional Field 1: ${applicantDetailsLists[i].physicalAddressControllernextofkin.text}');
      print(
          'Additional Field 2: ${applicantDetailsLists[i].postalAddressControllerforKline.text}');

      // Employment Details
      print('Job Title: ${applicantDetailsLists[i].jobTitleController.text}');
      print('Ministry: ${applicantDetailsLists[i].ministryController.text}');

      print('Town: ${applicantDetailsLists[i].townController}');
      print('Province: ${applicantDetailsLists[i].provinceController}');

      // Additional Fields for employmentDetails
      print(
          'Gross Salary: ${applicantDetailsLists[i].grossSalaryController.text}');
      print(
          'Current Net Salary: ${applicantDetailsLists[i].currentNetSalaryController.text}');
      print('Salary Scale: ${applicantDetailsLists[i].salaryScaleController}');
      print(
          'Preferred Year of Retirement: ${applicantDetailsLists[i].preferredYearOfRetirementController.text}');
      print(
          'Employee Number: ${applicantDetailsLists[i].employeeNumberController.text}');
      print(
          'Years in Employment: ${applicantDetailsLists[i].yearsInEmploymentController}');

      // Employment Type
      print('Employment Type: ${applicantDetailsLists[i].employmentType}');
      print('Employment Exp: ${applicantDetailsLists[i].expiryDateController}');
      // Additional Fields as needed

      print('\n');
    }
  }

  Container kinInformation(
      String message, EmployemntandKlinDetails applicantDetailsList) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(82, 240, 246, 156),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: GoogleFonts.dmSans(
                color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.nameController,
                labelText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.otherNamesController,
                labelText: 'Other Names',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter other names';
                  }
                  return null;
                },
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller:
                      applicantDetailsList.physicalAddressControllernextofkin,
                  labelText: 'Physical Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter physical address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                child: CustomTextFormField(
                  controller:
                      applicantDetailsList.postalAddressControllerforKline,
                  labelText: 'Postal Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal addres';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: applicantDetailsList.cellNumberController,
                  labelText: 'Cell Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter cell number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: applicantDetailsList.emailAddressController,
                  labelText: 'Email Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container employmentDetails(
      String message, EmployemntandKlinDetails applicantDetailsList) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(80, 252, 227, 194),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: GoogleFonts.dmSans(
                color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.jobTitleController,
                labelText: 'Job Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.ministryController,
                labelText: 'Minsitry',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ministy';
                  }
                  return null;
                },
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                controller:
                    applicantDetailsList.physicalAddressControlleremployment,
                labelText: 'Physical Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter physical address';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
                controller:
                    applicantDetailsList.postalAddressControllerEmployment,
                labelText: 'Postal Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter postal address';
                  }
                  return null;
                },
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Choose Province',
                    labelStyle: GoogleFonts.dmSans(
                      color: Colors.black,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: blackfont,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blackfont,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add more decoration..
                  ),
                  hint: Text(
                    applicantDetailsList.provinceController == null
                        ? 'Choose Province'
                        : applicantDetailsList.provinceController.toString(),
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blackfont,
                    ),
                  ),
                  items: provinces
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: CustomText(
                              fontSize: 14,
                              color: blackfont,
                              fontWeight: FontWeight.w500,
                              text: item,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when selected item is changed.
                    print(selectedTown);
                    setState(() {
                      selectedProvince = value.toString();
                      applicantDetailsList.provinceController =
                          value.toString();
                      applicantDetailsList.townController = null;
                      selectedTown = null;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: blackfont),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Choose Town',
                    labelStyle: GoogleFonts.dmSans(
                      color: Colors.black,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: blackfont,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blackfont,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add more decoration..
                  ),
                  hint: Text(
                    selectedTown == null
                        ? 'Choose Town'
                        : applicantDetailsList.townController.toString(),
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: blackfont,
                        fontWeight: FontWeight.w500),
                  ),
                  items: townsByProvince[selectedProvince]
                          ?.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: CustomText(
                                  fontSize: 14,
                                  color: blackfont,
                                  text: item,
                                ),
                              ))
                          .toList() ??
                      [],
                  onChanged: (value) {
                    setState(() {
                      selectedTown = value;
                      applicantDetailsList.townController = value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: blackfont),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.grossSalaryController,
                labelText: 'Gross Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gross salary';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.currentNetSalaryController,
                labelText: 'Current Net Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current net salary';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Salary Scale',
                    labelStyle: GoogleFonts.dmSans(
                      color: Colors.black,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: blackfont,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blackfont,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add more decoration..
                  ),
                  hint: Text(
                    applicantDetailsList.salaryScaleController == null
                        ? 'Salary Scale'
                        : applicantDetailsList.salaryScaleController.toString(),
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: blackfont,
                        fontWeight: FontWeight.w500),
                  ),
                  items: letters.map((letter) {
                    return DropdownMenuItem(
                      value: letter,
                      child: Text(letter),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      applicantDetailsList.salaryScaleController =
                          value.toString();
                      selectedLetter = value;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: blackfont),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                controller:
                    applicantDetailsList.preferredYearOfRetirementController,
                labelText: 'Preferred Year of Retirement',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter retirement year';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.employeeNumberController,
                labelText: 'Employee Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee number';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Years in Employment',
                    labelStyle: GoogleFonts.dmSans(
                      color: Colors.black,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: blackfont,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blackfont,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add more decoration..
                  ),
                  hint: Text(
                    applicantDetailsList.yearsInEmploymentController == null
                        ? 'Years in Employment'
                        : applicantDetailsList.yearsInEmploymentController
                            .toString(),
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: blackfont,
                        fontWeight: FontWeight.w500),
                  ),
                  items: yearsList.map((letter) {
                    return DropdownMenuItem(
                      value: letter,
                      child: Text(letter),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      applicantDetailsList.yearsInEmploymentController =
                          value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: blackfont),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              CustomText(
                text: 'Employment Type:',
                color: blackfont,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Row(
                    children: employemnttypelist.map((String value) {
                      return Row(
                        children: [
                          Radio(
                            activeColor: primary,
                            value: value,
                            groupValue: applicantDetailsList.employmentType,
                            onChanged: (String? newValue) {
                              setState(() {
                                applicantDetailsList.employmentType = newValue!;
                              });
                            },
                          ),
                          CustomText(
                            text: value,
                            color: blackfont,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 40.0),
                  if (applicantDetailsList.employmentType == 'Temporary')
                    SizedBox(
                        width: 300,
                        child: GestureDetector(
                          onTap: () async {
                            await _selectJobExpiryDate(
                                context, applicantDetailsList);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  applicantDetailsList.expiryDateController,
                              decoration: InputDecoration(
                                labelText: 'Expiry Date',
                                labelStyle: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  height: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      BorderSide(color: primary, width: 1.0),
                                ),
                              ),
                              style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Expiry Date';
                                }
                                return null;
                              },
                            ),
                          ),
                        )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    applicantDetailsLists = List.generate(
        widget.myTabController.numberOfPersons,
        (index) => EmployemntandKlinDetails());
  }

  bool validateEmploymentType(List<EmployemntandKlinDetails> applicants) {
    for (int i = 0; i < applicants.length; i++) {
      String employmentType = applicants[i].employmentType;

      if (employmentType != 'Permanent' && employmentType != 'Temporary') {
        // Employment type is not a valid value (neither "Permanent" nor "Temporary")
        return false;
      }

      // Additional validation for Temporary employment type if needed
      if (employmentType == 'Temporary' &&
          applicants[i].expiryDateController.text.isEmpty) {
        // Additional field for Temporary employment is empty
        return false;
      }
    }

    // All employmentType values are either "Permanent" or "Temporary" with additional validation if needed
    return true;
  }

  Future<void> _selectJobExpiryDate(
      BuildContext context, EmployemntandKlinDetails applicant) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101), // Adjust as needed
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        applicant.expiryDateController.text = formattedDate;
      });
    }
  }
}
