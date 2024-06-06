// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:netone_enquiry_management/constants/colors.dart';
import 'package:netone_enquiry_management/constants/text.dart';
import 'package:provider/provider.dart';
import 'package:netone_enquiry_management/main.dart';

import 'package:http_parser/http_parser.dart';

class SectionFour extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  SectionFour(this.myTabController, this._tabController);

  @override
  State<SectionFour> createState() => _SectionFourState();
}

class _SectionFourState extends State<SectionFour>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool isloadiing = false;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.myTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTabController = Provider.of<MyTabController>(context);
    final numberOfPersons = widget.myTabController.numberOfPersons;
    double fontSizeFactor = 1.0;
    double widthFactor = 1.0;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 600) {
        fontSizeFactor = .7;
        widthFactor = .7;
      }
      return Scaffold(
        body: isloadiing == false
            ? Padding(
                padding: EdgeInsets.all(20 * widthFactor),
                child: ListView(
                  children: [
                    CustomText(
                      text: 'Part 1 ',
                      color: blackfont,
                      fontSize: 16 * fontSizeFactor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 5 * widthFactor,
                    ),
                    CustomText(
                      text: 'Applicant Details',
                      color: primary,
                      fontSize: 16 * fontSizeFactor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20 * widthFactor,
                    ),
                    applicantDetails(
                        myTabController, 0, widthFactor, fontSizeFactor),

                    if (numberOfPersons > 1)
                      applicantDetails(
                          myTabController, 1, widthFactor, fontSizeFactor),

                    if (numberOfPersons > 2)
                      applicantDetails(
                          myTabController, 2, widthFactor, fontSizeFactor),

                    if (numberOfPersons > 3)
                      applicantDetails(
                          myTabController, 3, widthFactor, fontSizeFactor),

                    // Display other details as needed

                    // Display details from Section Two
                    CustomText(
                      text: 'Part 2',
                      color: blackfont,
                      fontSize: 16 * fontSizeFactor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 5 * widthFactor,
                    ),
                    CustomText(
                      text: 'Employment Details',
                      color: primary,
                      fontSize: 16 * fontSizeFactor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20 * widthFactor,
                    ),
                    employmentDetals(
                        myTabController, 0, widthFactor, fontSizeFactor),
                    if (numberOfPersons > 1)
                      employmentDetals(
                          myTabController, 1, widthFactor, fontSizeFactor),
                    if (numberOfPersons > 2)
                      employmentDetals(
                          myTabController, 2, widthFactor, fontSizeFactor),
                    if (numberOfPersons > 3)
                      employmentDetals(
                          myTabController, 3, widthFactor, fontSizeFactor),
                    CustomText(
                      text: 'Part 3',
                      color: blackfont,
                      fontSize: 16 * fontSizeFactor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 5 * widthFactor,
                    ),
                    CustomText(
                      text: 'Loan Details',
                      color: primary,
                      fontSize: 16 * fontSizeFactor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20 * widthFactor,
                    ),
                    loanDetails(myTabController, widthFactor, fontSizeFactor),
                    SizedBox(
                      height: 20 * widthFactor,
                    ),
                    CustomText(
                      text: 'Bank Details - Applicant 1',
                      color: primary,
                      fontSize: 16 * fontSizeFactor,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20 * widthFactor,
                    ),
                    bankdetails(myTabController, widthFactor, fontSizeFactor),
                    SizedBox(
                      height: 20 * widthFactor,
                    ),
                    fontSizeFactor == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .48,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                buttondarkbg),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(15))),
                                    onPressed: () {
                                      //printApplicantDetails();

                                      widget._tabController.animateTo(
                                          widget._tabController.index - 1);

                                      //widget.myTabController.updateNumberOfPersons(numberOfPersons);
                                      //  DefaultTabController.of(context)?.animateTo(1);
                                      // if (_formKey.currentState!.validate()) {
                                      //   // Form is valid, move to the next section

                                      // }
                                    },
                                    child: CustomText(
                                      text: 'Previous',
                                      color: whitefont,
                                      fontSize: 16 * fontSizeFactor,
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
                                      // submitsForm(widget.myTabController);
                                      sendLoanRequest(
                                          widget
                                              .myTabController.numberOfPersons,
                                          myTabController);
                                    },
                                    child: CustomText(
                                      text: 'Submit',
                                      color: whitefont,
                                      fontSize: 16 * fontSizeFactor,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .9,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                buttondarkbg),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(15))),
                                    onPressed: () {
                                      //printApplicantDetails();

                                      widget._tabController.animateTo(
                                          widget._tabController.index - 1);

                                      //widget.myTabController.updateNumberOfPersons(numberOfPersons);
                                      //  DefaultTabController.of(context)?.animateTo(1);
                                      // if (_formKey.currentState!.validate()) {
                                      //   // Form is valid, move to the next section

                                      // }
                                    },
                                    child: CustomText(
                                      text: 'Previous',
                                      color: whitefont,
                                      fontSize: 16 * fontSizeFactor,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              SizedBox(
                                height: 10 * widthFactor,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .9,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(primary),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(15))),
                                    onPressed: () {
                                      // submitsForm(widget.myTabController);
                                      sendLoanRequest(
                                          widget
                                              .myTabController.numberOfPersons,
                                          myTabController);
                                    },
                                    child: CustomText(
                                      text: 'Submit',
                                      color: whitefont,
                                      fontSize: 16 * fontSizeFactor,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ],
                          ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(color: primary),
              ),
      );
    });
  }

  Container applicantDetails(MyTabController myTabController, int i,
      double widthFactor, double fontSizeFactor) {
    return Container(
      margin: EdgeInsets.only(bottom: 30 * widthFactor),
      padding: EdgeInsets.fromLTRB(20 * widthFactor, 25 * widthFactor,
          20 * widthFactor, 25 * widthFactor),
      decoration: BoxDecoration(
          color: Color.fromARGB(80, 252, 227, 194),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Applicant ${i + 1}',
              fontSize: 18 * fontSizeFactor,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Surname: ${myTabController.applicants[i].surnameController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Middle Name: ${myTabController.applicants[i].middleNameController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'First Name: ${myTabController.applicants[i].firstNameController.text}',
                )
              ],
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text: myTabController.applicants[i].gender == null
                      ? 'Gender:'
                      : 'Gender: ${myTabController.applicants[i].gender}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Date of Birth: ${myTabController.applicants[i].dobController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'NRC Number: ${myTabController.applicants[i].nrcController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Telephone: ${myTabController.applicants[i].telephoneController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Mobile: ${myTabController.applicants[i].mobileController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Email: ${myTabController.applicants[i].emailController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Driving Licnese Number: ${myTabController.applicants[i].licenseNumberController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Licnese Exp Date: ${myTabController.applicants[i].licenseExpiryController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Resedential Address: ${myTabController.applicants[i].residentialAddressController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text: myTabController.applicants[i].ownership == null
                      ? 'Ownership:'
                      : 'Ownership: ${myTabController.applicants[i].ownership}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'How long this place: ${myTabController.applicants[i].howlongthisplaceController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Postal Address: ${myTabController.applicants[i].postalAddressController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text: myTabController.applicants[i].townController == null
                      ? 'Town:'
                      : 'Town: ${myTabController.applicants[i].townController}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text: myTabController.applicants[i].provinceController == null
                      ? 'Province'
                      : 'Province: ${myTabController.applicants[i].provinceController}',
                ),
              ],
            ),
            if (widget.myTabController.applicants[i].selectedFiles.isNotEmpty)
              Container(
                  width: MediaQuery.of(context).size.width * .7,
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
                          child: Column(
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
                                            html.Url.createObjectUrlFromBlob(
                                                blob);
                                        html.window.open(url, '_blank');
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: blackfont),
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
                                        final url =
                                            html.Url.createObjectUrlFromBlob(
                                                blob);
                                        html.window.open(url, '_blank');
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: blackfont),
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
                        );
                      },
                    ),
                  )),
            SizedBox(
              width: 30,
            ),
            if (widget.myTabController.applicants[i].signature.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomText(
                    text: 'Signature',
                    fontSizeFactor: fontSizeFactor,
                  ),
                  attachedDocs(
                      myTabController,
                      i,
                      widget.myTabController.applicants[i].signature,
                      widget.myTabController.applicants[i].signatureName,
                      fontSizeFactor,
                      widthFactor),
                ],
              ),
            if (widget.myTabController.applicants[i].paysliponeFiles.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomText(
                    text: 'Payslip - 1',
                    fontSizeFactor: fontSizeFactor,
                  ),
                  attachedDocs(
                      myTabController,
                      i,
                      widget.myTabController.applicants[i].paysliponeFiles,
                      widget.myTabController.applicants[i].paysliponeFileNames,
                      fontSizeFactor,
                      widthFactor),
                ],
              ),
            if (widget.myTabController.applicants[i].paysliptwoFiles.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomText(
                    text: 'Payslip - 2',
                    fontSizeFactor: fontSizeFactor,
                  ),
                  attachedDocs(
                      myTabController,
                      i,
                      widget.myTabController.applicants[i].paysliptwoFiles,
                      widget.myTabController.applicants[i].paysliptwoFileNames,
                      fontSizeFactor,
                      widthFactor),
                ],
              ),
            if (widget
                .myTabController.applicants[i].payslipthreeFiles.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomText(
                    text: 'Payslip - 3',
                    fontSizeFactor: fontSizeFactor,
                  ),
                  attachedDocs(
                      myTabController,
                      i,
                      widget.myTabController.applicants[i].payslipthreeFiles,
                      widget
                          .myTabController.applicants[i].payslipthreeFileNames,
                      fontSizeFactor,
                      widthFactor),
                ],
              ),
            if (widget
                .myTabController.applicants[i].intodletterFiles.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomText(
                    text: 'Introductory Letter from Employer',
                    fontSizeFactor: fontSizeFactor,
                  ),
                  attachedDocs(
                      myTabController,
                      i,
                      widget.myTabController.applicants[i].intodletterFiles,
                      widget.myTabController.applicants[i].introletterFileNames,
                      fontSizeFactor,
                      widthFactor),
                ],
              ),
            if (widget
                .myTabController.applicants[i].bankStatementFiles.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomText(
                    text: 'Bank Statement',
                    fontSizeFactor: fontSizeFactor,
                  ),
                  attachedDocs(
                      myTabController,
                      i,
                      widget.myTabController.applicants[i].bankStatementFiles,
                      widget
                          .myTabController.applicants[i].bankStatementFileNames,
                      fontSizeFactor,
                      widthFactor),
                ],
              ),
            if (widget.myTabController.applicants[i].nrcFiles.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomText(
                    text: 'NRC',
                    fontSizeFactor: fontSizeFactor,
                  ),
                  attachedDocs(
                      myTabController,
                      i,
                      widget.myTabController.applicants[i].nrcFiles,
                      widget.myTabController.applicants[i].nrcFileNames,
                      fontSizeFactor,
                      widthFactor),
                ],
              ),
          ]),
    );
  }

  Container employmentDetals(MyTabController myTabController, int i,
      double widthFactor, double fontSizeFactor) {
    return Container(
        margin: EdgeInsets.only(bottom: 30 * widthFactor),
        padding: EdgeInsets.fromLTRB(20 * widthFactor, 25 * widthFactor,
            20 * widthFactor, 25 * widthFactor),
        decoration: BoxDecoration(
            color: Color.fromARGB(80, 242, 254, 187),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                fontSize: 16 * fontSizeFactor,
                text: 'Employment Details Applicant: ${i + 1}',
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 20 * widthFactor,
              ),
              Wrap(
                children: [
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text:
                        'Job Title: ${myTabController.employmentDetailsList[i].jobTitleController.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text:
                        'Ministry: ${myTabController.employmentDetailsList[i].ministryController.text}',
                  ),
                ],
              ),
              SizedBox(
                height: 20 * widthFactor,
              ),
              Wrap(
                children: [
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text:
                        'Physical Address: ${myTabController.employmentDetailsList[i].physicalAddressControlleremployment.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text:
                        'Postal Address: ${myTabController.employmentDetailsList[i].postalAddressControllerEmployment.text}',
                  ),
                ],
              ),
              SizedBox(
                height: 20 * widthFactor,
              ),
              Wrap(
                children: [
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text: myTabController
                                .employmentDetailsList[i].townController ==
                            null
                        ? 'Town:'
                        : 'Town: ${myTabController.employmentDetailsList[i].townController}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text: myTabController
                                .employmentDetailsList[i].provinceController ==
                            null
                        ? 'Province:'
                        : 'Province: ${myTabController.employmentDetailsList[i].provinceController}',
                  ),
                ],
              ),
              SizedBox(
                height: 20 * widthFactor,
              ),
              Wrap(
                children: [
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text:
                        'Gross Salary: ${myTabController.employmentDetailsList[i].grossSalaryController.text}',
                  ),
                  SizedBox(
                    width: 30 * widthFactor,
                  ),
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text: myTabController.employmentDetailsList[i]
                                .currentNetSalaryController.text ==
                            null
                        ? 'Current Net Salary:'
                        : 'Current Net Salary: ${myTabController.employmentDetailsList[i].currentNetSalaryController.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text: myTabController.employmentDetailsList[i]
                                .salaryScaleController ==
                            null
                        ? 'Salary Scale:'
                        : 'Salary Scale: ${myTabController.employmentDetailsList[i].salaryScaleController}',
                  ),
                ],
              ),
              SizedBox(
                height: 20 * widthFactor,
              ),
              Wrap(
                children: [
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text: myTabController.employmentDetailsList[i]
                                .preferredYearOfRetirementController ==
                            null
                        ? 'Preferred Year of Retirement'
                        : 'Preferred Year of Retirement: ${myTabController.employmentDetailsList[i].preferredYearOfRetirementController}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text:
                        'Employee Number: ${myTabController.employmentDetailsList[i].employeeNumberController.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text: myTabController.employmentDetailsList[i]
                                .yearsInEmploymentController ==
                            null
                        ? 'Years in Employemnt'
                        : 'Years in Employemnt: ${myTabController.employmentDetailsList[i].yearsInEmploymentController}',
                  ),
                ],
              ),
              SizedBox(
                height: 20 * widthFactor,
              ),
              Wrap(
                children: [
                  CustomText(
                    fontSize: 15 * fontSizeFactor,
                    text:
                        'Employemnt Type: ${myTabController.employmentDetailsList[i].employmentType}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  if (myTabController.employmentDetailsList[i].employmentType ==
                      'contract')
                    CustomText(
                      fontSize: 15 * fontSizeFactor,
                      text:
                          'Expiry Date: ${myTabController.employmentDetailsList[i].expiryDateController.text}',
                    ),
                ],
              )
            ]));
  }

  Container loanDetails(MyTabController myTabController, double widthFactor,
      double fontSizeFactor) {
    return Container(
      margin: EdgeInsets.only(bottom: 30 * widthFactor),
      padding: EdgeInsets.fromLTRB(20 * widthFactor, 25 * widthFactor,
          20 * widthFactor, 25 * widthFactor),
      decoration: BoxDecoration(
          color: Color.fromARGB(80, 199, 193, 185),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            fontSize: 15 * fontSizeFactor,
            text: myTabController.loanDetails.loancategory == null
                ? 'Loan Product Applied for:'
                : 'Loan  Applied for: ${myTabController.loanDetails.loancategory}',
          ),
          SizedBox(
            height: 20 * widthFactor,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text: 'Products',
              ),
              for (int i = 0;
                  i < myTabController.loanDetails.chosenProductIds.length;
                  i++)
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      '${myTabController.loanDetails.chosenProductNames[i]}(${myTabController.loanDetails.quantity[i]})',
                ),
            ],
          ),
          SizedBox(
            height: 20 * widthFactor,
          ),
          CustomText(
            fontSize: 15 * fontSizeFactor,
            text:
                'Description: ${myTabController.loanDetails.descriptionController.text}',
          ),
          SizedBox(
            height: 20 * widthFactor,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text:
                    'Total cost of asset: ${myTabController.loanDetails.costofasset.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text:
                    'Total Insurance Cost: ${myTabController.loanDetails.insurancecost.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text:
                    'Less Advance Payment: ${myTabController.loanDetails.advancepayment.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text:
                    'Loan Amount Applied for: ${myTabController.loanDetails.loanamaountapplied.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text: myTabController.loanDetails.tenure == null
                    ? 'Tenure:'
                    : 'Tenure: ${myTabController.loanDetails.tenure}',
              ),
            ],
          ),
          SizedBox(
            height: 20 * widthFactor,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text:
                    'First Applicant: ${myTabController.applicants[0].loanapplicantname.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15 * fontSizeFactor,
                text:
                    'First Applicant Loan Propotion: ${myTabController.applicants[0].loanapplicantpercentage.text}',
              ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 1)
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Second Applicant: ${myTabController.applicants[1].loanapplicantname.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 1)
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Second Applicant Loan Propotion: ${myTabController.applicants[1].loanapplicantpercentage.text}',
                ),
            ],
          ),
          SizedBox(
            height: 20 * widthFactor,
          ),
          Wrap(
            children: [
              if (myTabController.numberOfPersons > 2)
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Third Applicant: ${myTabController.applicants[2].loanapplicantname.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 2)
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Third Applicant Loan Propotion: ${myTabController.applicants[2].loanapplicantpercentage.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 3)
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Fourth Applicant: ${myTabController.applicants[3].loanapplicantname.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 3)
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Fourth Applicant Loan Propotion: ${myTabController.applicants[3].loanapplicantpercentage.text}',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Container bankdetails(MyTabController myTabController, double widthFactor,
      double fontSizeFactor) {
    return Container(
      margin: EdgeInsets.only(bottom: 30 * widthFactor),
      padding: EdgeInsets.fromLTRB(20 * widthFactor, 25 * widthFactor,
          20 * widthFactor, 25 * widthFactor),
      decoration: BoxDecoration(
          color: Color.fromARGB(80, 199, 193, 185),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Bank Name: ${myTabController.loanDetails.bankname.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Branch Name: ${myTabController.loanDetails.branchname.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Sortcode: ${myTabController.loanDetails.sortcode.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15 * fontSizeFactor,
                  text:
                      'Branch Acc No: ${myTabController.loanDetails.accountnumber.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20 * widthFactor,
            ),
            CustomText(
              fontSize: 15 * fontSizeFactor,
              text:
                  'Bank Name and Full Address: ${myTabController.loanDetails.nameandbankaddress.text}',
            ),
          ]),
    );
  }

  Container attachedDocs(
      MyTabController myTabController,
      int i,
      List<Uint8List> files,
      List<String> filenames,
      double fontsizefactor,
      double widthfactor) {
    print(files.length);
    return Container(
        width: MediaQuery.of(context).size.width * .7 * widthfactor,
        child: Wrap(
          children: List.generate(
            files.length,
            (index) {
              var fileBytes = files[index];

              var fileName = filenames[index];
              String fileExtension = fileName.split('.').last.toLowerCase();

              return Container(
                margin: EdgeInsets.all(10),
                width: 300 * widthfactor,
                height: 60 * widthfactor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Image for image files

                    (fileExtension != 'pdf')
                        ? GestureDetector(
                            onTap: () {
                              // Open image in a new tab
                              final blob = html.Blob([fileBytes], 'image/*');
                              final url =
                                  html.Url.createObjectUrlFromBlob(blob);
                              html.window.open(url, '_blank');
                            },
                            child: Container(
                              width: 300 * widthfactor,
                              height: 50 * widthfactor,
                              decoration: BoxDecoration(
                                border: Border.all(color: blackfont),
                                borderRadius: BorderRadius.circular(5),
                                color: whitefont,
                              ),
                              child: Image.memory(
                                fileBytes,
                                width: 300 *
                                    widthfactor, // Set the width of the image as per your requirement
                                height: 50 *
                                    widthfactor, // Set the height of the image as per your requirement
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
                              width: 300 * widthfactor,
                              height: 50 * widthfactor,
                              decoration: BoxDecoration(
                                border: Border.all(color: blackfont),
                                borderRadius: BorderRadius.circular(5),
                                color: whitefont,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20 * widthfactor,
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
                        height: 8.0 *
                            widthfactor), // Add spacing between image and text

                    // Display file name with overflow handling
                    Flexible(
                      child: Text(
                        fileName,
                        overflow: TextOverflow.ellipsis,
                        // Adjust the maximum lines based on your UI requirements
                        style: GoogleFonts.dmSans(
                          fontSize: 14 * fontsizefactor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  void sendLoanRequest(
      int numberOfApplicants, MyTabController myTabController) async {
    setState(() {
      isloadiing = true;
    });
    final String apiUrl = 'http://41.77.146.116:5434/loan_requests';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add JSON data as form fields
      request.fields['loan_request[description]'] =
          myTabController.loanDetails.descriptionController.text ?? '';
      request.fields['loan_request[cost_of_asset]'] =
          myTabController.loanDetails.costofasset.text;
      request.fields['loan_request[insurance_cost]'] =
          myTabController.loanDetails.insurancecost.text ?? '';
      request.fields['loan_request[advance_payment]'] =
          myTabController.loanDetails.advancepayment.text ?? '';
      request.fields['loan_request[loan_amount]'] =
          myTabController.loanDetails.loanamaountapplied.text ?? '';
      request.fields['loan_request[loan_tenure]'] =
          myTabController.loanDetails.tenure.toString();

      //bank details
      request.fields['loan_request[bank_name]'] =
          myTabController.loanDetails.bankname.text;
      request.fields['loan_request[bank_account_number]'] =
          myTabController.loanDetails.accountnumber.text;
      request.fields['loan_request[bank_branch_name]'] =
          myTabController.loanDetails.branchname.text;
      request.fields['loan_request[bank_sort_code]'] =
          myTabController.loanDetails.sortcode.text;
      request.fields['loan_request[bank_name_and_full_address]'] =
          myTabController.loanDetails.nameandbankaddress.text;

      for (int i = 0;
          i < myTabController.loanDetails.chosenProductIds.length;
          i++) {
        request.fields[
                'loan_request[loan_request_products_attributes][$i][product_id]'] =
            myTabController.loanDetails.chosenProductIds[i].toString();
        request.fields[
                'loan_request[loan_request_products_attributes][$i][quantity]'] =
            myTabController.loanDetails.quantity[i].toString();
      }

      for (int i = 0; i < numberOfApplicants; i++) {
        request.fields['loan_request[applicants_attributes][$i][surname]'] =
            myTabController.applicants[i].surnameController.text;

        request.fields['loan_request[applicants_attributes][$i][first_name]'] =
            myTabController.applicants[i].firstNameController.text;

        request.fields['loan_request[applicants_attributes][$i][middle_name]'] =
            myTabController.applicants[i].middleNameController.text ?? '';

        request.fields['loan_request[applicants_attributes][$i][email]'] =
            myTabController.applicants[i].emailController.text;
        request.fields['loan_request[applicants_attributes][$i][dob]'] =
            myTabController.applicants[i].dobController.text;
        request.fields['loan_request[applicants_attributes][$i][nrc]'] =
            myTabController.applicants[i].nrcController.text;
        request.fields['loan_request[applicants_attributes][$i][telephone]'] =
            myTabController.applicants[i].telephoneController.text ?? '';
        request.fields['loan_request[applicants_attributes][$i][mobile]'] =
            myTabController.applicants[i].mobileController.text;

        request.fields[
                'loan_request[applicants_attributes][$i][license_number]'] =
            myTabController.applicants[i].licenseNumberController.text ?? '';

        request.fields[
                'loan_request[applicants_attributes][$i][license_expiry]'] =
            myTabController.applicants[i].licenseExpiryController.text ?? '';

        request.fields[
                'loan_request[applicants_attributes][$i][residential_address]'] =
            myTabController.applicants[i].residentialAddressController.text;

        request.fields[
                'loan_request[applicants_attributes][$i][postal_address]'] =
            myTabController.applicants[i].postalAddressController.text ?? '';

        request.fields['loan_request[applicants_attributes][$i][province]'] =
            myTabController.applicants[i].provinceController!;

        request.fields['loan_request[applicants_attributes][$i][town]'] =
            myTabController.applicants[i].townController!;

        request.fields['loan_request[applicants_attributes][$i][gender]'] =
            myTabController.applicants[i].gender!;

        request.fields['loan_request[applicants_attributes][$i][ownership]'] =
            myTabController.applicants[i].ownership == null ||
                    myTabController.applicants[i].ownership == 'null'
                ? ''
                : myTabController.applicants[i].ownership!;

        request.fields[
                'loan_request[applicants_attributes][$i][ownership_how_long]'] =
            myTabController.applicants[i].howlongthisplaceController.text ?? '';

        request.fields[
                'loan_request[applicants_attributes][$i][loan_share_name]'] =
            myTabController.applicants[i].loanapplicantname.text ?? '';

        request.fields[
                'loan_request[applicants_attributes][$i][loan_share_percent]'] =
            myTabController.applicants[i].loanapplicantpercentage.text ?? '';

        // Add other applicant details as needed
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][name]'] =
            myTabController.employmentDetailsList[i].nameController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][other_names]'] =
            myTabController.employmentDetailsList[i].otherNamesController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][physical_address]'] =
            myTabController.employmentDetailsList[i]
                    .physicalAddressControllernextofkin.text ??
                '';
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][postal_address]'] =
            myTabController.employmentDetailsList[i]
                    .postalAddressControllerforKline.text ??
                '';

        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][phone_number]'] =
            myTabController.employmentDetailsList[i].cellNumberController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][email]'] =
            myTabController
                    .employmentDetailsList[i].emailAddressController.text ??
                '';

        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][job_title]'] =
            myTabController.employmentDetailsList[i].jobTitleController.text ??
                '';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][ministry]'] =
            myTabController.employmentDetailsList[i].ministryController.text ??
                '';

        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][physical_address]'] =
            myTabController.employmentDetailsList[i]
                    .physicalAddressControlleremployment.text ??
                '';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][postal_address]'] =
            myTabController.employmentDetailsList[i]
                .postalAddressControllerEmployment.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][town]'] =
            myTabController.employmentDetailsList[i].townController!;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][province]'] =
            myTabController.employmentDetailsList[i].provinceController!;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][gross_salary]'] =
            myTabController.employmentDetailsList[i].grossSalaryController.text;

        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][net_salary]'] =
            myTabController.employmentDetailsList[i].netSalaryController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][salary_scale]'] =
            myTabController.employmentDetailsList[i].salaryScaleController ==
                        null ||
                    myTabController
                            .employmentDetailsList[i].salaryScaleController ==
                        'null'
                ? ''
                : myTabController
                    .employmentDetailsList[i].salaryScaleController!;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][retirement_year]'] =
            myTabController
                .employmentDetailsList[i].retirementYearController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_number]'] =
            myTabController
                .employmentDetailsList[i].employeeNumberController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][years_of_service]'] =
            myTabController.employmentDetailsList[i]
                            .yearsInEmploymentController ==
                        null ||
                    myTabController.employmentDetailsList[i]
                            .yearsInEmploymentController ==
                        'null'
                ? ''
                : myTabController
                    .employmentDetailsList[i].yearsInEmploymentController!;

        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employment_type]'] =
            myTabController.employmentDetailsList[i].employmentType!;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][expiry_date]'] =
            myTabController
                    .employmentDetailsList[i].expiryDateController.text ??
                '';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_email]'] =
            myTabController
                    .employmentDetailsList[i].emailAddressController.text ??
                '';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_name]'] =
            myTabController.employmentDetailsList[i].nameController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_other_names]'] =
            myTabController.employmentDetailsList[i].otherNamesController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_cell_number]'] =
            myTabController.employmentDetailsList[i].cellNumberController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][current_net_salary]'] =
            myTabController.employmentDetailsList[i].netSalaryController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][temp_expiry_date]'] =
            myTabController
                    .employmentDetailsList[i].expiryDateController.text ??
                '';

        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][preferred_retirement_year]'] =
            myTabController
                .employmentDetailsList[i].preferredYearOfRetirementController!;

        // Add files as form fields
        //  print(widget.myTabController.applicants[i].selectedFiles.length);
/*
        for (var file in widget.myTabController.applicants[i].selectedFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][documents][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }*/

        //payslip1
        for (var file in widget.myTabController.applicants[i].paysliponeFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][payslip_1][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }

        //payslip2
        for (var file in widget.myTabController.applicants[i].paysliptwoFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][payslip_2][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }

        //payslip3
        for (var file
            in widget.myTabController.applicants[i].payslipthreeFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][payslip_3][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }

        //intro_letter print(1);
        for (var file
            in widget.myTabController.applicants[i].intodletterFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][intro_letter][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }

        //bank_statement
        for (var file
            in widget.myTabController.applicants[i].bankStatementFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][bank_statement][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }

        //nrc
        for (var file in widget.myTabController.applicants[i].nrcFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][nrc_copy][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }

        var file = widget.myTabController.applicants[i].signature[0];
        request.files.add(http.MultipartFile(
          'loan_request[applicants_attributes][$i][signature]',
          http.ByteStream.fromBytes(file),
          file.length,
          filename: 'signature.jpg', // Provide a filename here
          contentType: MediaType('application', 'octet-stream'),
        ));
      }
      // print(request.fields);
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Request was successful
        print('Form submitted successfully');
        setState(() {
          isloadiing = false;
        });
        warning('Form Submitted');
        Future.delayed(Duration(seconds: 3), () {
          html.window.location.reload();
        });
        //  clearAllFields();
      } else {
        // Request failed
        print('Form submission failed with status: ${response.statusCode}');
        setState(() {
          isloadiing = false;
        });
        warning('Error: Cannot Submit Form');
      }
    } catch (e) {
      print("Error: $e");
      warning('Error: Cannot Submit Form');
    }
  }

  // Future<void> submitsForm(MyTabController myTabController) async {
  //   setState(() {
  //     isloadiing = true;
  //   });

  //   // Prepare the API endpoint URL
  //   final apiUrl = 'https://loan-managment.onrender.com/loan_requests';

  //   // Prepare the headers (bearer token)
  //   final headers = {'Authorization': 'Bearer your_bearer_token_here'};

  //   // Create a multipart request
  //   var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
  //     ..headers.addAll(headers);

  //   // Add form fields
  //   request.fields['loan_request[description]'] =
  //       myTabController.loanDetails.descriptionController.text;
  //   request.fields['loan_request[cost_of_asset]'] =
  //       myTabController.loanDetails.costofasset.text;
  //   request.fields['loan_request[insurance_cost]'] =
  //       myTabController.loanDetails.insurancecost.text;
  //   request.fields['loan_request[advance_payment]'] =
  //       myTabController.loanDetails.advancepayment.text;
  //   request.fields['loan_request[loan_amount]'] =
  //       myTabController.loanDetails.loanamaountapplied.text;
  //   request.fields['loan_request[loan_tenure]'] =
  //       myTabController.loanDetails.tenure!;
  //   request.fields['loan_request[product_id]'] =
  //       myTabController.loanDetails.selectedLoanOption.toString();

  //   // Add form fields for 'applicants_attributes'
  //   request.fields['loan_request[applicants_attributes]'] = jsonEncode(
  //       List.generate(widget.myTabController.numberOfPersons, (index) {
  //     var applicant = myTabController.applicants[index];
  //     var employmentdetails = myTabController.employmentDetailsList[index];
  //     // Extract file paths from PlatformFile objects
  //     // List<String> documentPaths =
  //     //     applicant.selectedFiles.map((file) => file.path!).toList();

  //     return {
  //       'surname': applicant.surnameController.text,
  //       'first_name': applicant.firstNameController.text,
  //       'middle_name': applicant.middleNameController.text,
  //       'email': applicant.emailController.text,
  //       'dob': applicant.dobController.text,
  //       'nrc': applicant.nrcController.text,
  //       'telephone': applicant.telephoneController.text,
  //       'mobile': applicant.mobileController.text,
  //       'license_number': applicant.licenseNumberController.text,
  //       'license_expiry': applicant.licenseExpiryController.text,
  //       'residential_address': applicant.residentialAddressController.text,
  //       'postal_address': applicant.postalAddressController.text,
  //       'province': applicant.provinceController,
  //       'town': applicant.townController,
  //       'gender': applicant.gender, // Assuming gender is a field in your data
  //       'ownership': applicant.ownership,
  //       'ownership_how_long': applicant.howlongthisplaceController.text,
  //       'loan_share_name': applicant.loanapplicantname.text,
  //       'loan_share_percent': applicant.loanapplicantpercentage.text,
  //       // 'documents': documentPaths,
  //       'kin_attributes': {
  //         'name': employmentdetails.nameController.text,
  //         'other_names': employmentdetails.otherNamesController.text,
  //         'physical_address':
  //             employmentdetails.physicalAddressControllernextofkin.text,
  //         'postal_address':
  //             employmentdetails.postalAddressControllerforKline.text,
  //         'phone_number': employmentdetails.cellNumberController.text,
  //         'email': employmentdetails.emailAddressController.text,
  //       },
  //       'occupation_attributes': {
  //         'job_title': employmentdetails.jobTitleController.text,
  //         'ministry': employmentdetails.ministryController.text,
  //         'physical_address':
  //             employmentdetails.physicalAddressControlleremployment.text,
  //         'postal_address':
  //             employmentdetails.postalAddressControllerEmployment.text,
  //         'town': employmentdetails.townController,
  //         'province': employmentdetails.provinceController,
  //         'gross_salary': employmentdetails.grossSalaryController.text,
  //         'net_salary': employmentdetails.currentNetSalaryController.text,
  //         'salary_scale': employmentdetails.salaryScaleController,
  //         'retirement_year':
  //             employmentdetails.preferredYearOfRetirementController,
  //         'employer_number': employmentdetails.employeeNumberController.text,
  //         'years_of_service': employmentdetails.yearsInEmploymentController,
  //         'employment_type': employmentdetails.employmentType,
  //         'expiry_date': employmentdetails.expiryDateController.text,
  //         'employer_email': employmentdetails.emailAddressController.text,
  //         'employer_name': employmentdetails.nameController.text,
  //         'employer_other_names': employmentdetails.otherNamesController.text,
  //         'employer_cell_number': employmentdetails.cellNumberController.text,
  //         'current_net_salary':
  //             employmentdetails.currentNetSalaryController.text,
  //         'temp_expiry_date': employmentdetails.temperoryexpirydate.text,
  //         'preferred_retirement_year':
  //             employmentdetails.preferredYearOfRetirementController,
  //       },
  //     };
  //   }));

  //   // Send the request
  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // Request was successful
  //       print('Form submitted successfully');
  //       setState(() {
  //         isloadiing = false;
  //       });
  //       warning('Form Submitted');
  //       // clearAllFields();
  //       Future.delayed(Duration(seconds: 3), () {
  //         html.window.location.reload();
  //       });
  //     } else {
  //       // Request failed
  //       print('Form submission failed with status: ${response.statusCode}');
  //       setState(() {
  //         isloadiing = false;
  //       });
  //       warning('Error: Cannot Submit Form');
  //     }
  //   } catch (e) {
  //     print('Error submitting form: $e');
  //     warning('Error: Cannot Submit Form');
  //   }
  // }

  warning(
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: MediaQuery.of(context).size.width * .7,
        backgroundColor: whitefont,
        duration: Duration(seconds: 5),
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

  void clearAllFields() {
    // Clear fields of ApplicantDetails
    widget.myTabController.applicants.clear();

    // Clear fields of LoanDetails
    widget.myTabController.loanDetails.dispose();

    // Clear fields of EmployemntandKlinDetails
    widget.myTabController.employmentDetailsList.clear();
  }
}
