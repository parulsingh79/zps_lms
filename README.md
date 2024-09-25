# zps_lms
# Leave Management System (LMS) in SAP ABAP
  This repository contains an SAP ABAP executable program for a Leave Management System (LMS). The system allows employees to apply for leave, view leave status, and print leave 
  applications using Smart Forms. HR users have additional privileges to approve or reject leave applications and view employee leave records in an ALV report.

# Overview
The Leave Management System (LMS) is designed to handle employee leave requests in a simple yet effective way.

Employees can: 
* Apply for leave
* View the status of their leave applications
* Print the leave form
  
HR users can:
* View employee leave records
* Approve or reject leave applications
* This solution is built using ABAP and ALV for report display, Smart Forms for generating leave forms, and pop-up confirmation messages.

# Features
* Apply Leave: Employees can submit a leave application by providing their details, leave type, and date range.
* View Leave Records: HR users can view all pending leave applications in an editable ALV grid.
* Approve/Reject Leave: HR can approve or reject pending leave requests via a confirmation pop-up.
* Print Leave Form: Employees can print the details of their leave application using SAP Smart Forms.
* Authorization: HR access is restricted using a simple login screen (ID and password).

 # Prerequisites
Ensure that the following SAP objects are created and properly configured before running the program:

* Custom Table: ZPS_EDATA_LMS for storing leave applications.
* Smart Form: ZPS_SF_LMS for generating the leave form printout.
* Function Module: Standard SAP function modules like POPUP_TO_DISPLAY_TEXT, POPUP_TO_CONFIRM, SSF_FUNCTION_MODULE_NAME, and REUSE_ALV_GRID_DISPLAY are utilized in this 
                   program.

# Program Structure
This program is divided into multiple includes for better modularity:

* Main Program (zps_lms): Entry point of the program. Handles the selection screen and user actions.
* Data (zps_lms_data): Defines the required data types, internal tables, and variables.
* Selection Screen (zps_lms_ss): Handles the input fields, buttons, and selection logic.
* Subroutines (zps_lms_subroutines): Contains all the logic for applying leave, viewing reports, printing forms, and handling HR credentials.

# Main Program Flow
* AT SELECTION-SCREEN: Handles the user's selection (Apply Leave, View, Print) and navigates to the respective subroutine.
* Selection Screen (2000): HR login screen for viewing and approving leave applications.
* Main Operations: Includes:
    * apply_leave: Handles leave applications.
    * view_report: HR view of leave records using ALV grid.
    * approve_leave: HR approval/rejection of leave requests.
    * print_form: Prints the leave application form using Smart Forms.

# How to Use
 * Apply Leave:
       * Fill in the employee ID, employee name, leave type, start date, and end date.
       * Click the "Apply Leave" button.
       * If successful, the leave application is saved, and a confirmation pop-up is displayed.

* View Leave (HR Only):
      * HR users should log in with valid credentials (HR ID and password).
     * After login, HR can view all pending leave applications in the ALV report.
       
* Approve/Reject Leave:
      * HR can select a leave application and approve/reject it via a pop-up confirmation dialog.
  
 * Print Leave:
     * Employees can print the details of their leave request by clicking the "Print Form" button.
  
# Important Functions Modules
* POPUP_TO_DISPLAY_TEXT: Displays a confirmation message after applying leave.
* POPUP_TO_CONFIRM: Asks for confirmation when approving or rejecting a leave application.
* SSF_FUNCTION_MODULE_NAME: Retrieves the function module for the Smart Form.
* REUSE_ALV_GRID_DISPLAY: Displays leave records in an ALV report for HR review.

 # Smart Form
 The Smart Form ZPS_SF_LMS is used to generate a formatted leave application printout. Ensure the Smart Form is created and activated in the system before running the 
  program.

  # screenshots-

* Main Screen -
![image](https://github.com/user-attachments/assets/257a50cd-1b18-4b26-8ca6-8e825901ce3e)

* After Apply Leave (here data get stored in custom database table)-
![image](https://github.com/user-attachments/assets/11f033bc-fe7c-4e84-9d93-2cada10cec1f)

* After Clicking Print Form -
![image](https://github.com/user-attachments/assets/14da9beb-75a4-4ffd-ba8f-b67584f3728f)


* After Clicking View Report (There isn't mandatory to fill the employee details can directly view reports)-
  ![image](https://github.com/user-attachments/assets/83c5324c-5beb-4a9c-8642-1dc9ebb1aa6f)

* For Authorization -
  ![image](https://github.com/user-attachments/assets/e7a594d6-265c-476c-9818-1388a567ae27)

* ALV will Display data for those the status is Pending :
  ![image](https://github.com/user-attachments/assets/7211a81d-075e-469e-b7e1-f343bf4f17f2)

* POP-UP TO approve or reject -
 ![image](https://github.com/user-attachments/assets/3c36a5de-adb4-4251-b758-f5dbe773dfdb)

once approving it will get save to custom table and will not be visible.

* Pop-up if there is nothing to approve or reject -
![image](https://github.com/user-attachments/assets/48124e61-b43e-41fc-9615-947feb6e9f6b)

* User can check now vis Print form once request is approved -
![image](https://github.com/user-attachments/assets/3ae90754-8f1d-483b-b388-e051066a8883)








  

