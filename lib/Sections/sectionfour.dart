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

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            CustomText(
              text: 'Part 1 ',
              color: blackfont,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 5,
            ),
            CustomText(
              text: 'Applicant Details',
              color: primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 20,
            ),
            applicantDetails(myTabController, 0),
            if (numberOfPersons > 1) applicantDetails(myTabController, 1),
            if (numberOfPersons > 2) applicantDetails(myTabController, 2),
            if (numberOfPersons > 3) applicantDetails(myTabController, 3),

            // Display other details as needed

            // Display details from Section Two
            CustomText(
              text: 'Part 2',
              color: blackfont,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 5,
            ),
            CustomText(
              text: 'Employment Details',
              color: primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 20,
            ),
            employmentDetals(myTabController, 0),
            if (numberOfPersons > 1) employmentDetals(myTabController, 1),
            if (numberOfPersons > 2) employmentDetals(myTabController, 2),
            if (numberOfPersons > 3) employmentDetals(myTabController, 3),
            CustomText(
              text: 'Part 3',
              color: blackfont,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 5,
            ),
            CustomText(
              text: 'Loan Details',
              color: primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 20,
            ),
            loanDetails(myTabController),
            SizedBox(
              height: 20,
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
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(15))),
                      onPressed: () {
                        //printApplicantDetails();

                        widget._tabController
                            .animateTo(widget._tabController.index - 1);

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
                        sendLoanRequest(myTabController.numberOfPersons);
                      },
                      child: CustomText(
                        text: 'Submit',
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
    );
  }

  Container applicantDetails(MyTabController myTabController, int i) {
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
            CustomText(
              text: 'Applicant ${i + 1}',
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                CustomText(
                  text:
                      'Surname: ${myTabController.applicants[i].surnameController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'Middle Name: ${myTabController.applicants[i].middleNameController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'First Name: ${myTabController.applicants[i].firstNameController.text}',
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                CustomText(
                  text: myTabController.applicants[i].gender == null
                      ? 'Gender:'
                      : 'Gender: ${myTabController.applicants[i].gender}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'Date of Birth: ${myTabController.applicants[i].dobController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'NRC Number: ${myTabController.applicants[i].nrcController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                CustomText(
                  text:
                      'Telephone: ${myTabController.applicants[i].telephoneController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'Mobile: ${myTabController.applicants[i].mobileController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'Email: ${myTabController.applicants[i].emailController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                CustomText(
                  text:
                      'Driving Licnese Number: ${myTabController.applicants[i].licenseNumberController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'Licnese Exp Date: ${myTabController.applicants[i].licenseExpiryController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                CustomText(
                  text:
                      'Resedential Address: ${myTabController.applicants[i].residentialAddressController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text: myTabController.applicants[i].ownership == null
                      ? 'Ownership:'
                      : 'Ownership: ${myTabController.applicants[i].ownership}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'How long this place: ${myTabController.applicants[i].howlongthisplaceController.text}',
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                CustomText(
                  text:
                      'Postal Address: ${myTabController.applicants[i].postalAddressController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text: myTabController.applicants[i].townController == null
                      ? 'Town:'
                      : 'Town: ${myTabController.applicants[i].townController}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text: myTabController.applicants[i].provinceController == null
                      ? 'Province'
                      : 'Province: ${myTabController.applicants[i].provinceController}',
                ),
              ],
            ),
            if (widget.myTabController.applicants[i].selectedFiles.isNotEmpty)
              Container(
                  width: MediaQuery.of(context).size.width * .7,
                  height: 120,
                  child: Row(
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
          ]),
    );
  }

  Container employmentDetals(MyTabController myTabController, int i) {
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
        decoration: BoxDecoration(
            color: Color.fromARGB(80, 242, 254, 187),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: 'Employment Details Applicant: ${i + 1}',
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  CustomText(
                    text:
                        'Job Title: ${myTabController.employmentDetailsList[i].jobTitleController.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    text:
                        'Ministry: ${myTabController.employmentDetailsList[i].ministryController.text}',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  CustomText(
                    text:
                        'Physical Address: ${myTabController.employmentDetailsList[i].physicalAddressControlleremployment.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    text:
                        'Postal Address: ${myTabController.employmentDetailsList[i].postalAddressControllerEmployment.text}',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  CustomText(
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
                    text: myTabController
                                .employmentDetailsList[i].provinceController ==
                            null
                        ? 'Province:'
                        : 'Province: ${myTabController.employmentDetailsList[i].provinceController}',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  CustomText(
                    text:
                        'Gross Salary: ${myTabController.employmentDetailsList[i].grossSalaryController.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
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
                    text: myTabController.employmentDetailsList[i]
                                .salaryScaleController ==
                            null
                        ? 'Salary Scale:'
                        : 'Salary Scale: ${myTabController.employmentDetailsList[i].salaryScaleController}',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  CustomText(
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
                    text:
                        'Employee Number: ${myTabController.employmentDetailsList[i].employeeNumberController.text}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  CustomText(
                    text: myTabController.employmentDetailsList[i]
                                .yearsInEmploymentController ==
                            null
                        ? 'Years in Employemnt'
                        : 'Years in Employemnt: ${myTabController.employmentDetailsList[i].yearsInEmploymentController}',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  CustomText(
                    text:
                        'Employemnt Type: ${myTabController.employmentDetailsList[i].employmentType}',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  if (myTabController.employmentDetailsList[i].employmentType ==
                      'Temporary')
                    CustomText(
                      text:
                          'Expiry Date: ${myTabController.employmentDetailsList[i].expiryDateController.text}',
                    ),
                ],
              )
            ]));
  }

  Container loanDetails(MyTabController myTabController) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(80, 199, 193, 185),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: myTabController.loanDetails.selectedLoanOption == null
                ? 'Loan Product Applied for:'
                : 'Loan Product Applied for: ${myTabController.loanDetails.selectedLoanOption}',
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            text:
                'Description: ${myTabController.loanDetails.descriptionController.text}',
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              CustomText(
                text:
                    'Total cost of asset: ${myTabController.loanDetails.costofasset.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text:
                    'Total Insurance Cost: ${myTabController.loanDetails.insurancecost.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text:
                    'Less Advance Payment: ${myTabController.loanDetails.advancepayment.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text:
                    'Loan Amount Applied for: ${myTabController.loanDetails.loanamaountapplied.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text: myTabController.loanDetails.tenure == null
                    ? 'Tenure:'
                    : 'Tenure: ${myTabController.loanDetails.tenure}',
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              CustomText(
                text:
                    'First Applicant: ${myTabController.loanDetails.firstapplicant.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text:
                    'First Applicant Loan Propotion: ${myTabController.loanDetails.firstapplicantproportion.text}',
              ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 1)
                CustomText(
                  text:
                      'Second Applicant: ${myTabController.loanDetails.secondapplicant.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 1)
                CustomText(
                  text:
                      'Second Applicant Loan Propotion: ${myTabController.loanDetails.secondapplicantpropotion.text}',
                ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              if (myTabController.numberOfPersons > 2)
                CustomText(
                  text:
                      'Third Applicant: ${myTabController.loanDetails.thirdapplicant.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 2)
                CustomText(
                  text:
                      'Third Applicant Loan Propotion: ${myTabController.loanDetails.thirdapplicant.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 3)
                CustomText(
                  text:
                      'Fourth Applicant: ${myTabController.loanDetails.fourthapplicant.text}',
                ),
              SizedBox(
                width: 30,
              ),
              if (myTabController.numberOfPersons > 3)
                CustomText(
                  text:
                      'Fourth Applicant Loan Propotion: ${myTabController.loanDetails.fourthapplicantpropotion.text}',
                ),
            ],
          ),
        ],
      ),
    );
  }

  void sendLoanRequest(int numberOfApplicants) async {
    final String apiUrl = 'https://loan-managment.onrender.com/loan_requests';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add JSON data as form fields
      request.fields['loan_request[description]'] = "description";
      request.fields['loan_request[cost_of_asset]'] = "2440";
      request.fields['loan_request[insurance_cost]'] = "452525";
      request.fields['loan_request[advance_payment]'] = "4646";
      request.fields['loan_request[loan_amount]'] = "2525";
      request.fields['loan_request[loan_tenure]'] = "12";
      request.fields['loan_request[product_id]'] = "3";

      for (int i = 0; i < numberOfApplicants; i++) {
        // Add other applicant data to the request
        request.fields['loan_request[applicants_attributes][$i][surname]'] =
            'Doe'; // Replace with actual surname
        request.fields['loan_request[applicants_attributes][$i][first_name]'] =
            'John'; // Replace with actual first name
        request.fields['loan_request[applicants_attributes][$i][middle_name]'] =
            'M';
        request.fields['loan_request[applicants_attributes][$i][email]'] =
            'john.doe@example.com';
        request.fields['loan_request[applicants_attributes][$i][dob]'] =
            '1990-01-01';
        request.fields['loan_request[applicants_attributes][$i][nrc]'] =
            '123456789';
        request.fields['loan_request[applicants_attributes][$i][telephone]'] =
            '123456789';
        request.fields['loan_request[applicants_attributes][$i][mobile]'] =
            '987654321';
        request.fields[
            'loan_request[applicants_attributes][$i][license_number]'] = '123';
        request.fields[
                'loan_request[applicants_attributes][$i][license_expiry]'] =
            '2023-01-01';
        request.fields[
                'loan_request[applicants_attributes][$i][residential_address]'] =
            '123 Main St';
        request.fields[
                'loan_request[applicants_attributes][$i][postal_address]'] =
            'P.O. Box 456';
        request.fields['loan_request[applicants_attributes][$i][province]'] =
            'Some Province';
        request.fields['loan_request[applicants_attributes][$i][town]'] =
            'Some Town';
        request.fields['loan_request[applicants_attributes][$i][gender]'] =
            'Female';
        request.fields['loan_request[applicants_attributes][$i][ownership]'] =
            'rented';
        request.fields[
                'loan_request[applicants_attributes][$i][ownership_how_long]'] =
            '5 years';
        request.fields[
                'loan_request[applicants_attributes][$i][loan_share_name]'] =
            'Jane Doe';
        request.fields[
                'loan_request[applicants_attributes][$i][loan_share_percent]'] =
            '50';

        // Add other applicant details as needed
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][name]'] =
            'Jane Doe';
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][other_names]'] =
            'Mary Doe';
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][physical_address]'] =
            '123 Oak St';
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][postal_address]'] =
            'P.O. Box 123';
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][phone_number]'] =
            '555-1234';
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][email]'] =
            'test@example.com';

        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][job_title]'] =
            'Software Developer';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][ministry]'] =
            'Technology';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][physical_address]'] =
            '456 Tech St';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][postal_address]'] =
            'P.O. Box 789';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][town]'] =
            'Tech Town';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][province]'] =
            'Tech Province';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][gross_salary]'] =
            '80000';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][net_salary]'] =
            '70000';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][salary_scale]'] =
            'A';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][retirement_year]'] =
            '2050';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_number]'] =
            'EMP123';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][years_of_service]'] =
            '5';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employment_type]'] =
            'permanent';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][expiry_date]'] =
            '2024-01-01';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_email]'] =
            'employer@example.com';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_name]'] =
            'Tech Company';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_other_names]'] =
            'Tech Co.';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_cell_number]'] =
            '987654321';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][current_net_salary]'] =
            '75000';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][temp_expiry_date]'] =
            '2022-12-31';
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][preferred_retirement_year]'] =
            '2045';

        // Add files as form fields
        print(widget.myTabController.applicants[i].selectedFiles.length);
        for (var file in widget.myTabController.applicants[i].selectedFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][documents][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file$i.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }
      }
      // print(request.fields);
      var response = await request.send();

      if (response.statusCode == 200) {
        print("Loan request sent successfully");
        print(await response.stream.bytesToString());
      } else {
        print("Failed to send loan request");
        print(response.statusCode);
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> submitsForm(MyTabController myTabController) async {
    // Prepare the API endpoint URL
    final apiUrl = 'https://loan-managment.onrender.com/loan_requests';

    // Prepare the headers (bearer token)
    final headers = {'Authorization': 'Bearer your_bearer_token_here'};

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..headers.addAll(headers);

    // Add form fields
    request.fields['loan_request[description]'] =
        myTabController.loanDetails.descriptionController.text;
    request.fields['loan_request[cost_of_asset]'] =
        myTabController.loanDetails.costofasset.text;
    request.fields['loan_request[insurance_cost]'] =
        myTabController.loanDetails.insurancecost.text;
    request.fields['loan_request[advance_payment]'] =
        myTabController.loanDetails.advancepayment.text;
    request.fields['loan_request[loan_amount]'] =
        myTabController.loanDetails.loanamaountapplied.text;
    request.fields['loan_request[loan_tenure]'] =
        myTabController.loanDetails.tenure!;
    request.fields['loan_request[product_id]'] =
        myTabController.loanDetails.selectedLoanOption.toString();

    // Add form fields for 'applicants_attributes'
    request.fields['loan_request[applicants_attributes]'] = jsonEncode(
        List.generate(widget.myTabController.numberOfPersons, (index) {
      var applicant = myTabController.applicants[index];
      var employmentdetails = myTabController.employmentDetailsList[index];
      // Extract file paths from PlatformFile objects
      // List<String> documentPaths =
      //     applicant.selectedFiles.map((file) => file.path!).toList();

      return {
        'surname': applicant.surnameController.text,
        'first_name': applicant.firstNameController.text,
        'middle_name': applicant.middleNameController.text,
        'email': applicant.emailController.text,
        'dob': applicant.dobController.text,
        'nrc': applicant.nrcController.text,
        'telephone': applicant.telephoneController.text,
        'mobile': applicant.mobileController.text,
        'license_number': applicant.licenseNumberController.text,
        'license_expiry': applicant.licenseExpiryController.text,
        'residential_address': applicant.residentialAddressController.text,
        'postal_address': applicant.postalAddressController.text,
        'province': applicant.provinceController,
        'town': applicant.townController,
        'gender': applicant.gender, // Assuming gender is a field in your data
        'ownership': applicant.ownership,
        'ownership_how_long': applicant.howlongthisplaceController.text,
        'loan_share_name': applicant.loanapplicantname.text,
        'loan_share_percent': applicant.loanapplicantpercentage.text,
        // 'documents': documentPaths,
        'kin_attributes': {
          'name': employmentdetails.nameController.text,
          'other_names': employmentdetails.otherNamesController.text,
          'physical_address':
              employmentdetails.physicalAddressControllernextofkin.text,
          'postal_address':
              employmentdetails.postalAddressControllerforKline.text,
          'phone_number': employmentdetails.cellNumberController.text,
          'email': employmentdetails.emailAddressController.text,
        },
        'occupation_attributes': {
          'job_title': employmentdetails.jobTitleController.text,
          'ministry': employmentdetails.ministryController.text,
          'physical_address':
              employmentdetails.physicalAddressControlleremployment.text,
          'postal_address':
              employmentdetails.postalAddressControllerEmployment.text,
          'town': employmentdetails.townController,
          'province': employmentdetails.provinceController,
          'gross_salary': employmentdetails.grossSalaryController.text,
          'net_salary': employmentdetails.currentNetSalaryController.text,
          'salary_scale': employmentdetails.salaryScaleController,
          'retirement_year':
              employmentdetails.preferredYearOfRetirementController,
          'employer_number': employmentdetails.employeeNumberController.text,
          'years_of_service': employmentdetails.yearsInEmploymentController,
          'employment_type': employmentdetails.employmentType,
          'expiry_date': employmentdetails.expiryDateController.text,
          'employer_email': employmentdetails.emailAddressController.text,
          'employer_name': employmentdetails.nameController.text,
          'employer_other_names': employmentdetails.otherNamesController.text,
          'employer_cell_number': employmentdetails.cellNumberController.text,
          'current_net_salary':
              employmentdetails.currentNetSalaryController.text,
          'temp_expiry_date': employmentdetails.temperoryexpirydate.text,
          'preferred_retirement_year':
              employmentdetails.preferredYearOfRetirementController,
        },
      };
    }));

    // Send the request
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Request was successful
        print('Form submitted successfully');
      } else {
        // Request failed
        print('Form submission failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting form: $e');
    }
  }
}
