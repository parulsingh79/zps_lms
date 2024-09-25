*&---------------------------------------------------------------------*
*& Include          ZPS_LMS_SS
*&---------------------------------------------------------------------*
SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_empid TYPE zps_edata_lms-emp_id ,
              p_ename TYPE zps_edata_lms-emp_name,
              p_ltype TYPE zps_edata_lms-leave_type,
              p_sdate TYPE zps_edata_lms-start_date,
              p_edate TYPE zps_edata_lms-end_date.
SELECTION-SCREEN : END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-004.
  SELECTION-SCREEN PUSHBUTTON /10(20) b_apply USER-COMMAND applvl.
  SELECTION-SCREEN PUSHBUTTON /10(20) b_print USER-COMMAND prntbtn.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text-003.
  PARAMETERS: s_empid TYPE zps_edata_lms-emp_id,
              s_ename TYPE zps_edata_lms-emp_name.
    SELECTION-SCREEN PUSHBUTTON /10(20) b_view USER-COMMAND viewbtn.
SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF SCREEN 2000 TITLE TEXT-001.
  PARAMETERS: p_hrid  TYPE char10,                          " HR User ID
              p_hrpwd TYPE char20 OBLIGATORY. " Password field

  SELECTION-SCREEN COMMENT /1(30) TEXT-001 MODIF ID pwd.
SELECTION-SCREEN END OF SCREEN 2000.

INITIALIZATION.
  b_apply = 'Apply leave'.
  b_view  = 'View Report'.
  b_print = 'Print Form'.
