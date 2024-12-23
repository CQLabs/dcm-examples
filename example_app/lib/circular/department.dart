import 'package:flutter/material.dart';

import 'employee.dart';

class Department {
  const Department();

  void getEmployeeDetails() {
    debugPrint("Department accesses employee details");
    const Employee().getDepartmentDetails();
  }
}
