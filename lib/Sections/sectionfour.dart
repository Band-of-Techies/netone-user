// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netone_enquiry_management/constants/colors.dart';
import 'package:netone_enquiry_management/constants/text.dart';
import 'package:provider/provider.dart';
import 'package:netone_enquiry_management/main.dart';

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
              text: 'Part 1',
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
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                onPressed: () {
                  submitForm();
                },
                child: CustomText(
                  text: 'Submit',
                  color: whitefont,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
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
                text: 'Gender: ${myTabController.applicants[i].gender}',
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
                text: 'Ownership: ${myTabController.applicants[i].ownership}',
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
                text:
                    'Town: ${myTabController.applicants[i].townController.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text:
                    'Province: ${myTabController.applicants[i].provinceController.text}',
              ),
            ],
          ),
        ],
      ),
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
                  text:
                      'Town: ${myTabController.employmentDetailsList[i].townController.text}',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  text:
                      'Province: ${myTabController.employmentDetailsList[i].provinceController.text}',
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
                  text:
                      'Current Net Salary: ${myTabController.employmentDetailsList[i].currentNetSalaryController.text}',
                ),
                CustomText(
                  text:
                      'Salary Scale: ${myTabController.employmentDetailsList[i].salaryScaleController.text}',
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
                      'Preferred Year of Retirement: ${myTabController.employmentDetailsList[i].preferredYearOfRetirementController.text}',
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
                  text:
                      'Years in Employemnt: ${myTabController.employmentDetailsList[i].yearsInEmploymentController.text}',
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
                      'Employemn t Type: ${myTabController.employmentDetailsList[i].employmentType}',
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
            ),
          ]),
    );
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
            text:
                'Loan Product Applied for: ${myTabController.loanDetails.selectedLoanOption}',
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
                text: 'Tenure: ${myTabController.loanDetails.tenure.text}',
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
              CustomText(
                text:
                    'Second Applicant: ${myTabController.loanDetails.secondapplicant.text}',
              ),
              SizedBox(
                width: 30,
              ),
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
              CustomText(
                text:
                    'Third Applicant: ${myTabController.loanDetails.thirdapplicant.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text:
                    'Third Applicant Loan Propotion: ${myTabController.loanDetails.thirdapplicant.text}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text:
                    'Fourth Applicant: ${myTabController.loanDetails.fourthapplicant.text}',
              ),
              SizedBox(
                width: 30,
              ),
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

  Future<void> submitForm() async {
    // Prepare the API endpoint URL
    final apiUrl = 'https://loan-managment.onrender.com/loan_requests';

    // Prepare the headers (bearer token)
    final headers = {'Authorization': 'Bearer your_bearer_token_here'};

    // Prepare the request data based on the provided API format
    final requestData = {
      'loan_request': {
        'description': 'Sample description',
        'cost_of_asset': 40000.0,
        'insurance_cost': 4000.0,
        'advance_payment': 2000.0,
        'loan_amount': 45000.0,
        'loan_tenure': 12,
        'applicants_attributes':
            List.generate(widget.myTabController.numberOfPersons, (index) {
          // Sample data for each applicant
          return {
            'surname': 'New$index',
            'first_name': 'New$index',
            'middle_name': 'SampleMiddleName$index',
            'email': 'sample@.com',
            'dob': '01/01/1990',
            'nrc': '123456789$index',
            'telephone': '1234567890',
            'mobile': '9876543210',
            'license_number': 'ABCD123$index',
            'license_expiry': '01/01/2025',
            'residential_address': 'Sample Residential Address $index',
            'postal_address': 'Sample Postal Address $index',
            'province': 'Sample Province $index',
            'town': 'Sample Town $index',
            'occupation_attributes': {
              'job_title': 'Sample Job Title $index',
              'ministry': 'Sample Ministry $index',
              'physical_address': 'Sample Physical Address $index',
              'postal_address': 'Sample Postal Address $index',
              'town': 'Sample Town $index',
              'province': 'Sample Province $index',
              'gross_salary': 60000.0,
              'net_salary': 50000.0,
              'salary_scale': 'Sample Salary Scale $index',
              'retirement_year': '2030',
              'employer_number': '12345$index',
              'years_of_service': 5,
              'employment_type': 'Full-Time',
              'expiry_date': '01/01/2030',
              'employer_email': 'employer@.com',
              'employer_name': 'Sample Employer Name $index',
              'employer_other_names': 'Sample Employer Other Names $index',
              'employer_cell_number': '9876543210',
              'current_net_salary': 50000.0,
              'temp_expiry_date': '01/01/2030',
              'preferred_retirement_year': '2035',
            },
          };
        }),
      },
    };

    try {
      // Create Dio instance
      print('here');
      final dio = Dio();
      print('start');
      // Make the POST request
      final response = await dio.post(
        apiUrl,
        data: requestData,
        options: Options(headers: headers),
      );

      // Handle the response (you can customize this based on your API)
      if (response.statusCode == 200) {
        // Successful response, you can handle success here
        print('Request successful');
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors
      print('Error sending request: $error');
    }
  }
}



  /*

  Future<void> submitForm() async {
    final myTabController = Provider.of<MyTabController>(context);

    // Prepare the API endpoint URL
    final apiUrl = ' https://loan-managment.onrender.com/loan_requests';

    // Prepare the headers (bearer token)
    final headers = {'Authorization': 'Bearer your_bearer_token_here'};

    // Prepare the request data based on the provided API format
    final requestData = {
      'loan_request': {
        'description': myTabController.loanDetails.descriptionController.text,
        'cost_of_asset': myTabController.loanDetails.costofasset,
        'insurance_cost': myTabController.loanDetails.insurancecost,
        'advance_payment': myTabController.loanDetails.advancepayment,
        'loan_amount': myTabController.loanDetails.loanamaountapplied,
        'loan_tenure': myTabController.loanDetails.tenure,
        'applicants_attributes':
            List.generate(myTabController.numberOfPersons, (index) {
          final applicant = myTabController.applicants[index];
          final employmentDetails =
              myTabController.employmentDetailsList[index];

          return {
            //applicant
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
            'province': applicant.provinceController.text,
            'town': applicant.townController.text,

            'occupation_attributes': {
              //employment
              'job_title': employmentDetails.jobTitleController.text,
              'ministry': employmentDetails.ministryController.text,
              'physical_address':
                  employmentDetails.physicalAddressControlleremployment.text,
              'postal_address':
                  employmentDetails.postalAddressControllerEmployment.text,
              'town': employmentDetails.townController.text,
              'province': employmentDetails.provinceController.text,
              'gross_salary': employmentDetails.grossSalaryController.text,
              'net_salary': employmentDetails.currentNetSalaryController.text,
              'salary_scale': employmentDetails.salaryScaleController.text,
              'retirement_year':
                  employmentDetails.preferredYearOfRetirementController.text,
              'employer_number':
                  employmentDetails.employeeNumberController.text,
              'years_of_service':
                  employmentDetails.yearsInEmploymentController.text,
              'employment_type': employmentDetails.employmentType,
              'expiry_date': employmentDetails.expiryDateController.text,

              //klininfo
              'employer_email': employmentDetails.emailAddressController.text,
              'employer_name': employmentDetails.nameController.text,
              'employer_other_names':
                  employmentDetails.otherNamesController.text,
              'employer_cell_number':
                  employmentDetails.cellNumberController.text,
              'current_net_salary':
                  employmentDetails.currentNetSalaryController.text,
              'temp_expiry_date': employmentDetails.temperoryexpirydate.text,
              'preferred_retirement_year':
                  employmentDetails.preferredYearOfRetirementController.text,
            },
          };
        }),
      },
    };

    try {
      // Create Dio instance
      final dio = Dio();

      // Make the POST request
      final response = await dio.post(
        apiUrl,
        data: requestData,
        options: Options(headers: headers),
      );

      // Handle the response (you can customize this based on your API)
      if (response.statusCode == 200) {
        // Successful response, you can handle success here
        print('Request successful');
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors
      print('Error sending request: $error');
    }
  }

*/

 