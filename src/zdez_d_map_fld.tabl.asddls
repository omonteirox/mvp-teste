@EndUserText.label : 'BP Field Mapping - Field Map (Draft)'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdez_d_map_fld {

  key client            : abap.clnt not null;
  key field_uuid        : sysuuid_x16 not null;
      parent_uuid       : sysuuid_x16 not null;
      source_field_name : abap.char(60);
      target_field_name : abap.char(100);
      is_active         : abap_boolean;
      created_by        : syuname;
      created_at        : timestampl;
      last_changed_by   : syuname;
      last_changed_at   : timestampl;
      local_last_changed_at : timestampl;
      "%admin"          : include sych_bdl_draft_admin_inc;

}
