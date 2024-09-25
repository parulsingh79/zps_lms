*&---------------------------------------------------------------------*
*& Report ZPS_LMS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zps_lms.

INCLUDE zps_lms_data.
INCLUDE zps_lms_ss.
INCLUDE zps_lms_subroutines.

AT SELECTION-SCREEN.

  CASE sy-ucomm.

    WHEN 'APPLVL'.
      PERFORM apply_leave.

    WHEN 'VIEWBTN'.
      MESSAGE 'This is for HR only' TYPE 'I'.
      PERFORM hr_cred.

    WHEN 'PRNTBTN'.
      PERFORM print_form.

  ENDCASE.
