import 'package:flutter/material.dart';

class EmployemntandKlinDetails {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController ministryController = TextEditingController();
  TextEditingController physicalAddressControlleremployment =
      TextEditingController();
  TextEditingController physicalAddressControllernextofkin =
      TextEditingController();
  TextEditingController postalAddressControllerEmployment =
      TextEditingController();
  TextEditingController postalAddressControllerforKline =
      TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController grossSalaryController = TextEditingController();
  TextEditingController netSalaryController = TextEditingController();
  TextEditingController salaryScaleController = TextEditingController();
  TextEditingController retirementYearController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  TextEditingController yearsInEmploymentController = TextEditingController();
  String employmentType = '';
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otherNamesController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController currentNetSalaryController = TextEditingController();
  TextEditingController temperoryexpirydate = TextEditingController();
  TextEditingController preferredYearOfRetirementController =
      TextEditingController();

  void dispose() {
    jobTitleController.dispose();
    ministryController.dispose();
    physicalAddressControlleremployment.dispose();
    physicalAddressControllernextofkin.dispose();
    postalAddressControllerEmployment.dispose();
    postalAddressControllerforKline.dispose();
    townController.dispose();
    provinceController.dispose();
    grossSalaryController.dispose();
    netSalaryController.dispose();
    salaryScaleController.dispose();
    retirementYearController.dispose();
    employeeNumberController.dispose();
    yearsInEmploymentController.dispose();
    expiryDateController.dispose();
    nameController.dispose();
    otherNamesController.dispose();
    cellNumberController.dispose();
    emailAddressController.dispose();
    currentNetSalaryController.dispose();
    temperoryexpirydate.dispose();
    preferredYearOfRetirementController.dispose();
  }
}
