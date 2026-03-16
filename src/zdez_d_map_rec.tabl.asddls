@EndUserText.label : 'BP Field Mapping - Recipient (Draft)'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdez_d_map_rec {

  key mandt             : abap.clnt not null;
  key recipientuuid     : sysuuid_x16 not null;
      recipientid       : abap.char(20);
      recipientname     : abap.char(100);
      description       : abap.char(255);
      sourceentity      : abap.char(30);
      isactive          : abap_boolean;
      createdby         : syuname;
      createdat         : timestampl;
      lastchangedby     : syuname;
      lastchangedat     : timestampl;
      locallastchangedat : timestampl;
      "%admin"          : include sych_bdl_draft_admin_inc;

}
