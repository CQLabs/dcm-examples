import 'package:flutter/material.dart';

import 'department.dart';

class Employee {
  const Employee();

  void getDepartmentDetails() {
    debugPrint("Employee accesses department details");
    const Department().getEmployeeDetails();
  }
}
