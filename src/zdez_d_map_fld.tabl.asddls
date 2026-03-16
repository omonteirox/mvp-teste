@EndUserText.label : 'BP Field Mapping - Field Map (Draft)'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdez_d_map_fld {

  key mandt             : abap.clnt not null;
  key fielduuid         : sysuuid_x16 not null;
      parentuuid        : sysuuid_x16 not null;
      sourcefieldname   : abap.char(60);
      targetfieldname   : abap.char(100);
      isactive          : abap_boolean;
      createdby         : syuname;
      createdat         : timestampl;
      lastchangedby     : syuname;
      lastchangedat     : timestampl;
      locallastchangedat : timestampl;
      "%admin"          : include sych_bdl_draft_admin_inc;

}
