@EndUserText.label : 'BP Field Mapping - Field Map'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdez_map_field {

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

}
