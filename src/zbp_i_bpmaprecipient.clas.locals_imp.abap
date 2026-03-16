*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* temporary implementations

CLASS lhc_recipient DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Recipient RESULT result.

    METHODS setdefaultsourceentity FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Recipient~SetDefaultSourceEntity.

    METHODS validaterecipientname FOR VALIDATE ON SAVE
      IMPORTING keys FOR Recipient~ValidateRecipientName.

    METHODS previewjson FOR MODIFY
      IMPORTING keys FOR ACTION Recipient~previewJson RESULT result.

ENDCLASS.

CLASS lhc_recipient IMPLEMENTATION.

  METHOD get_global_authorizations.
    result = VALUE #( ( %tky    = VALUE #( )
                        %create = if_abap_behv=>auth-allowed
                        %update = if_abap_behv=>auth-allowed
                        %delete = if_abap_behv=>auth-allowed ) ).
  ENDMETHOD.

  METHOD setdefaultsourceentity.
    READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY Recipient
        FIELDS ( SourceEntity IsActive )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_recipients).

    MODIFY ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY Recipient
        UPDATE FIELDS ( SourceEntity IsActive )
        WITH VALUE #( FOR ls_rec IN lt_recipients
          WHERE ( SourceEntity IS INITIAL ) (
            %tky         = ls_rec-%tky
            SourceEntity = 'I_BusinessPartner'
            IsActive     = abap_true
          ) )
      REPORTED DATA(lt_reported).
  ENDMETHOD.

  METHOD validaterecipientname.
    READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY Recipient
        FIELDS ( RecipientName )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_recipients).

    LOOP AT lt_recipients INTO DATA(ls_rec).
      IF ls_rec-RecipientName IS INITIAL.
        APPEND VALUE #(
          %tky = ls_rec-%tky
          %msg = new_message_with_text(
            text     = 'Recipient name is required'
            severity = if_abap_behv_message=>severity-error )
          %element-RecipientName = if_abap_behv=>mk-on
        ) TO reported-recipient.
        APPEND VALUE #( %tky = ls_rec-%tky ) TO failed-recipient.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD previewjson.
    " 1. Read recipient
    READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY Recipient
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_recipients).

    " 2. Read all field mappings for the recipient(s)
    READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY Recipient BY \_FieldMapping
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_mappings).

    LOOP AT lt_recipients INTO DATA(ls_rec).
      " 3. Get BP number from the action parameter
      DATA(ls_key) = keys[ KEY draft %tky = ls_rec-%tky ].
      DATA(lv_bp) = ls_key-%param-BusinessPartner.

      " 4. Build the JSON preview
      DATA(lv_json) = `{` && cl_abap_char_utilities=>cr_lf.

      IF lv_bp IS NOT INITIAL.
        SELECT SINGLE *
          FROM I_BusinessPartner
          WHERE BusinessPartner = @lv_bp
          INTO @DATA(ls_bp).

        IF sy-subrc = 0.
          " Loop through active mappings and build JSON
          DATA(lv_first) = abap_true.
          LOOP AT lt_mappings INTO DATA(ls_map)
            WHERE ParentUUID = ls_rec-RecipientUUID
              AND IsActive   = abap_true.

            IF lv_first = abap_false.
              lv_json = lv_json && `,` && cl_abap_char_utilities=>cr_lf.
            ENDIF.
            lv_first = abap_false.

            " Resolve source field value from the BP record
            DATA(lv_value) = ``.
            CASE ls_map-SourceFieldName.
              WHEN 'BusinessPartner'.
                lv_value = ls_bp-BusinessPartner.
              WHEN 'BusinessPartnerName'.
                lv_value = ls_bp-BusinessPartnerName.
              WHEN 'BusinessPartnerFullName'.
                lv_value = ls_bp-BusinessPartnerFullName.
              WHEN 'FirstName'.
                lv_value = ls_bp-FirstName.
              WHEN 'LastName'.
                lv_value = ls_bp-LastName.
              WHEN 'BusinessPartnerCategory'.
                lv_value = ls_bp-BusinessPartnerCategory.
              WHEN 'OrganizationBPName1'.
                lv_value = ls_bp-OrganizationBPName1.
              WHEN 'OrganizationBPName2'.
                lv_value = ls_bp-OrganizationBPName2.
              WHEN 'SearchTerm1'.
                lv_value = ls_bp-SearchTerm1.
              WHEN 'SearchTerm2'.
                lv_value = ls_bp-SearchTerm2.
              WHEN 'Industry'.
                lv_value = ls_bp-Industry.
              WHEN 'Language'.
                lv_value = ls_bp-Language.
              WHEN 'Customer'.
                lv_value = ls_bp-Customer.
              WHEN 'Supplier'.
                lv_value = ls_bp-Supplier.
              WHEN 'BusinessPartnerIsBlocked'.
                lv_value = COND #( WHEN ls_bp-BusinessPartnerIsBlocked = abap_true
                                   THEN 'true' ELSE 'false' ).
              WHEN 'BusinessPartnerType'.
                lv_value = ls_bp-BusinessPartnerType.
              WHEN 'LegalForm'.
                lv_value = ls_bp-LegalForm.
              WHEN 'CorrespondenceLanguage'.
                lv_value = ls_bp-CorrespondenceLanguage.
              WHEN 'MiddleName'.
                lv_value = ls_bp-MiddleName.
              WHEN OTHERS.
                lv_value = '(field not mapped)'.
            ENDCASE.

            CONDENSE lv_value.
            lv_json = lv_json
              && `  "` && ls_map-TargetFieldName && `": "`
              && lv_value && `"`.
          ENDLOOP.

        ELSE.
          lv_json = lv_json && `  "error": "BP ` && lv_bp && ` not found"`.
        ENDIF.
      ELSE.
        lv_json = lv_json && `  "error": "No Business Partner number provided"`.
      ENDIF.

      lv_json = lv_json && cl_abap_char_utilities=>cr_lf && `}`.

      " 5. Return the result
      APPEND VALUE #(
        %tky   = ls_rec-%tky
        %param = VALUE za_bppreviewjsonresult(
          BusinessPartner = lv_bp
          JsonPreview     = lv_json )
      ) TO result.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

**********************************************************************
* Child entity handler: FieldMapping
**********************************************************************
CLASS lhc_fieldmapping DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setfielddefaults FOR DETERMINE ON MODIFY
      IMPORTING keys FOR FieldMapping~SetFieldDefaults.

    METHODS validatetargetfieldname FOR VALIDATE ON SAVE
      IMPORTING keys FOR FieldMapping~ValidateTargetFieldName.

    METHODS validateduplicatesourcefield FOR VALIDATE ON SAVE
      IMPORTING keys FOR FieldMapping~ValidateDuplicateSourceField.

ENDCLASS.

CLASS lhc_fieldmapping IMPLEMENTATION.

  METHOD setfielddefaults.
    READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY FieldMapping
        FIELDS ( IsActive )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fields).

    MODIFY ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY FieldMapping
        UPDATE FIELDS ( IsActive )
        WITH VALUE #( FOR ls_fld IN lt_fields
          WHERE ( IsActive IS INITIAL ) (
            %tky     = ls_fld-%tky
            IsActive = abap_true
          ) )
      REPORTED DATA(lt_reported).
  ENDMETHOD.

  METHOD validatetargetfieldname.
    READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY FieldMapping
        FIELDS ( TargetFieldName )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fields).

    LOOP AT lt_fields INTO DATA(ls_fld).
      IF ls_fld-TargetFieldName IS INITIAL.
        APPEND VALUE #(
          %tky = ls_fld-%tky
          %msg = new_message_with_text(
            text     = 'Target field name is required'
            severity = if_abap_behv_message=>severity-error )
          %element-TargetFieldName = if_abap_behv=>mk-on
        ) TO reported-fieldmapping.
        APPEND VALUE #( %tky = ls_fld-%tky ) TO failed-fieldmapping.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateduplicatesourcefield.
    READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
      ENTITY FieldMapping
        FIELDS ( ParentUUID SourceFieldName )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_fields).

    " Collect parent UUIDs to read all sibling mappings
    DATA lt_parent_uuids TYPE SORTED TABLE OF sysuuid_x16 WITH UNIQUE KEY table_line.
    LOOP AT lt_fields INTO DATA(ls_fld_tmp).
      INSERT ls_fld_tmp-ParentUUID INTO TABLE lt_parent_uuids.
    ENDLOOP.

    " Read all field mappings for the involved parents
    DATA lt_all_fields TYPE TABLE OF zi_bpmapfield.
    IF lt_parent_uuids IS NOT INITIAL.
      READ ENTITIES OF zi_bpmaprecipient IN LOCAL MODE
        ENTITY Recipient BY \_FieldMapping
          FIELDS ( FieldUUID SourceFieldName )
          WITH VALUE #( FOR lv_uuid IN lt_parent_uuids (
            %tky-RecipientUUID = lv_uuid
          ) )
        RESULT lt_all_fields.
    ENDIF.

    " Check for duplicates
    LOOP AT lt_fields INTO DATA(ls_fld).
      IF ls_fld-SourceFieldName IS INITIAL.
        CONTINUE.
      ENDIF.

      DATA(lv_count) = 0.
      LOOP AT lt_all_fields INTO DATA(ls_all)
        WHERE ParentUUID      = ls_fld-ParentUUID
          AND SourceFieldName = ls_fld-SourceFieldName.
        lv_count = lv_count + 1.
      ENDLOOP.

      IF lv_count > 1.
        APPEND VALUE #(
          %tky = ls_fld-%tky
          %msg = new_message_with_text(
            text     = |Source field '{ ls_fld-SourceFieldName }' is already mapped in this recipient|
            severity = if_abap_behv_message=>severity-error )
          %element-SourceFieldName = if_abap_behv=>mk-on
        ) TO reported-fieldmapping.
        APPEND VALUE #( %tky = ls_fld-%tky ) TO failed-fieldmapping.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
