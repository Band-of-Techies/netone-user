// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, sort_child_properties_last

import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:netone_enquiry_management/api/applicants.dart';
import 'package:netone_enquiry_management/api/loandetails.dart';
import 'package:netone_enquiry_management/api/products.dart';
import 'package:netone_enquiry_management/constants/colors.dart';
import 'package:netone_enquiry_management/constants/text.dart';
import 'package:netone_enquiry_management/constants/textfield.dart';
import 'package:netone_enquiry_management/main.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

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

  List<int> quantity = [];
  List<Product> products = [];
  List<Categories> categories = [];
  String? categoryName; // Define categoryName as a String variable
  String? categoryId; // Define categoryId as a String variable
  String? prodcutname;
  String? productid;
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
    List<ApplicantDetails> applicants = myTabController.applicants;
    return Scaffold(
      body: categories.isEmpty || categories == null
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
                          loandetails(applicants),

                          SizedBox(
                            height: 30,
                          ),
                          bankDetails(),

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
                          affirmationsection(
                              'For First Applicant', applicants, 0),
                          if (widget.myTabController.numberOfPersons > 1)
                            affirmationsection(
                                'For Second Applicant', applicants, 1),
                          if (widget.myTabController.numberOfPersons > 2)
                            affirmationsection(
                                'For Third Applicant', applicants, 2),
                          if (widget.myTabController.numberOfPersons > 3)
                            affirmationsection(
                                'For Fourth Applicant', applicants, 4),
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
                                      widget._tabController.index - 1);
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
                                bool attatchment = false;
                                for (int i = 0;
                                    i < widget.myTabController.numberOfPersons;
                                    i++) {
                                  if (widget.myTabController.applicants[i]
                                          .paysliponeFiles.isNotEmpty &&
                                      widget.myTabController.applicants[i]
                                          .paysliptwoFiles.isNotEmpty &&
                                      widget.myTabController.applicants[i]
                                          .paysliponeFiles.isNotEmpty &&
                                      widget.myTabController.applicants[i]
                                          .intodletterFiles.isNotEmpty &&
                                      widget.myTabController.applicants[i]
                                          .bankStatementFiles.isNotEmpty &&
                                      widget.myTabController.applicants[i]
                                          .nrcFiles.isNotEmpty) {
                                    setState(() {
                                      attatchment = true;
                                    });
                                  }
                                }
                                if (_formKey.currentState!.validate()) {
                                  if (validateTenure(loadndetails)) {
                                    if (attatchment == true) {
                                      myTabController.loanDetails =
                                          loadndetails;
                                      //printApplicantDetails();
                                      if (widget._tabController.index <
                                          widget._tabController.length - 1) {
                                        widget._tabController.animateTo(
                                            widget._tabController.index + 1);
                                      } else {
                                        // Handle the case when the last tab is reached
                                      }
                                    } else {
                                      warning('Attatch all documents');
                                    }
                                  } else {
                                    warning('Select Tenure');
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

    fetchCategories();
  }

  bool validateTenure(LoanDetails loanDetails) {
    for (int i = 0; i < widget.myTabController.numberOfPersons; i++) {
      String? tenure = loanDetails.tenure;

      if (tenure == null) {
        return false;
      }
    }

    return true;
  }

  Container bankDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(80, 252, 227, 194),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Bank Details - Applicant 1',
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
                    controller: loadndetails.bankname,
                    labelText: 'Bank Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Bank Name';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                        return 'Invalid Bank Name';
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
                    controller: loadndetails.branchname,
                    labelText: 'Branch Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Branch Name';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                        return 'Invalid Branch Name';
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
                    controller: loadndetails.sortcode,
                    labelText: 'Sortcode',
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                          return 'Invalid Sortcode';
                        }
                        if (value.length > 6) {
                          return 'Maximum length is 6 digits';
                        }
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
                    controller: loadndetails.accountnumber,
                    labelText: 'Bank Account Number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Bank Acc No';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                        return 'Invalid Account Number';
                      }
                      if (value.length > 13) {
                        return 'Maximum length is 13 digits';
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
            CustomTextFormField(
              controller: loadndetails.nameandbankaddress,
              labelText: 'Bank Name and Full Address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Bank Name and full address';
                }
                if (value.length < 5) {
                  return 'Bank Name and address should have at least 5 characters';
                }
                return null;
              },
            ),
          ]),
    );
  }

  void fetchCategories() async {
    final String apiUrl = 'https://loan-managment.onrender.com/categories';

    try {
      final dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(headers: {
          // Add any custom headers if needed

          // Add CORS headers to the request
          'Access-Control-Allow-Origin': '*', // Or specify a specific origin
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization, X-Requested-With',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        setState(() {
          categories =
              responseData.map((data) => Categories.fromJson(data)).toList();
        });
        ;
      } else {
        // Handle error, show a message, or perform other actions on failure
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error during API call: $error');
    }
  }

  void fetchProducts(String id) async {
    final String apiUrl =
        'https://loan-managment.onrender.com/products?category_id=$id';

    try {
      final dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(headers: {
          // Add any custom headers if needed
          // Add CORS headers to the request
          'Access-Control-Allow-Origin': '*', // Or specify a specific origin
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization, X-Requested-With',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        // print(response.data);

        // Parse the list of products
        List<Product> parsedProducts = [];

        for (var item in responseData) {
          parsedProducts.add(Product.fromJson(item));
        }

        setState(() {
          products = parsedProducts;
        });
      } else {
        // Handle error, show a message, or perform other actions on failure
        print('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error during API call: $error');
    }
  }

  warning(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: MediaQuery.of(context).size.width * .7,
        backgroundColor: whitefont,
        duration: Duration(seconds: 3),
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: CustomText(
              text: message,
              fontSize: 13,
              color: blackfont,
              fontWeight: FontWeight.w500),
        )));
  }

  Column affirmationsection(
      String message, List<ApplicantDetails> applicants, int i) {
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
        SizedBox(height: 30),
        Text(
          'Upload Signature, Bank Details and Other Proof here (All 3 Files Required)\n** Supported format: PDF or JPEG/PNG, (Max Size: 1MB per File)',
          style: GoogleFonts.dmSans(
              color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        SizedBox(height: 20),
        Column(
          children: [
            if (widget.myTabController.applicants[i].selectedFiles.isNotEmpty)
              Container(
                  width: MediaQuery.of(context).size.width * .9,
                  child: Wrap(
                    children: List.generate(
                      widget.myTabController.applicants[i].selectedFiles.length,
                      (index) {
                        var fileBytes = widget
                            .myTabController.applicants[i].selectedFiles[index];
                        var fileName = widget.myTabController.applicants[i]
                            .selectedFilesnames[index];
                        String fileExtension =
                            fileName.split('.').last.toLowerCase();

                        return Container(
                          margin: EdgeInsets.all(10),
                          width: 300,
                          height: 60,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display Image for image files

                                  (fileExtension != 'pdf')
                                      ? GestureDetector(
                                          onTap: () {
                                            // Open image in a new tab
                                            final blob = html.Blob(
                                                [fileBytes], 'image/*');
                                            final url = html.Url
                                                .createObjectUrlFromBlob(blob);
                                            html.window.open(url, '_blank');
                                          },
                                          child: Container(
                                            width: 300,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: blackfont),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: whitefont,
                                            ),
                                            child: Image.memory(
                                              fileBytes,
                                              width:
                                                  300, // Set the width of the image as per your requirement
                                              height:
                                                  50, // Set the height of the image as per your requirement
                                              fit: BoxFit
                                                  .cover, // Adjust this based on your image requirements
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            // Open PDF in a new tab
                                            final blob = html.Blob(
                                                [Uint8List.fromList(fileBytes)],
                                                'application/pdf');
                                            final url = html.Url
                                                .createObjectUrlFromBlob(blob);
                                            html.window.open(url, '_blank');
                                          },
                                          child: Container(
                                            width: 300,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: blackfont),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: whitefont,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Icon(
                                                  Icons.picture_as_pdf,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                      height:
                                          8.0), // Add spacing between image and text

                                  // Display file name with overflow handling
                                  Flexible(
                                    child: Text(
                                      fileName,
                                      overflow: TextOverflow.ellipsis,
                                      // Adjust the maximum lines based on your UI requirements
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 12,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    // Handle the close icon tap
                                    setState(() {
                                      widget.myTabController.applicants[i]
                                          .selectedFiles
                                          .removeAt(index);
                                      widget.myTabController.applicants[i]
                                          .selectedFilesnames
                                          .removeAt(index);
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: primary,
                                    child: Icon(
                                      Icons.close,
                                      size: 15,
                                      color: whitefont,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primary),
                      padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                    );

                    if (result != null) {
                      if (result.files.first.size > 1024 * 1024) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('The file size exceeds limit'),
                          ),
                        );
                      } else {
                        setState(() {
                          widget.myTabController.applicants[i].selectedFiles
                              .addAll(result.files.map((file) => file.bytes!));
                          widget
                              .myTabController.applicants[i].selectedFilesnames
                              .addAll(result.files.map((file) => file.name));
                        });
                      }
                    }
                  },
                  child: Text(
                    'Pick Files',
                    style: GoogleFonts.dmSans(
                        color: whitefont,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '** Supported format: PDF or JPEG/PNG, (Max Size: 1MB per File)',
                  style: GoogleFonts.dmSans(
                      color: blackfont,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //signature
            uploadtitles(
                'Signature - Only PNG/JPEG - Signature in white background'),
            Wrap(
              children: [
                if (widget.myTabController.applicants[i].signature.isNotEmpty)
                  viewFiles(widget.myTabController.applicants[i].signature,
                      widget.myTabController.applicants[i].signatureName),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            pickSignatureWidget(widget.myTabController.applicants[i].signature,
                widget.myTabController.applicants[i].signatureName, context),
            SizedBox(
              height: 20,
            ),
            //one
            uploadtitles('Payslip - 1'),
            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].paysliponeFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].paysliponeFiles,
                      widget.myTabController.applicants[i].paysliponeFileNames),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].paysliponeFiles,
              widget.myTabController.applicants[i].paysliponeFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            //two

            uploadtitles('Payslip - 2'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].paysliptwoFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].paysliptwoFiles,
                      widget.myTabController.applicants[i].paysliptwoFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].paysliptwoFiles,
              widget.myTabController.applicants[i].paysliptwoFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('Payslip - 3'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].payslipthreeFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].payslipthreeFiles,
                      widget
                          .myTabController.applicants[i].payslipthreeFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].payslipthreeFiles,
              widget.myTabController.applicants[i].payslipthreeFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('Introductory Letter from Employer'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].intodletterFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].intodletterFiles,
                      widget
                          .myTabController.applicants[i].introletterFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].intodletterFiles,
              widget.myTabController.applicants[i].introletterFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('Bank Statement'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget.myTabController.applicants[i].bankStatementFiles
                    .isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].bankStatementFiles,
                      widget.myTabController.applicants[i]
                          .bankStatementFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].bankStatementFiles,
              widget.myTabController.applicants[i].bankStatementFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('NRC'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget.myTabController.applicants[i].nrcFiles.isNotEmpty)
                  viewFiles(widget.myTabController.applicants[i].nrcFiles,
                      widget.myTabController.applicants[i].nrcFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].nrcFiles,
              widget.myTabController.applicants[i].nrcFileNames,
            ),
          ],
        )
      ],
    );
  }

  Text uploadtitles(String title) {
    return Text(
      title,
      style: GoogleFonts.dmSans(
          decoration: TextDecoration.underline,
          color: blackfont,
          fontSize: 14,
          fontWeight: FontWeight.w700),
    );
  }

  Container viewFiles(List<Uint8List> files, List<String> fileNames) {
    return Container(
        width: MediaQuery.of(context).size.width * .9,
        child: Wrap(
          children: List.generate(
            files.length,
            (index) {
              var fileBytes = files[index];
              var fileName = fileNames[index];
              String fileExtension = fileName.split('.').last.toLowerCase();

              return Container(
                margin: EdgeInsets.all(10),
                width: 300,
                height: 60,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display Image for image files

                        (fileExtension != 'pdf')
                            ? GestureDetector(
                                onTap: () {
                                  // Open image in a new tab
                                  final blob =
                                      html.Blob([fileBytes], 'image/*');
                                  final url =
                                      html.Url.createObjectUrlFromBlob(blob);
                                  html.window.open(url, '_blank');
                                },
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: blackfont),
                                    borderRadius: BorderRadius.circular(5),
                                    color: whitefont,
                                  ),
                                  child: Image.memory(
                                    fileBytes,
                                    width:
                                        300, // Set the width of the image as per your requirement
                                    height:
                                        50, // Set the height of the image as per your requirement
                                    fit: BoxFit
                                        .cover, // Adjust this based on your image requirements
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  // Open PDF in a new tab
                                  final blob = html.Blob(
                                      [Uint8List.fromList(fileBytes)],
                                      'application/pdf');
                                  final url =
                                      html.Url.createObjectUrlFromBlob(blob);
                                  html.window.open(url, '_blank');
                                },
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: blackfont),
                                    borderRadius: BorderRadius.circular(5),
                                    color: whitefont,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                            height: 8.0), // Add spacing between image and text

                        // Display file name with overflow handling
                        Flexible(
                          child: Text(
                            fileName,
                            overflow: TextOverflow.ellipsis,
                            // Adjust the maximum lines based on your UI requirements
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 12,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          // Handle the close icon tap
                          setState(() {
                            files.removeAt(index);
                            fileNames.removeAt(index);
                          });
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: primary,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: whitefont,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }

  ElevatedButton pickFilesWidget(
      List<Uint8List> selectedFiles, List<String> selectedFilesnames) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primary),
          padding: MaterialStateProperty.all(EdgeInsets.all(15))),
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        );

        if (result != null) {
          if (result.files.first.size > 1024 * 1024) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('The file size exceeds limit'),
              ),
            );
          } else {
            if (selectedFiles.length < 3) {
              setState(() {
                selectedFiles.addAll(result.files.map((file) => file.bytes!));
                selectedFilesnames
                    .addAll(result.files.map((file) => file.name));
              });
            } else {
              warning('Maximum three files, remove files to add new');
            }
          }
        }
      },
      child: Text(
        'Upload',
        style: GoogleFonts.dmSans(
            color: whitefont, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Future<void> _pickAndCropImage(
    List<Uint8List> selectedFiles,
    List<String> selectedFilesnames,
    BuildContext context,
  ) async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) async {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsDataUrl(files[0]);
        reader.onError.listen((error) => setState(() {
              // Handle error
            }));

        reader.onLoad.first.then((_) async {
          final imageBytes = reader.result as String?;
          if (imageBytes != null) {
            final croppedImage = await cropImage(imageBytes, context);
            if (croppedImage != null) {
              print('Start');

              print('End');
              if (croppedImage != null) {
                print(12);
                setState(() {
                  selectedFiles.add(croppedImage);
                  selectedFilesnames.add('Signature');
                });
                // Save the cropped image to storage
                // Implement your storage saving logic here
              }
            }
          }
        });
      }
    });
  }

  Future<Uint8List?> cropImage(String imageBytes, BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageBytes,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ],
      uiSettings: [
        WebUiSettings(
          context: context,
          enableZoom: true,
          showZoomer: true,
          mouseWheelZoom: true,
          viewPort: CroppieViewPort(height: 200, width: 500, type: 'Rectangle'),
        ),
      ],
    );
    if (croppedFile != null) {
      return croppedFile.readAsBytes();
    } else {
      return null;
    }
  }

  ElevatedButton pickSignatureWidget(
    List<Uint8List> selectedFiles,
    List<String> selectedFilesnames,
    BuildContext context,
  ) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(primary), // Use appropriate color
          padding: MaterialStateProperty.all(EdgeInsets.all(15))),
      onPressed: () async {
        if (selectedFiles.length < 1) {
          await _pickAndCropImage(selectedFiles, selectedFilesnames, context);
        } else {
          // warning('Only one file can be attached, remove to add new');
        }
      },
      child: Text(
        'Upload',
        style: GoogleFonts.dmSans(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Row loandetails(List<ApplicantDetails> applicants) {
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
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can only contain numbers';
                    }
                  }
                  return null; // Return null to indicate no error
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.insurancecost,
                labelText: 'Total Insurance cost',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can contain only digits';
                    }
                  }
                  return null; // Return null to indicate no error
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.advancepayment,
                labelText: 'Less advance payment',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can contain only digits';
                    }
                  }
                  return null; // Return null to indicate no error
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: loadndetails.loanamaountapplied,
                labelText: 'Loan amount applied for',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can contain only digits';
                    }
                  }
                  return null; // Return null to indicate no error
                },
              ),
              SizedBox(
                height: 30,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    loadndetails.tenure != null
                        ? loadndetails.tenure.toString()
                        : 'Loan Tenure',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: blackfont,
                      height: .5,
                      fontWeight: FontWeight.w500,
                    ),
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
                  value: loadndetails.tenure,
                  onChanged: (String? value) {
                    setState(() {
                      loadndetails.tenure = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: loadndetails.tenure == null
                                ? Colors.red
                                : Colors.grey,
                            width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
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
                'Share of loan applied (only asset and agriclute loan)',
                style: GoogleFonts.dmSans(
                    color: blackfont,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: applicants[0].loanapplicantname,
                labelText: 'First Applicant',
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              if (widget.myTabController.numberOfPersons > 2)
                CustomTextFormField(
                  controller: applicants[2].loanapplicantname,
                  labelText: 'Third Applicant (Agric Asset ONLY)',
                  validator: (value) {
                    return null;
                  },
                ),
              if (widget.myTabController.numberOfPersons > 2)
                SizedBox(
                  height: 30,
                ),
              CustomTextFormField(
                controller: applicants[0].loanapplicantpercentage,
                labelText: 'First Applicant Proportion of loan (%)',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    RegExp percentagePattern = RegExp(r'^\d+(\.\d+)?$');
                    if (!percentagePattern.hasMatch(value)) {
                      return 'Please enter a valid numeric value';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              if (widget.myTabController.numberOfPersons > 2)
                CustomTextFormField(
                  controller: applicants[2].loanapplicantpercentage,
                  labelText: 'Third Applicant Proportion of loan (%))',
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      RegExp percentagePattern = RegExp(r'^\d+(\.\d+)?$');
                      if (!percentagePattern.hasMatch(value)) {
                        return 'Please enter a valid numeric value';
                      }
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
                '',
                style: GoogleFonts.dmSans(
                    color: blackfont,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              if (widget.myTabController.numberOfPersons > 1)
                CustomTextFormField(
                  controller: applicants[1].loanapplicantname,
                  labelText: 'Second Applicant',
                  validator: (value) {
                    return null;
                  },
                ),
              SizedBox(
                height: 30,
              ),
              if (widget.myTabController.numberOfPersons > 3)
                CustomTextFormField(
                  controller: applicants[3].loanapplicantname,
                  labelText: 'Fourth Applicant (Agric Asset ONLY)',
                  validator: (value) {
                    return null;
                  },
                ),
              if (widget.myTabController.numberOfPersons > 3)
                SizedBox(
                  height: 30,
                ),
              if (widget.myTabController.numberOfPersons > 1)
                CustomTextFormField(
                  controller: applicants[1].loanapplicantpercentage,
                  labelText: 'Second Applicant Proportion of loan (%)',
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      RegExp percentagePattern = RegExp(r'^\d+(\.\d+)?$');
                      if (!percentagePattern.hasMatch(value)) {
                        return 'Please enter a valid numeric value';
                      }
                    }
                    return null;
                  },
                ),
              SizedBox(
                height: 30,
              ),
              if (widget.myTabController.numberOfPersons > 3)
                CustomTextFormField(
                  controller: applicants[3].loanapplicantpercentage,
                  labelText: 'Fourth Applicant Proportion of loan (%)',
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      RegExp percentagePattern = RegExp(r'^\d+(\.\d+)?$');
                      if (!percentagePattern.hasMatch(value)) {
                        return 'Please enter a valid numeric value';
                      }
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
        Row(
          children: [
            SizedBox(
              width: 400,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<Categories>(
                  isExpanded: true,
                  hint: Text(
                    categoryName ?? 'Choose Category',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: blackfont,
                      height: .5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name,
                        style: GoogleFonts.dmSans(color: blackfont),
                      ),
                    );
                  }).toList(),
                  value: categoryName != null
                      ? categories.firstWhere(
                          (element) => element.name == categoryName,
                          orElse: () => categories.first,
                        )
                      : null,
                  onChanged: (Categories? value) {
                    setState(() {
                      loadndetails.loancategory = value!.name;
                      categoryName = value.name;
                      categoryId = value.id.toString();
                      loadndetails.chosenProductPrice.clear();
                      loadndetails.totalcost = 0;
                      loadndetails.costofasset.text =
                          loadndetails.totalcost.toString();
                      loadndetails.chosenProductIds = [];
                      loadndetails.chosenProductNames = [];
                      loadndetails.quantity = [];
                      fetchProducts(categoryId!);
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: categoryName == null ? Colors.red : Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            if (products.isNotEmpty)
              SizedBox(
                width: 400,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<Product>(
                    isExpanded: true,
                    hint: Text(
                      prodcutname ?? 'Choose Product',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: blackfont,
                        height: .5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: products.map((product) {
                      return DropdownMenuItem(
                        value: product,
                        child: Text(
                          product.name,
                          style: GoogleFonts.dmSans(color: blackfont),
                        ),
                      );
                    }).toList(),
                    value: prodcutname != null
                        ? products.firstWhere(
                            (element) => element.name == prodcutname,
                            orElse: () => products.first,
                          )
                        : null,
                    onChanged: (Product? value) {
                      setState(() {
                        if (!loadndetails.chosenProductIds
                            .contains(value!.id)) {
                          loadndetails.chosenProductIds.add(value.id);
                          loadndetails.chosenProductNames.add(value.name);
                          loadndetails.quantity.add(1);
                          loadndetails.chosenProductPrice.add(value.price);
                          loadndetails.totalcost =
                              loadndetails.totalcost! + value.price;
                          loadndetails.costofasset.text =
                              loadndetails.totalcost.toString();
                        }
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              categoryName == null ? Colors.red : Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        if (loadndetails.chosenProductIds.isNotEmpty)
          for (int i = 0; i < loadndetails.chosenProductIds.length; i++)
            Column(
              children: [
                Row(
                  children: [
                    if (i < loadndetails.chosenProductNames.length)
                      Text(
                        loadndetails.chosenProductNames[i],
                        style: GoogleFonts.dmSans(
                          color: blackfont,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    SizedBox(width: 50),
                    if (i < loadndetails.quantity.length)
                      CircleAvatar(
                        backgroundColor: primary,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (loadndetails.quantity[i] > 1) {
                                loadndetails.quantity[i]--;
                                loadndetails.totalcost =
                                    loadndetails.totalcost! -
                                        loadndetails.chosenProductPrice[i];
                                loadndetails.costofasset.text =
                                    loadndetails.totalcost.toString();
                              }
                            });
                          },
                          icon: Icon(Icons.minimize_sharp),
                        ),
                      ),
                    SizedBox(width: 20),
                    if (i < loadndetails.quantity.length)
                      Text(
                        loadndetails.quantity[i].toString(),
                        style: GoogleFonts.dmSans(
                          color: blackfont,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    SizedBox(width: 20),
                    if (i < loadndetails.quantity.length)
                      CircleAvatar(
                        backgroundColor: primary,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (loadndetails.quantity[i] < 10) {
                                loadndetails.quantity[i]++;
                                print(12);
                                print(loadndetails.chosenProductPrice[i]);
                                loadndetails.totalcost =
                                    loadndetails.totalcost! +
                                        loadndetails.chosenProductPrice[i];
                                loadndetails.costofasset.text =
                                    loadndetails.totalcost.toString();
                              }
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          double approxcost =
                              loadndetails.chosenProductPrice[i] *
                                  loadndetails.quantity[i];

                          loadndetails.costofasset.text =
                              (loadndetails.totalcost! - approxcost).toString();
                          loadndetails.chosenProductNames.removeAt(i);
                          loadndetails.quantity.removeAt(i);
                          loadndetails.chosenProductIds.removeAt(i);
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
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
