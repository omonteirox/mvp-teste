@EndUserText.label : 'BP Source Fields - Value Help'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #C
@AbapCatalog.dataMaintenance : #ALLOWED
define table zdez_bp_srcfld {

  key client     : abap.clnt not null;
  key field_name : abap.char(60) not null;
      field_label : abap.char(100);
      field_type  : abap.char(20);
      field_length : abap.int4;

}
