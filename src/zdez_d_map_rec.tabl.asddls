@EndUserText.label : 'BP Field Mapping - Recipient (Draft)'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdez_d_map_rec {

  key client            : abap.clnt not null;
  key recipient_uuid    : sysuuid_x16 not null;
      recipient_id      : abap.char(20);
      recipient_name    : abap.char(100);
      description       : abap.char(255);
      source_entity     : abap.char(30);
      is_active         : abap_boolean;
      created_by        : syuname;
      created_at        : timestampl;
      last_changed_by   : syuname;
      last_changed_at   : timestampl;
      local_last_changed_at : timestampl;
      "%admin"          : include sych_bdl_draft_admin_inc;

}
