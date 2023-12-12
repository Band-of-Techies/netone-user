// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, sort_child_properties_last

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netone_enquiry_management/api/loandetails.dart';
import 'package:netone_enquiry_management/api/products.dart';
import 'package:netone_enquiry_management/constants/colors.dart';
import 'package:netone_enquiry_management/constants/text.dart';
import 'package:netone_enquiry_management/constants/textfield.dart';
import 'package:netone_enquiry_management/main.dart';
import 'package:provider/provider.dart';

class SectionThree extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  SectionThree(this.myTabController, this._tabController);

  @override
  State<SectionThree> createState() => _SectionThreeState();
}

class _SectionThreeState extends State<SectionThree>
    with SingleTickerProviderStateMixin {
  LoanDetails loadndetails = LoanDetails();
  final _formKey = GlobalKey<FormState>();

  bool canAgreePersonOne = false;
  bool canAgreePersonTwo = false;
  bool canAgreePersonThree = false;
  bool canAgreePersonFour = false;
  XFile? pickedImageOne;
  XFile? pickedImageTwo;
  XFile? pickedImageThree;
  XFile? pickedImageFour;
  List<Product> products = [];
  final ImagePicker _imagePicker = ImagePicker();
  List<String> tenureOptions = [
    '3 months',
    '6 months',
    '12 months',
    '18 months',
    '24 months',
    '36 months',
    '48 months',
    '60 months',
    '72 months',
  ];
  @override
  Widget build(BuildContext context) {
    final myTabController = Provider.of<MyTabController>(context);
    loadndetails = myTabController.loanDetails;
    return Scaffold(
      body: products.isEmpty || products == null
          ? Center(
              child: CircularProgressIndicator(color: primary),
            )
          : Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                      child: Column(
                        children: [
                          section3A(),
                          SizedBox(
                            height: 30,
                          ),
                          loandetails(),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Affirmations',
                            style: GoogleFonts.dmSans(
                                color: blackfont,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 20),
                          affirmationsection(canAgreePersonOne, pickedImageOne,
                              'For First Applicant'),
                          if (widget.myTabController.numberOfPersons > 1)
                            affirmationsection(canAgreePersonTwo,
                                pickedImageTwo, 'For Second Applicant'),
                          if (widget.myTabController.numberOfPersons > 2)
                            affirmationsection(canAgreePersonThree,
                                pickedImageThree, 'For Third Applicant'),
                          if (widget.myTabController.numberOfPersons > 3)
                            affirmationsection(canAgreePersonFour,
                                pickedImageFour, 'For Fourth Applicant'),
                          SizedBox(height: 40),
                          /*  Text(
                  'Supporting Documentation Submitted, loadndetails are advised to attach the following documents',
                  style: GoogleFonts.dmSans(
                      color: blackfont,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),*/
                          // DocumentTable(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .48,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(buttondarkbg),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(15))),
                              onPressed: () {
                                myTabController.loanDetails = loadndetails;
                                //printApplicantDetails();
                                if (widget._tabController.index <
                                    widget._tabController.length - 1) {
                                  widget._tabController.animateTo(
                                      widget._tabController.index + 1);
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
                                  backgroundColor:
                                      MaterialStateProperty.all(primary),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(15))),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  myTabController.loanDetails = loadndetails;
                                  //printApplicantDetails();
                                  if (widget._tabController.index <
                                      widget._tabController.length - 1) {
                                    widget._tabController.animateTo(
                                        widget._tabController.index + 1);
                                  } else {
                                    // Handle the case when the last tab is reached
                                  }
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

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    final String apiUrl = 'https://loan-managment.onrender.com/products';
    final String bearerToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAyNjYwNzk3fQ.aNgcnhSk31oF3CP_72Aiy38hKiNYIuhrNrxcGk6jp7Y';

    try {
      final dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $bearerToken'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        setState(() {
          products =
              responseData.map((data) => Product.fromJson(data)).toList();
        });
        ;
      } else {
        // Handle error, show a message, or perform other actions on failure
        print('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error during API call: $error');
    }
  }

  Column affirmationsection(bool canagree, XFile? pickedImage, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: GoogleFonts.dmSans(
              color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '''I (full name) hereby confirm that the information provided by me in this loan application, including my source of funds put forward for partial/full finance of asset is true and correct and I have the capacity to repay the loan. I understand that this Loan Application may be declined at any stage should any information contained herein be found to be incorrect or misleading in any material way. I consent to PSMFC making enquiries regarding my credit history with any Credit Reference Bureau or Credit Rating Agency and for PSMFC to share my payment behaviour with any Credit Reference Bureau or Credit Reference Agency and any other institution that it may require to do so in order to assess my application or by applicable laws or regulation. I consent to PSMFC reporting the conclusion of any credit agreement in compliance with the Zambian legislation.''',
          style: GoogleFonts.dmSans(
              color: blackfont, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Upload Image',
              style: GoogleFonts.dmSans(
                  color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 30),
            pickedImage == null
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    onPressed: () async {
                      final XFile? image = await _imagePicker.pickImage(
                          source: ImageSource.gallery);

                      if (image != null) {
                        setState(() {
                          pickedImage = image;
                        });
                      }
                    },
                    child: Text(
                      'Pick Image',
                      style: GoogleFonts.dmSans(
                          color: whitefont,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Image.file(File(pickedImage!.path)),
          ],
        ),
        SizedBox(height: 40),
        Row(
          children: [
            Checkbox(
              value: canagree,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    canagree = value;
                  });
                }
              },
            ),
            Text(
              'I agree to all the information provided',
              style: GoogleFonts.dmSans(
                  color: blackfont, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Row loandetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Amount applied',
                style: GoogleFonts.dmSans(
                    color: blackfont,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                isEnabled: false,
                controller: loadndetails.costofasset,
                labelText: 'Total cost of asset',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total cost of asset';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.insurancecost,
                labelText: 'Total Insurance cost',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total insurance cost';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.advancepayment,
                labelText: 'Less advance payment',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter less advance payment';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.loanamaountapplied,
                labelText: 'Loan amount applied for',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter loan amount applied for';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Loan Tenure',
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
                  loadndetails.tenure == null
                      ? 'Loan Tenure'
                      : loadndetails.tenure.toString(),
                  style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: blackfont,
                      fontWeight: FontWeight.w500),
                ),
                items: tenureOptions.map((letter) {
                  return DropdownMenuItem(
                    value: letter,
                    child: Text(
                      letter,
                      style: GoogleFonts.dmSans(color: blackfont),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    loadndetails.tenure = value.toString();
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
            ],
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Share of loadn applied (only asset and agriclute loan',
                style: GoogleFonts.dmSans(
                    color: blackfont,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: loadndetails.firstapplicant,
                labelText: 'First Applicant',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first Applicant';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.thirdapplicant,
                labelText: 'Third Applicant (Agric Asset ONLY)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter third applicant';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.firstapplicantproportion,
                labelText: 'First Applicant Proportion of loan (%)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.thirdapplicantpropotion,
                labelText: 'Third Applicant Proportion of loan (%))',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Third Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Amount applied',
                style: GoogleFonts.dmSans(
                    color: blackfont,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: loadndetails.secondapplicant,
                labelText: 'Second Applicant',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Second Applicant';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.fourthapplicant,
                labelText: 'Fourth Applicant (Agric Asset ONLY)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fourth Applicant (Agric Asset ONLY)';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.secondapplicantpropotion,
                labelText: 'Second Applicant Proportion of loan (%)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Second Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.fourthapplicantpropotion,
                labelText: 'SFourth Applicant Proportion of loan (%)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fourth Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column section3A() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan Product Apllied for (Tick only one)',
          style: GoogleFonts.dmSans(
              color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 8.0, // Adjust the spacing between items
          runSpacing: 8.0, // Adjust the spacing between lines
          children: [
            for (int i = 0; i < products.length; i++)
              buildCheckBox(products[i].id, products[i].name, i),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        TextFormField(
          controller: loadndetails.descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            labelStyle: GoogleFonts.dmSans(
              color: Colors.black,
              height: 0.5,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: primary, width: 1.0),
            ),
          ),
          style: GoogleFonts.dmSans(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 3,
          validator: (value) {},
        )
      ],
    );
  }

  Widget buildCheckBox(int id, String title, int i) {
    return InkWell(
      onTap: () {
        setState(() {
          loadndetails.selectedLoanOption = id;
          loadndetails.costofasset.text = products[i].price.toString();
        });
      },
      child: Chip(
        padding: EdgeInsets.all(12),
        label: Text(
          title,
          style: GoogleFonts.dmSans(
              color:
                  loadndetails.selectedLoanOption == id ? whitefont : blackfont,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: loadndetails.selectedLoanOption == id
            ? primary // Change the color when selected
            : whitefont,
      ),
    );
  }
}

class DocumentTable extends StatelessWidget {
  final double rowHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 16,
          columns: [
            DataColumn(label: Text('SN')),
            DataColumn(label: Text('Document')),
            DataColumn(label: Text('First Applicant')),
            DataColumn(label: Text('Second Applicant')),
            DataColumn(label: Text('Third Applicant')),
            DataColumn(label: Text('Fourth Applicant')),
          ],
          rows: List.generate(8, (index) => buildDataRow(index)),
        ),
      ),
    );
  }

  DataRow buildDataRow(int index) {
    return DataRow(cells: [
      DataCell(Container(
        width: 50,
        child: Center(
          child: Text((index + 1).toString()),
        ),
      )),
      DataCell(Container(
        width: 200,
        child: Text(getDocumentName(index)),
      )),
      DataCell(Container(width: 150, child: AttachmentCell())),
      DataCell(Container(width: 150, child: AttachmentCell())),
      DataCell(Container(width: 150, child: AttachmentCell())),
      DataCell(Container(width: 150, child: AttachmentCell())),
    ]);
  }

  static String getDocumentName(int index) {
    switch (index) {
      case 0:
        return "Introduction letter from employer";
      case 1:
        return "Certified Copies of three latest payslips";
      case 2:
        return "Certified Copy of National Registration Card (NRC)";
      case 3:
        return "Certified copy of valid driver's license (if any)";
      case 4:
        return "Valid quotation from the asset dealer";
      case 5:
        return "Stamped copy of previous month's bank statement";
      case 6:
        return "Pre-signed and undated 'STOP ORDER' instruction to your bank where you hold the salaries account";
      case 7:
        return "Proof of marriage (Motor Vehicle Joint Application ONLY))";
      default:
        return "";
    }
  }
}

class AttachmentCell extends StatefulWidget {
  @override
  _AttachmentCellState createState() => _AttachmentCellState();
}

class _AttachmentCellState extends State<AttachmentCell> {
  String fileName = '';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize
            .min, // Use min to allow the column to occupy minimum height
        children: [
          fileName.isEmpty
              ? ElevatedButton(
                  onPressed: _pickFile,
                  child: Text('Pick File'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(90, 30), // Adjust button height as needed
                  ),
                )
              : GestureDetector(
                  onTap: _pickFile,
                  child: Text(fileName),
                ),
        ],
      ),
    );
  }
}
