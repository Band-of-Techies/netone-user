// Future<void> submitForm(MyTabController myTabController) async {
//     // Prepare the API endpoint URL
//     final apiUrl = 'https://loan-managment.onrender.com/loan_requests';
//     final bearerToken =
//         'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAzNTE2MjM1fQ.FZVD-dnnPQeGfExGNnfbb9pgDUew-O1XXbrmKkIj_9M';

//     final headers = {'Authorization': 'Bearer $bearerToken'};

//     var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
//       ..headers.addAll(headers);

//     // Create a map for the loan request
//     Map<String, dynamic> loanRequest = {
//       'description': 'descrpiton',
//       'cost_of_asset': '2440',
//       'insurance_cost': '452525',
//       'advance_payment': '4646',
//       'loan_amount': '2525',
//       'loan_tenure': '12',
//       'product_id': '3',
//       'applicants_attributes': List.generate(
//         myTabController.numberOfPersons,
//         (index) {
//           return {
//             'surname': 'Doe',
//             'first_name': 'John',
//             'middle_name': 'M',
//             'email': 'john.doe@example.com',
//             'dob': '1990-01-01',
//             'nrc': '123456789',
//             'telephone': '123456789',
//             'mobile': '987654321',
//             'license_number': 'ABC123',
//             'license_expiry': '2023-01-01',
//             'residential_address': '123 Main St',
//             'postal_address': 'P.O. Box 456',
//             'province': 'Some Province',
//             'town': 'Some Town',
//             'gender': 'Female',
//             'ownership': 'rented',
//             'ownership_how_long': '5 years',
//             'loan_share_name': 'Jane Doe',
//             'loan_share_percent': '50',
//             'documents': [],
//             'kin_attributes': {
//               'name': 'Jane Doe',
//               'other_names': 'Mary Doe',
//               'physical_address': '123 Oak St',
//               'postal_address': 'P.O. Box 123',
//               'phone_number': '555-1234',
//               'email': 'test@example.com'
//             },
//             'occupation_attributes': {
//               'job_title': 'Software Developer',
//               'ministry': 'Technology',
//               'physical_address': '456 Tech St',
//               'postal_address': 'P.O. Box 789',
//               'town': 'Tech Town',
//               'province': 'Tech Province',
//               'gross_salary': '80000',
//               'net_salary': '70000',
//               'salary_scale': 'A',
//               'retirement_year': '2050',
//               'employer_number': 'EMP123',
//               'years_of_service': '5',
//               'employment_type': 'Permanent',
//               'expiry_date': '2024-01-01',
//               'employer_email': 'employer@example.com',
//               'employer_name': 'Tech Company',
//               'employer_other_names': 'Tech Co.',
//               'employer_cell_number': '987654321',
//               'current_net_salary': '75000',
//               'temp_expiry_date': '2022-12-31',
//               'preferred_retirement_year': '2045',
//             },
//           };
//         },
//       ),
//     };