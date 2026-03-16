@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BP Source Fields - Value Help'
@ObjectModel.usageType: {
  serviceQuality: #A,
  sizeCategory: #S,
  dataClass: #MASTER
}
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
define view entity ZI_BpSourceField
  as select from zdez_bp_srcfld as SrcField
{
  @Search.defaultSearchElement: true
  key SrcField.field_name  as FieldName,

  @Search.defaultSearchElement: true
      SrcField.field_label as FieldLabel,
      SrcField.field_type  as FieldType,
      SrcField.field_length as FieldLength
}
