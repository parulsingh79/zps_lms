*&---------------------------------------------------------------------*
*& Include          ZPS_LMS_SUBROUTINES
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form apply_leave
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM apply_leave .

  IF p_empid IS INITIAL OR p_ename IS INITIAL OR p_ltype IS INITIAL OR
     p_sdate IS INITIAL OR p_edate IS INITIAL.
    MESSAGE 'Please fill all the fields.' TYPE 'E'.
  ELSE.

    wa_leave-emp_id = p_empid.
    wa_leave-emp_name = p_ename.
    wa_leave-leave_type = p_ltype.
    wa_leave-start_date = p_sdate.
    wa_leave-end_date = p_edate.
    wa_leave-sy_datum = sy-datum.
    wa_leave-sy_uzeit = sy-uzeit.
    wa_leave-status = 'Pending'.

    INSERT INTO zps_edata_lms VALUES wa_leave.
    COMMIT WORK.

    IF sy-subrc = 0.

      CONCATENATE 'Leave Applied from'  p_sdate 'to' p_edate INTO lv_popup SEPARATED BY ' '.

      CALL FUNCTION 'POPUP_TO_DISPLAY_TEXT'
        EXPORTING
*         TITEL     = ' '
          textline1 = lv_popup.

      MESSAGE 'Leave applied successfully.' TYPE 'S'.

    ELSE .
      MESSAGE 'Error applying leave' TYPE 'E'.

    ENDIF.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form VIEW_REPORT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fieldcat .

  REFRESH lt_fieldcat.

  ls_fieldcat-col_pos = 1.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'emp_id'.
  ls_fieldcat-seltext_s = 'Employee Id'.
  ls_fieldcat-tabname = 'lt_leave'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = 2.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'emp_name'.
  ls_fieldcat-seltext_s = 'Employee NAme'.
  ls_fieldcat-tabname = 'lt_leave'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = 3.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'leave_type'.
  ls_fieldcat-seltext_s = 'Leave Type'.
  ls_fieldcat-tabname = 'lt_leave'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = 4.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'Start_date'.
  ls_fieldcat-seltext_s = 'Start Date'.
  ls_fieldcat-tabname = 'lt_leave'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = 5.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'End_date'.
  ls_fieldcat-seltext_s = 'End Date'.
  ls_fieldcat-tabname = 'lt_leave'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = 6.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'sy_uzeit'.
  ls_fieldcat-seltext_s = 'Applied Time'.
  ls_fieldcat-tabname = 'lt_leave'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = 7.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'sy_datum'.
  ls_fieldcat-seltext_s = 'Applied Date'.
  ls_fieldcat-tabname = 'lt_leave'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

  ls_fieldcat-col_pos = 8.
  ls_fieldcat-row_pos = 1.
  ls_fieldcat-fieldname = 'Status'.
  ls_fieldcat-seltext_s = 'Status'.
  ls_fieldcat-tabname = 'lt_leave'.
*  ls_fieldcat-edit    = 'X'.
  APPEND ls_fieldcat TO lt_fieldcat.
  CLEAR ls_fieldcat.

ENDFORM.

FORM view_report.

  SELECT * FROM zps_edata_lms INTO TABLE lt_leave WHERE status = 'Pending'.
  PERFORM fieldcat.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fieldcat
    TABLES
      t_outtab           = lt_leave.
  IF sy-subrc <> 0.
* Implement suitable eror handling here
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form HR_CRED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*



FORM hr_cred .

* LOOP AT SCREEN.
*    IF screen-group1 = 'P_hrpwd'.
*      screen-invisible = '1'. " Makes password invisible (***)
*      screen-active = '1'.
*      MODIFY SCREEN.
*    ENDIF.
*  ENDLOOP.

  CALL SELECTION-SCREEN 2000 STARTING AT 10 10.
  IF p_hrid = '52096532' AND p_hrpwd = 'PARUL#7976'.

    IF sy-subrc = 0.
      PERFORM view_report.
    ENDIF.
  ELSE.
    MESSAGE ' You are not authorized to view the report' TYPE 'E' DISPLAY LIKE 'I'.
  ENDIF.



PERFORM approve_leave.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form approve_leave
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM approve_leave .
 IF lt_leave is not INITIAL.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar      = 'Leave Application'
      text_question = 'Do you want to approve this request'
    IMPORTING
      answer        = lv_status.

  IF lv_status = 1.
    UPDATE zps_edata_lms SET status = 'Approved' .
    COMMIT WORK.
    MESSAGE 'The request has been approved' type 'S'.
  ELSE.
    UPDATE zps_edata_lms SET status = 'Rejected' .
     COMMIT WORK.
     MESSAGE 'The request has been rejected' type 'E'.
  ENDIF.

  else.
    MESSAGE 'Nothing is Pending' type 'I'.
 ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form print_form
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM print_form .

  Data : lv_fname type RS38L_FNAM.

  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname                 = 'ZPS_SF_LMS'
*     VARIANT                  = ' '
*     DIRECT_CALL              = ' '
   IMPORTING
     FM_NAME                  =  lv_fname
   EXCEPTIONS
     NO_FORM                  = 1
     NO_FUNCTION_MODULE       = 2
     OTHERS                   = 3
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

CALL FUNCTION lv_fname
  EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
    p_ename                    = p_ename
    p_empid                    = p_empid
    p_ltype                    = p_ltype
    p_sdate                    = p_sdate
    p_edate                    = p_edate
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
* EXCEPTIONS
*   FORMATTING_ERROR           = 1
*   INTERNAL_ERROR             = 2
*   SEND_ERROR                 = 3
*   USER_CANCELED              = 4
*   OTHERS                     = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


ENDFORM.
